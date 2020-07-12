#' Convert R Code To Spoken English
#'
#' Takes an R expression and converts it to English by matching recognised
#' symbols with an opinionated list of English 'translations'.
#'
#' @param expression An R expression as a character string.
#' @param speak Do you want your system to try and say the English expression?
#'
#' @return A list with three elements: the R expression, the 'translated'
#'     English expression, and a data frame showing the translation of each
#'     R element.
#' @export
#'
#' @examples
#' \dontrun{
#' r2eng("variable <- 1")
#' }
r2eng <- function(expression, speak = TRUE) {

  # Translation guide
  dictionary <- tibble::tribble(
    ~"r", ~"eng",
    "<-", "gets",
    "->", "into",
    "=", "is",
    "%>%", "then",
    "%in%", "matches",
    "|", "or"
  )

  # Extract elements of the expression string
  r_vec <- strsplit(expression, " ")[[1]]

  # Make elements int a column
  translation <- data.frame(
    order = 1:length(r_vec),  # because merge() doesn't preserve order
    r = r_vec,
    stringsAsFactors = FALSE
  )

  # Join the dictionary
  translation <- merge(
    x = translation, y = dictionary, by = "r",
    all.x = TRUE, all.y = FALSE
  )

  # R elements with no English match should remain as they are
  translation$eng <- with(translation, ifelse(is.na(eng), r, eng))

  # Sort by the original element ordering
  translation <- translation[order(translation$order), ]

  # Remove order column and reset row names
  translation$order <- NULL
  row.names(translation) <- NULL

  # R converted to English
  eng_expression <- paste(translation$eng, collapse = " ")

  # Have your system speak the sentence
  if (isTRUE(speak)) { system(paste0("say ", "'", eng_expression, "'")) }

  # Output a list of results
  results <- list(
    r_expression = expression,  # original R expression
    eng_expression = eng_expression,  # tranlsated English expression
    translation_map = translation  # table mapping R to English
  )

  return(results)

}
