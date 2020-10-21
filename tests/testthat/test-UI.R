test_that("multiSelection cannot have NULL", {
  expect_error(multiSelection(id = NULL))
  expect_error(multiSelection(id = ""))
  expect_error(multiSelection(inputDisplay = NULL))
  expect_error(multiSelection(inputDisplay = ""))
  expect_error(multiSelection(selection = NULL))
  expect_error(multiSelection(id = ))
})
