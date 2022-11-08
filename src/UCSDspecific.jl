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

for 