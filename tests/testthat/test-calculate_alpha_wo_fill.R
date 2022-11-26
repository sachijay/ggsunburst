test_that("alpha is double", {
  expect_type(calculate_alpha_wo_fill(1), "double")
})

test_that("alpha is 1 for level 1", {
  expect_equal(calculate_alpha_wo_fill(1), 1)
})

test_that("alpha is Inf for root", {
  expect_equal(calculate_alpha_wo_fill(0), Inf)
})
