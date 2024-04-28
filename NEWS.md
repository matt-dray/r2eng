# r2eng 0.0.0.9006

* Removed {lintr} dependency.

# r2eng 0.0.0.9005

* BREAKING:
    * `r2eng()` renamed to `translate()`
    * `r2eng_from_string()` renamed to `translate_string()`
    * addin renamed from `r2eng_vocalise()` to `addin_speak()`
* Added documentation to pass CMD check (utils, print method and ellipses)
* Updated README.
* Added `addin_print()` to RStduio Addins.
* Added GitHub Actions for build and code coverage.

# r2eng 0.0.0.9004

* Added crude RStudio addin to vocalise selected text ([idea from mikeR](https://community.rstudio.com/t/how-do-you-speak-r/73727/12?u=matt))

# r2eng 0.0.0.9003

* Added non-standard evaluation to `r2eng()` and introduced `r2eng_from_string()` (thanks to @chainsawriot).
* Added more translations.
* Updated README with clearer goals.

# r2eng 0.0.0.9002

* Added parsing method (thanks to @chainsawriot).
* Removed manually-updated dictionary object.

# r2eng 0.0.0.9001

* Split out the dictionary into a separate data set.
* Stored the code to create the dictionary.

# r2eng 0.0.0.9000

* Added package structure.
* Added `r2eng()` function.
