function test_delete_course_institutional(curriculum::Curriculum, course_to_remove_name::AbstractString)
    course_to_remove = course_from_name(curriculum, course_to_remove_name)
    if typeof(course_to_remove) == Nothing
        throw(ArgumentError("I'm sorry, we couldn't find your target course in the given curriculum. Make sure you got the name exactly right."))
    end
    centrality_paths = centrality_investigator(course_to_remove, curriculum)
    if length(centrality_paths) > 0
        prereq_set = Set()
        dep_set = Set()
        for path in centrality_paths
            my_index = findall(x -> x == course_to_remove, path)[1]
            my_prereqs = path[1:my_index-1]
            my_deps = path[my_index+1:end]
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
        # don't forget all the instances where the removed course is the end of a chain and has no prereqs
        union!(full_set, Set(split(course_to_remove.canonical_name, ",")))
        full_set = sort(collect(full_set))
        count = print_affected_plans(full_set)
        println("Number of affected plans: $(count)")
        return full_set
    else
        println("This course hasn't been hooked up to anything. It doesn't affect any plans other than the one it is in")
        return Set()
    end
end