## R CMD check results
There were no ERRORs, WARNINGs or NOTEs in local check.

## Minor release (v 0.2.0) submission (May 23, 2023)

* Ten new palettes have been added WrensBookshelf

* Updated ShowBookshelf() function to accomodate additional palettes

## OLDER NOTES
## Resubmission (August 12, 2022)
This is a resubmission, in this version I have fixed the following issues:

* Removed excess spaces from description line in DESCRIPTION file.

* Changed title in DESCRIPTION file to be less than 65 characters (now 60)

* Added - "@return No return value, integrates WB_brewer into ggplot2 function." to .R files of scale_color_WB_c, scale_color_WB_d, scale_fill_WB_c and scale_fill_WB_d, which added the requested \value{} line into the .Rd files via roxygen2. 

* Also added a \value{No return value, sets a list of palettes to be used with WrensBookshelf functions} to WrensBookshelf.Rd, just in case, though it is just a list that the other functions utilize, and not a function the user would interact with.

* Deleted function "hello.R" which was mistakenly held over from the initial creation of the package. This should fix the "You write information messages to the console that cannot be easily suppressed." issue that was raised. 

* Deleted "fullcode.R" which was a placeholder function that was mistakenly left in.

* Changed how the return to users original par was handled in ShowBookshelf() function to be more in line with the requested format (eg. get oldpar, then on.exit(par(oldpar)) on the next line).


## Fixes
* Added image files used for Github README.md to .Rbuildignore, file size shoould now be below 5MB

## Second Resubmission
* Fixed NEWS.md file, now should be in the correct format.

## Resubmission
This is a resubmission after the initial submission did "not pass the incoming checks automatically". In this version I have:

* Updated the Description to remove perceived spelling errors introduced by listing package names (e.g. ggplot).

* Changed the links for RColorBrewer and colorBlindness packages in the ReadMe to the canonical format https://CRAN.R-project.org/package=pkgname

* Added a new entry to the NEWS.md file.
