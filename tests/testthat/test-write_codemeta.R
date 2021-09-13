test_that("write_codemeta", {
  codemeta.json <- tempfile(fileext =".json")
  write_codemeta(find.package("base"), file = codemeta.json)

  expect_true(file.exists(codemeta.json ))
})
