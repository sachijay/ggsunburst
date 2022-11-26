test_that("alpha is double", {
  expect_type(calculate_alpha(1, fill = "foo"), "double")
})

test_that("alpha is 1 for level 1", {
  expect_equal(calculate_alpha(1, fill = "foo"), 1)
})

test_that("alpha is Inf for root", {
  expect_equal(calculate_alpha(0, fill = "foo"), Inf)
})

test_that("alpha is 0 for missing fill", {
  expect_equal(calculate_alpha(1, fill = NA), 0)
})

test_that("unequal argument lengths", {
  expect_error(calculate_alpha(1:2, fill = "foo"))
})


