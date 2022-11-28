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

[
- [ ] "BE27FI" : MATH 20C OR 31BH
- [ ] "BE27MU": ""
- [ ] "BE27RE": ""
- [ ] "BE27SI"; ""
- [ ] "BE27SN": ""
- [ ] "BE27TH": ""
- [ ] "BE27WA": ""
- [ ] "BE27curriculum": ""
- [ ] "BE29FI": ""
- [ ] "BE29MU": ""
- [ ] "BE29RE": ""
- [ ] "BE29SI": ""
- [ ] "BE29SN": ""
- [ ] "BE29TH": ""
- [ ] "BE29WA": ""
- [ ] "BE29curriculum": ""
- [ ] "CH35FI": MATH 10C -> CHEM 126A
- [ ] "CH35MU": MATH 10C
- [ ] "CH35RE": MATH 10C
- [ ] "CH35SI": MATH 10C
- [ ] "CH35SN": MATH 10C
- [ ] "CH35TH": MATH 10C
- [ ] "CH35WA": MATH 10C
- [ ] "CH35curriculum": MATH 10C
- [ ] "CH38FI": MATH 10C -> CHEM 126A
- [ ] "CH38MU": MATH 10C -> CHEM 126A
- [ ] "CH38RE": MATH 10C -> CHEM 126A
- [ ] "CH38SI": MATH 10C -> CHEM 126A
- [ ] "CH38SN": MATH 10C -> CHEM 126A
- [ ] "CH38TH": MATH 10C -> CHEM 126A
- [ ] "CH38WA": MATH 10C -> CHEM 126A
- [ ] "CH38curriculum": : MATH 10C -> CHEM 126A
  The above ones are ok...
- [ ] "MU27FI",
- [ ] "MU27MU",
- [ ] "MU27SI",
- [ ] "MU27SN",
- [ ] "MU27TH",
- [ ] "MU27WA",
- [ ] "MU27curriculum",
Here, there is no 10C or 20C/31AH or whatever. The closest point is MATH 20B. This merits plenty of investigation now.
- [ ] "UNPSRE"

SO: apparently this is because this system captures "equivalent" prerequisites. So these show up on the list because in these majors the classes that would depend on 20C actually depend on "20C or 10C" or something like that. This isn't an issue yet for the following reasons:
1. Overestimating isn't a big deal
2. This shouldn't happen with a new hypothetical course, since it has no "equivalent" courses, except in very special cases.
3. I forgot the third one
Two other thoughts:
With the current setup there's no way to stop this without previously knowing what majors are affected.
This could be used to canonicalize certain majors - move them all up to 20C or something like that.
