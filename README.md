
<!-- README.md is generated from README.Rmd. Please edit that file -->

# {r2eng}

<!-- badges: start -->

[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
<!-- badges: end -->

The goal of the {r2eng} (as in ‘R to English’) package is to take an R
expression and ‘translate’ it to an English sentence. Make R speakable\!

The project inspired by [Amelia
McNamara](https://twitter.com/AmeliaMN)’s useR\! 2020 talk
([YouTube](https://www.youtube.com/watch?v=ckW9sSdIVAc),
[slides](https://www.amelia.mn/SpeakingR/#1)).

This project is a work in progress and highly opinionated.

## Installation

You can install the development version of {r2eng} from GitHub with:

``` r
remotes::install_github("matt-dray/r2eng")
```

There are no dependencies.

## Example

There’s currently one function in the package: `r2eng()`.

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

There’s an in-built dictionary, `r2eng_dictionary`, that maps R symbols
to English terms:

``` r
r2eng::r2eng_dictionary
#       r                  eng
# 1    <-                 gets
# 2    ->                 into
# 3     =                   is
# 4   %>%                 then
# 5  %in%              matches
# 6     |                   or
# 7     !                  not
# 8     ?      search help for
# 9     ~                   by
# 10    (     open parenthesis
# 11    )    close parenthesis
# 12    [  open square bracket
# 13    ] close square bracket
# 14    {     open curly brace
# 15    }    close curly brace
```

I’m always seeking to expand this dictionary and improve the
`r2eng_dictionary` object. You can add ideas to [this GitHub
issue](https://github.com/matt-dray/r2eng/issues/1).

## Work in progress (WIP)

There is much to do. Most R expressions won’t currently work with the
`r2eng()` function.

  - \[ \] Expand the dictionary
  - \[ \] Split out parentheses for evaluation
  - \[ \] Ensure multi-line translation
  - \[ \] Smart check of expression structure (e.g. ‘=’ will be used as
    gets if used for assignment, but will be ‘is’ elsewhere)
  - \[ \] Allow for variant opinions on translations
  - \[ \] Account for dialects (dollar, formula, tidyverse, etc,
    notation)
  - \[ \] Test\!
  - \[ \] Add vignettes

## Code of Conduct

I welcome contributions.

Please note that the {r2eng} project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
