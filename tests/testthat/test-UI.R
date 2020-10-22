test_that("multiSelection cannot have NULL", {
  expect_error(multiSelection(id = NULL))
  expect_error(multiSelection(id = ""))
  expect_error(multiSelection(inputDisplay = NULL))
  expect_error(multiSelection(inputDisplay = ""))

})


test_that("multiSelection id and inputDisplay must be character",{
  expect_error(multiSelection(id = "12", inputDisplay = 12, selection = covid$country),
               "inputDisplay must be character.")
  expect_error(multiSelection(id = 12, inputDisplay = "12", selection = covid$country),
               "id must be character.")
})



