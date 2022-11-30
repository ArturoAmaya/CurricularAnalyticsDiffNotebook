using CurricularAnalytics, CurricularAnalyticsDiff

function delete_prerequisite_institutional(curriculum::Curriculum, target::AbstractString, prereq::AbstractString)
    target_course = course_from_name(curriculum, target)
    prereq_course = course_from_name(curriculum, prereq)
    delete_requisite!(prereq_course, target_course)
    # if it's all good:\n,
    target_course_majors = split(target_course.canonical_name, ",")
    prereq_course_majors = split(prereq_course.canonical_name, ",")
    println()
    ret = intersect(Set(target_course_majors), Set(prereq_course_majors))
    ret = sort(collect(ret))
    if ret[1] == ""
        popfirst!(ret)
    end
    print_affected_plans(ret)
    print("Affected plans: $(length(ret))")
    return ret
    # TODO: return value instead of prints
end

function delete_course_institutional(curriculum::Curriculum, course_to_remove_name::AbstractString)
    course_to_remove = course_from_name(curriculum, course_to_remove_name)
    affected_majors = split(course_to_remove.canonical_name, ",")
    print_affected_plans(affected_majors)
    print("Affected plans: $(length(affected_majors))")
    # NOTE THIS DOESNT ACTUALLY CHANGE THE CURRICULUM OBJECT OK?
    # TODO: add return value 
    return affected_majors
end

function add_course_institutional(curriculum::Curriculum, course_name::AbstractString, credit_hours::Real, prereqs::Dict, dependencies::Dict)
    new_curriculum = add_course(curriculum, course_name, new_course_credit_hours, prereqs, dependencies)
    errors = IOBuffer()
    isvalid_curriculum(new_UCSD, errors)
    # get all the paths that depend on me
    ## first, get me
    #UCSD = read_csv("./targets/condensed.csv");
    course = course_from_name(new_curriculum, new_course_name)
    my_centrality_paths = centrality_investigator(course, new_UCSD)
    if length(my_centrality_paths) > 0
        # ok actually do stuff
        # the gist is:
        # look at all the paths that I'm a prereq for and for each path take the intersection of their majors
        ## get all the paths that depend on me:
        prereq_set = Set()
        dep_set = Set()
        for path in my_centrality_paths
            my_index = findall(x -> x == course, path)[1]
            # course is path[my_index]
            # TODO: edge cases based on length
            my_prereqs = path[1:my_index-1]
            my_deps = path[my_index+1:end]
            #= HUGE EDIT: only analyze the dependencies
            path_set = Set()
            for prereq in my_prereqs
                if isempty(path_set)
                    path_set = Set(split(prereq.canonical_name,","))
                else
                    intersect!(path_set,Set(split(prereq.canonical_name,",")))
                end
            end
            union!(prereq_set,path_set)
            =#
            path_set = Set()
            for dep in my_deps
                if isempty(path_set)
                    path_set = Set(split(dep.canonical_name, ","))
                else
                    union!(path_set, Set(split(dep.canonical_name, ",")))
                end
            end
            union!(dep_set, path_set)

        end
        full_set = union(prereq_set, dep_set)
        full_set = sort(collect(full_set))
        print_affected_plans(full_set)
        # look at all the paths that depend on me and for each path take the union of their majors
        # then combine the two sets
        return full_set
    else
        # ok this seems to not affect any majors because it's not been hooked up to anything
        println("This course hasn't been hooked up to anything, it didn't affect any majors other than the one it is in")
    end
    # TODO: correct return value and prettier printing
    # TODO: 
end

function add_prereq_institutional(curriculum::Curriculum, course_with_new_prereq::AbstractString)
    course_with_new_prereq = course_from_name(curriculum, course_with_new_prereq)
    affected_majors = split(course_with_new_prereq.canonical_name, ",")

    prev_major = "PL99"
    count = 0
    for major in affected_majors
        if major != ""
            if major[1:4] != prev_major[1:4]
                prev_major = major
                print("\n$(major[1:4]): $(major[5:end]), ")
                count += 1
            elseif major != prev_major
                prev_major = major
                print("$(major[5:end]), ")
                count += 1
            end
        end
    end
    println()
    print("Affected plans: $count")
    # TODO: return value to sandbox
end

function print_affected_plans(affected_plans)
    prev_major = "PL99"
    # TODO: consider just a set intersect
    count = 0
    for major in affected_plans
        #println("\n$major")
        if major != ""
            if major[1:4] != prev_major[1:4]
                prev_major = major
                print("\n$(major[1:4]): $(major[5:end]), ")
                count += 1
            elseif major != prev_major # don't ask me why for some reason each plan code shows up multiple times
                prev_major = major
                print("$(major[5:end]), ")
                count += 1
            end
        end
    end
    println()
end