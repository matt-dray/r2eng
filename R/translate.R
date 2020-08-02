#' @rdname translate
#' @export
translate_string <- function(
  expression, speak = TRUE, function_call_end = "of "
) {
  .convert_quoted_expression(
    rlang::parse_expr(expression),
    speak = speak, function_call_end = function_call_end
  )
}

#' Translate R Code To Spoken English
#'
#' Takes an R expression and converts it to English by matching recognised
#' symbols with an opinionated list of English 'translations'.
#'
#' @param expression An R expression (bare if \code{translate()}, quoted if
#'     \code{translate_string()}).
#' @param speak Logical. Do you want your system to try and say the English
#'     expression? macOS only. Requires speakers on your machine.
#' @param function_call_end Character, what should be added after a function
#'     call, e.g. setting this parameter to "of", this function translates
#'     \code{summary(x)} to "summary of x open paren x close paren".
#' @return An r2eng object, which is a list with three elements: the input
#'     R expression, the 'translated' English expression and a data frame
#'     showing the translation of each R element.
#' @export
#' @examples
#' \dontrun{
#' translate(variable <- 1)
#' }
translate <- function(expression, speak = TRUE, function_call_end = "of ") {
  quoted_expression <- substitute(expression)
  if (!is.logical(speak)) {
    stop("The 'speak' argument must be TRUE or FALSE.\n")
  }
  return(.convert_quoted_expression(
    quoted_expression, speak = speak, function_call_end = function_call_end)
  )
}

.convert_quoted_expression <- function(
  quoted_expression, speak = TRUE, function_call_end = "of "
) {

  trees <- .convert_expr_tree(deparse(quoted_expression))

  eng_vec <- purrr::map2_chr(
    trees$token,
    trees$text,
    .translate,
    function_call_end = function_call_end
  )

  eng_expression <- gsub(" +", " ", paste0(eng_vec, collapse = " "))

  trees$eng <- eng_vec

  # Output a list of results
  results <- list(
    r_expression = deparse(quoted_expression),  # R expression as string
    eng_expression = eng_expression,  # translated English expression
    translation_map = trees,  # table mapping R to English
    quoted_expression = quoted_expression
  )

  class(results) <- append(class(results), "r2eng")

  if (speak) {
      speak(results)
  }

  return(results)

}

#' Speak out the English expression of r2eng object
#'
#' This function speaks the English expression of the r2eng object. Currently,
#'     only macOS is supported.
#' @param r2eng An r2eng object to speak.
#' @param ... Other arguments to pass.
#' @return Nothing.
#' @export
speak <- function(r2eng, ...) {
    UseMethod("speak", r2eng)
}

#' Evaluate expression in r2eng object
#'
#' This function evaluates the expression of the r2eng object.
#' @param r2eng An r2eng object to evaluate.
#' @param envir Environment to evaluate the expression. Defaults to current
#'     environment.
#' @param ... Other arguments to pass.
#' @return Nothing.
#' @export
evaluate <- function(r2eng, ...) {
    UseMethod("evaluate", r2eng)
}

#' @rdname evaluate
#' @export
evaluate.r2eng <- function(r2eng, envir = parent.frame(), ...) {
    eval(r2eng$quoted_expression, envir = envir)
}

#' @rdname speak
#' @export
speak.r2eng <- function(r2eng, ...) {
  system(
    paste0(
      "say '",
      paste0(utils::tail(r2eng$translation_map$eng, -1), collapse = ","),
      "'"
    )
  )
}

#' Print r2eng Object For Reading
#'
#' Print the r2eng object to see the original and translated expressions.
#' @param x An r2eng object to print.
#' @param ... Other arguments to pass.
#' @return Nothing.
#' @export
print.r2eng <- function(x, ...) {
    cat(paste0("Original expression: ", x$r_expression, "\n"))
    cat(paste0("English expression:", x$eng_expression, "\n"))
}

.convert_expr_tree <- function(expression) {
    tmp <- tempfile()
    writeLines(expression, tmp)
    trees <- lintr::get_source_expressions(tmp)
    unlink(tmp)
    return(trees$expressions[[1]]$parsed_content[,c("token", "text")])
}


.translate <- function(token, text, function_call = "", function_call_end = "") {

  # Arithmetic/conditions
  if (token == "'+'") {
    return("plus")
  }
  if (token == "'-'") {
    return("minus")
  }
  if (token == "'*'") {
    return("times")
  }
  if (token == "'/'") {
    return("over")
  }
  if (token %in% c("'^'", "'**'")) {
    return("raised to the power of")
  }
  if (token == "GT") {
    return("is greater than")
  }
  if (token == "GE") {
    return("is greater than or equal to")
  }
  if (token == "LT") {
    return("is less than")
  }
  if (token == "LE") {
    return("is less than or equal to")
  }
  if (token == "EQ") {
    return("double equals")
  }
  if (token == "NE") {
    return("not equal to")
  }
  if (token == "'!'") {
    return("not")
  }
  if (token == "AND") {
    return("and")
  }
  if (token == "OR") {
    return("or")
  }
  if (token == "AND2") {
    return("double-and")
  }
  if (token == "OR2") {
    return("double-or")
  }

  # Braces
  if (token == "'('") {
    return("open paren")
  }
  if (token == "')'") {
    return("close paren")
  }
  if (token == "'{'") {
    return("open curly brace")
  }
  if (token == "'}'") {
    return("close curly brace")
  }
  if (token == "LBB") {
    return("open double-square bracket")
  }
  if (token == "'['") {
    return("open square bracket")
  }
  if (token == "']'") {
    return("close square bracket")
  }

  # Assignment
  if (token == "LEFT_ASSIGN" | token == "EQ_ASSIGN") {
    return("gets")
  }
  if (token == "RIGHT_ASSIGN") {
    return("into")
  }

  # Infix operators
  if (token == "SPECIAL" & text == "%in%") {
    return("matches")
  }
  if (token == "SPECIAL" & text == "%>%") {
    return("then")
  }

  # Functions
  if (token == "SYMBOL_FUNCTION_CALL") {
    if (text == "c") {
      return("a vector of")
    }
    return(paste(function_call, text, function_call_end))
  }

  # Definition operator

  if (token == "'~'") {
    return("by")
  }

  # Help
  if (token == "'?'") {
    return("help for")
  }

  # Namespace
  if (token == "NS_GET") {  # '::'
    return("double-colon")
  }
  if (token == "NS_GET_INT") {  # ':::'
    return("triple-colon")
  }

  # Unnamed tokens
  if (grepl("SYMBOL", token)) {
    return(text)
  }
  if (token == "STR_CONST") {
    return(paste0("string ", text))
  }
  if (token == "expr") {
    return("")
  }

  return(text)

}

