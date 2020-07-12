
<!-- README.md is generated from README.Rmd. Please edit that file -->

# {r2eng}

<!-- badges: start -->

<!-- badges: end -->

The goal of the {r2eng} package is to take an R expression and
‘translate’ it to an English sentence.

The project inspired by [Amelia
McNamara](https://twitter.com/AmeliaMN)’s useR\! 2020 talk
([YouTube](https://www.youtube.com/watch?v=ckW9sSdIVAc),
[slides](https://www.amelia.mn/SpeakingR/#1)).

This project is a work in progress.

## Installation

You can install the development version of {r2eng} from GitHub with:

``` r
remotes::install_github("r2eng")
```

There are no dependencies.

## Example

There’s currently one function in the package: `r2eng()` (as in ‘R to
English’).

Pass it an R expression like this:

``` r
r2eng::r2eng("variable <- 1", speak = FALSE)
# $r_expression
# [1] "variable <- 1"
# 
# $eng_expression
# [1] "variable gets 1"
# 
# $translation_map
#          r      eng
# 1 variable variable
# 2       <-     gets
# 3        1        1
```

Set speak to `TRUE` for a system call that will read the English
sentence out loud.

## WIP

There is much to do. Most R expressions won’t currently work with the
`r2eng()` function.

  - \[ \] Expand dictionary
  - \[ \] Split out parentheses
  - \[ \] Smart check of expression structure (e.g. ‘=’ will be used as
    gets if used for assignment, but will be ‘is’ elsewhere)
  - \[ \] Allow for variant opinions on translations
  - \[ \] Account for dollar, formula, tidyverse, etc, notation
  - \[ \] Add vignettes

## Code of Conduct

I welcome contributions.

Please note that the {r2eng} project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
