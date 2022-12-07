# This file is not really meant to run on the jupyter notebooks itself.
# For privacy and UCSD-policy reasons, the UCSD plan data, while public, shouldn't
# be freely available on the internet right now. This file assumes you have access to the actual data.
# Secondly, it's a lot of files for a github repo...
# The purpose of this file is to condense a catalog year's worth of data into one curriculum. Technically, one
# will be able to reconstruct all the plan data from here, especially since this file is public, but it's the best I can do week on week. :shrug:

#= The basic concept is as follows
Loop through courses in each curriculum:
    if there is a matching course with matching name in the catalog:
        if the prereqs all also exist in the catalog, also as prereqs to this match-course:
            ok cool, do nothing
        else:
            add the non-matched courses as prereqs to the canonical version and edit the course metadata (TBD metadata format)
    else:
        add course to catalog as the first draft of the canonical version
=#

#= Metadata:
So, as it turns out, write csv won't preserve the metadata field. Thus, we'll finesse something out of the canonical course name.
Format:
MAJORCODE1_CURR, MAJORCODE2_COLLEGE, MAJORCODE3_COLLEGE, etc
for example, MATH 20B appearing in EC26 and EC27 (too keep it short):
EC26_CURR, EC26_TH,...,EC27_CURR, EC27_TH, EC27_WA,....,
These are going to be really really really long names.
=#
using CurricularAnalytics

# HELPER FNS ----------------------
function has_match(catalog, course)
    # this could be a lot faster, tbh
    ret = false
    for potential_match in catalog
        if potential_match.name == course.name
            ret = true
            break
        end
    end
    ret
end

function add_course_copy!(catalog, course)
    copy = Course(course.name, course.credit_hours)
    push!(catalog, copy)
    copy
end

function get_course_copy(catalog, course)
    ret = 0
    for c in catalog
        if c.name == course.name
            ret = c
            break
        end
    end
    ret
end

function edit_canonical_name(addition, course)
    course.canonical_name = course.canonical_name * ",$(addition)"
end

catalog = Array{Course,1}([])
for (root, dirs, files) in walkdir("./files/massive/output2022/")
    for file in files
        println(file)
        read = read_csv(joinpath(root, file))
        if typeof(read) == DegreePlan
            curr = read.curriculum
        else
            curr = read
        end
        #Loop through courses in each curriculum:
        for course in curr.courses
            if !(has_match(catalog, course))
                # add copy of course to catalog
                copy = add_course_copy!(catalog, course)
                # edit canonical name
                edit_canonical_name("$(root[end-3:end])$(file[1:end-4])", copy)
            else
                # edit canonical name
                edit_canonical_name("$(root[end-3:end])$(file[1:end-4])", get_course_copy(catalog, course))
            end
            for (prereq_id, type) in course.requisites
                #actually get prereq, this is an id
                prereq = course_from_id(curr, prereq_id)
                if !has_match(catalog, prereq)
                    # add copy to catalog
                    add_course_copy!(catalog, prereq)
                    # edit canonical name
                    edit_canonical_name("$(root[end-3:end])$(file[1:end-4])", get_course_copy(catalog, prereq))
                else
                    # edit canonical name
                    edit_canonical_name("$(root[end-3:end])$(file[1:end-4])", get_course_copy(catalog, prereq))
                end
                # add prereq relation:
                # get matching course from catalog
                course_copy = get_course_copy(catalog, course)
                # get matching prereq from catalog
                prereq_copy = get_course_copy(catalog, prereq)
                # add prereq
                add_requisite!(prereq_copy, course_copy, type)
            end
        end
    end
end


new_curriculum = Curriculum("CONDENSED", catalog)
write_csv(new_curriculum, "./targets/condensed.csv")