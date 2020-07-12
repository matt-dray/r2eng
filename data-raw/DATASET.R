## code to prepare `DATASET` dataset goes here

# Translation guide
r2eng_dictionary <- tibble::tribble(
  ~"r", ~"eng",
  "<-", "gets",
  "->", "into",
  "=", "is",
  "%>%", "then",
  "%in%", "matches",
  "|", "or",
  "!", "not",
  "?", "search help for",
  "~", "by",
  "(", "open parenthesis",
  ")", "close parenthesis",
  "[", "open square bracket",
  "]", "close square bracket",
  "{", "open curly brace",
  "}", "close curly brace"
)

# Save the data
usethis::use_data(r2eng_dictionary, overwrite = TRUE)
