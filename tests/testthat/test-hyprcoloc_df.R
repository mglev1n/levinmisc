# WARNING - Generated by {fusen} from dev/flat_genomics_functions.Rmd: do not edit by hand

test_that("hyprcoloc_df works", {
  expect_true(inherits(hyprcoloc_df, "function"))

  df <- tibble::tibble(
    rsid = letters,
    beta = runif(26, min = -1, max = 1),
    se = runif(26)
  ) %>%
    tidyr::crossing(
      trait = letters[1:3],
      type = c(1, 0, 0)
    )

  hyprcoloc_res <- hyprcoloc_df(df)

  expect_true(inherits(hyprcoloc_res, "hyprcoloc"))
})
