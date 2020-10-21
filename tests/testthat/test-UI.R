test_that("multiSelection", {
  expect_error(multiSelection(id = NULL))
  expect_error(multiSelection(inputDisplay = NULL))
  expect_error(multiSelection(selection = NULL))
  expect_error(multiSelection(id = ))
})
