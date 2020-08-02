out_bare <- translate(x <- 1, speak = FALSE)
out_str <- translate_string("x <- 1", speak = FALSE)

test_that("translation output has correct classes", {
  expect_equal(class(out_bare), c("list", "r2eng"))
  expect_equal(class(out_str), c("list", "r2eng"))
})

test_that("translation output has correct length", {
  expect_equal(length(out_bare), 4)
  expect_equal(length(out_str), 4)
})

test_that("translation output elements have expected class or type", {

  expect_equal(class(out_bare$r_expression), "character")
  expect_equal(class(out_bare$eng_expression), "character")
  expect_equal(class(out_bare$translation_map), "data.frame")
  expect_equal(typeof(out_bare$quoted_expression), "language")

  expect_equal(class(out_str$r_expression), "character")
  expect_equal(class(out_str$eng_expression), "character")
  expect_equal(class(out_str$translation_map), "data.frame")
  expect_equal(typeof(out_str$quoted_expression), "language")

})

test_that("translation output elements have correct dimensions", {

  expect_equal(length(out_bare$r_expression), 1)
  expect_equal(length(out_bare$eng_expression), 1)
  expect_equal(length(out_bare$translation_map), 3)

  expect_equal(length(out_str$r_expression), 1)
  expect_equal(length(out_str$eng_expression), 1)
  expect_equal(length(out_str$translation_map), 3)

  # TODO: test for expected number of elements in translation_map

})
