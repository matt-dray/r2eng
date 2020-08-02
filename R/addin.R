#' RStudio Addin: Vocalise An R Expression
#'
#' Vocalise selected R expression aloud in English (macOS only).
#'
#' @export
addin_speak <- function() {

  # Get RStudio editor info
  active_doc <- rstudioapi::getActiveDocumentContext()

  if (!is.null(active_doc)) {

    # Capture current highlighted expression
    selected_expr <- active_doc$selection[[1]]$text

    # Capture expression as translated r2eng object
    obj <- translate_string(selected_expr, speak = FALSE)

    # Use the speak() method
    speak(obj)

  }

}

#' RStudio Addin: Print Translated R Expression
#'
#' Print the highlighted R expression and English translation
#'
#' @export
addin_print <- function() {

  # Get RStudio editor info
  active_doc <- rstudioapi::getActiveDocumentContext()

  if (!is.null(active_doc)) {

    # Capture current highlighted expression
    selected_expr <- active_doc$selection[[1]]$text

    # Capture expression as translated r2eng object
    obj <- translate_string(selected_expr, speak = FALSE)

    # Use the print() method to print R expression and English sentence
    print(obj)

  }

}
