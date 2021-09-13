testthat::test_that("We can parse bibentry citations into schema.org", {
  bib <- citation("jsonlite")
  bibl <- lapply(bib, parse_citation)
  expect_type(bibl, "list")

  f <- system.file("examples/CITATION_ex", package = "codemeta")
  bib <- readCitationFile(f)
  schema <- lapply(bib, parse_citation)
  expect_type(schema, "list")
})


testthat::test_that("We can use encoding", {
  f <- system.file("examples/CITATION_osmdata", package = "codemeta")
  d <- file.path(find.package("jsonlite"), "DESCRIPTION")
  meta <- parse_package_meta(d)
  bib <- utils::readCitationFile(f,
    meta = meta
  )
  expect_type(parse_citation(bib), "list")
})

testthat::test_that("Test citation with encoding and citation line", {
  f <- system.file("examples/CITATION_ex2", package = "codemeta")
  d <- file.path(find.package("jsonlite"), "DESCRIPTION")
  meta <- parse_package_meta(d)
  read_citation_with_encoding(f)
  testthat::expect_s3_class(read_citation_with_encoding(f), "citation")
})

testthat::test_that("Parse no meta tags", {
  expect_snapshot_output({
    citation_path <-
      system.file("examples/CITATION_osmdata", package = "codemeta")
    d <-
      system.file("examples/DESCRIPTION_good", package = "codemeta")
    meta <- parse_package_meta(d)
    bib <- read_citation_with_encoding(citation_path, meta)
    print(bib, bibtex = TRUE)
  })
})

testthat::test_that("Parse meta tags", {
  expect_snapshot_output({
    citation_path <-
      system.file("examples/CITATION_rmarkdown", package = "codemeta")
    d <-
      system.file("examples/DESCRIPTION_good", package = "codemeta")
    meta <- parse_package_meta(d)

    bib <- read_citation_with_encoding(citation_path, meta)
    print(bib, bibtex = TRUE)
  })
})
