in_str <- "x <- 1"

out_bare <- translate(x <- 1, speak = FALSE)
out_str <- translate_string(in_str, speak = FALSE)

txt <- "a"
vec <- c("a", "b")
num <- 1
lgl <- TRUE
list <- list(1, 2)
dfr <- data.frame("a", "b")


test_that("translation output takes S3 class", {
  expect_s3_class(out_bare, "r2eng")
  expect_s3_class(out_str, "r2eng")
})

test_that("translation output has expected type", {
  expect_type(out_bare, "list")
  expect_type(out_str, "list")
})

test_that("translation output elements have expected types", {

  expect_type(out_bare$r_expression, "character")
  expect_type(out_bare$eng_expression, "character")
  expect_type(out_bare$translation_map, "list")
  expect_type(out_bare$quoted_expression, "language")

  expect_type(out_str$r_expression, "character")
  expect_type(out_str$eng_expression, "character")
  expect_type(out_str$translation_map, "list")
  expect_type(out_str$quoted_expression, "language")

})

test_that("translation output has correct length", {
  expect_length(out_bare, 4)
  expect_length(out_str, 4)
})

test_that("translation output elements have correct dimensions", {

  expect_length(out_bare$r_expression, 1)
  expect_length(out_bare$eng_expression, 1)
  expect_length(out_bare$translation_map, 3)

  expect_length(out_str$r_expression, 1)
  expect_length(out_str$eng_expression, 1)
  expect_length(out_str$translation_map, 3)

  # TODO: test for expected number of elements in translation_map

})

test_that("non-characters passed to expression argument cause errors", {
  expect_error(translate_string(vec))
  expect_error(translate_string(num))
  expect_error(translate_string(lgl))
  expect_error(translate_string(list))
  expect_error(translate_string(dfr))
})

test_that("non-characters passed to function_call_end argument cause errors", {

  expect_error(translate_string(x <- 1, function_call_end, vec))
  expect_error(translate_string(x <- 1, function_call_end, num))
  expect_error(translate_string(x <- 1, function_call_end, lgl))
  expect_error(translate_string(x <- 1, function_call_end, list))
  expect_error(translate_string(x <- 1, function_call_end, dfr))

  expect_error(translate_string(in_str, function_call_end, vec))
  expect_error(translate_string(in_str, function_call_end, num))
  expect_error(translate_string(in_str, function_call_end, lgl))
  expect_error(translate_string(in_str, function_call_end, list))
  expect_error(translate_string(in_str, function_call_end, dfr))

})

test_that("non-logicals passed to speak argument are errors", {

  expect_error(translate(x <- 1, speak = txt))
  expect_error(translate(x <- 1, speak = vec))
  expect_error(translate(x <- 1, speak = num))
  expect_error(translate(x <- 1, speak = list))
  expect_error(translate(x <- 1, speak = dfr))

  expect_error(translate_string(in_str, speak = txt))
  expect_error(translate_string(in_str, speak = vec))
  expect_error(translate_string(in_str, speak = num))
  expect_error(translate_string(in_str, speak = list))
  expect_error(translate_string(in_str, speak = dfr))

})

test_that("speak method returns nothing", {
  expect_invisible(speak(out_bare))
  expect_silent(speak(out_str))
})
