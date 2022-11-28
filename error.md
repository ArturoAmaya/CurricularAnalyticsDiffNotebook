Error description:
running the add course algorithm with math 20C returns a set that is greater than the set of majors 20C shows up in. This is strange. Investigate.
"BE29MU": No particular reason to see this one over BE29 in any other college or the curriculum
  "CH38FI"
  "CH35curriculum"
  "CH35FI"
  "BE29TH"
  "BE29SI"
  "MU27curriculum"
  "CH38RE"
  "BE27FI"
  "MU27WA"
  "BE27curriculum"
  "BE27WA"
  "BE29WA"
  "CH38SI"
  "BE27MU"
  "CH35SN"
  "MU27SI"
  "MU27SN"
  "MU27TH"
  "BE27RE"
  "CH38MU"
  "BE27TH"
  "MU27MU"
  "BE27SN"
  "CH35TH"
  "BE29FI"
  "CH35SI"
  "BE27SI"
  "CH35WA"
  "BE29RE"
  "CH38WA"
  "UNPSRE"
  "CH38TH"
  "CH35MU"
very weird

["BE27FI", 
"BE27MU",
"BE27RE",
"BE27SI",
"BE27SN",
"BE27TH",
"BE27WA",
"BE27curriculum",
"BE29FI",
"BE29MU",
"BE29RE",
"BE29SI",
"BE29SN",
"BE29TH",
"BE29WA",
"BE29curriculum",
"CH35FI",
"CH35MU",
"CH35RE",
"CH35SI",
"CH35SN",
"CH35TH",
"CH35WA", 
"CH35curriculum",
"CH38FI",
"CH38MU",
"CH38RE",
"CH38SI",
"CH38SN",
"CH38TH",
"CH38WA",
"CH38curriculum",
"MU27FI",
"MU27MU",
"MU27SI",
"MU27SN",
"MU27TH",
"MU27WA",
"MU27curriculum",
"UNPSRE"

SO: apparently this is because this system captures "equivalent" prerequisites. So these show up on the list because in these majors the classes that would depend on 20C actually depend on "20C or 10C" or something like that. This isn't an issue yet for the following reasons:
1. Overestimating isn't a big deal
2. This shouldn't happen with a new hypothetical course, since it has no "equivalent" courses, except in very special cases.
3. I forgot the third one
Two other thoughts:
With the current setup there's no way to stop this without previously knowing what majors are affected.
This could be used to canonicalize certain majors - move them all up to 20C or something like that.
