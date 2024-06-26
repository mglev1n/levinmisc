# WARNING - Generated by {fusen} from dev/flat_genomics_functions.Rmd: do not edit by hand

#' Calculate heritability using LDAK
#'
#' This function wraps LDAK, a command-line tool for estimating heritability. The tool and associated reference files can be download from the LDAK website (<https://ldak.org/>). The method is described in Zhang et al. (Nature Communications 2021; <https://doi.org/10.1038/s41467-021-24485-y).
#'
#' @param sumstats_file Path to "munged" GWAS summary statistics file in LDSC format. The current implementation of this function requires rsids to link to other LDAK files.
#' @param ldak_bin Path to LDAK binary
#' @param ldak_tagfile Path to LDAK tagfile
#' @param sample_prev Sample prevalence of cases (for case-control studies), `NULL` (default) for quantitative traits
#' @param population_prev Population prevalence of cases in the sample (for case-control studies), `NULL` (default) for quantitative traits
#' @param hm3_file Path to hm3 file containing
#' @param ldak_cutoff Minor allele frequency cutoff (default = 0.01)
#'
#' @return List of dataframes containing LDAK results
#' @concept genomics
#' @family {heritability}
#' @import stringr
#' @export
#' @examples
#' \dontrun{
#' ldak_h2(sumstats_file = "/path/to/munged_sumstats", ldak_bin = "/path/to/ldak", ldak_tagfile = "/path/to/tagfile",  hm3_file = "/path/to/hm3")
#' }

ldak_h2 <- function(sumstats_file, ldak_bin, ldak_tagfile, sample_prev = NULL, population_prev = NULL, hm3_file, ldak_cutoff = 0.01) {
  # format paths
  cli::cli_progress_step("Formatting paths")
  ldak_bin <- fs::path_abs(ldak_bin)
  ldak_tagfile <- fs::path_abs(ldak_tagfile)
  ldak_in <- fs::file_temp()
  ldak_dir <- fs::path_temp()

  # Category annotations
  ldak_annotations <- glue::glue("1 Coding_UCSC*
2 Coding_UCSC.extend.500
3 Conserved_LindbladToh*
4 Conserved_LindbladToh.extend.500
5 CTCF_Hoffman*
6 CTCF_Hoffman.extend.500
7 DGF_ENCODE*
8 DGF_ENCODE.extend.500
9 DHS_peaks_Trynka
10 DHS_Trynka*
11 DHS_Trynka.extend.500
12 Enhancer_Andersson*
13 Enhancer_Andersson.extend.500
14 Enhancer_Hoffman*
15 Enhancer_Hoffman.extend.500
16 FetalDHS_Trynka*
17 FetalDHS_Trynka.extend.500
18 H3K27ac_Hnisz*
19 H3K27ac_Hnisz.extend.500
20 H3K27ac_PGC2*
21 H3K27ac_PGC2.extend.500
22 H3K4me1_peaks_Trynka
23 H3K4me1_Trynka*
24 H3K4me1_Trynka.extend.500
25 H3K4me3_peaks_Trynka
26 H3K4me3_Trynka*
27 H3K4me3_Trynka.extend.500
28 H3K9ac_peaks_Trynka
29 H3K9ac_Trynka*
30 H3K9ac_Trynka.extend.500
31 Intron_UCSC*
32 Intron_UCSC.extend.500
33 PromoterFlanking_Hoffman*
34 PromoterFlanking_Hoffman.extend.500
35 Promoter_UCSC*
36 Promoter_UCSC.extend.500
37 Repressed_Hoffman*
38 Repressed_Hoffman.extend.500
39 SuperEnhancer_Hnisz*
40 SuperEnhancer_Hnisz.extend.500
41 TFBS_ENCODE*
42 TFBS_ENCODE.extend.500
43 Transcr_Hoffman*
44 Transcr_Hoffman.extend.500
45 TSS_Hoffman*
46 TSS_Hoffman.extend.500
47 UTR_3_UCSC*
48 UTR_3_UCSC.extend.500
49 UTR_5_UCSC*
50 UTR_5_UCSC.extend.500
51 WeakEnhancer_Hoffman*
52 WeakEnhancer_Hoffman.extend.500
53 Super_Enhancer_Vahedi*
54 Super_Enhancer_Vahedi.extend.500
55 Typical_Enhancer_Vahedi*
56 Typical_Enhancer_Vahedi.extend.500
57 GERP.NS
58 GERP.RSsup4
59 MAF_Adj_Predicted_Allele_Age
60 MAF_Adj_LLD_AFR
61 Recomb_Rate_10kb
62 Nucleotide_Diversity_10kb
63 Backgrd_Selection_Stat
64 CpG_Content_50kb
65 LDAK_Weightings
66 Base_Category") %>%
    readr::read_delim(col_names = c("category", "annotation"), delim = " ") %>%
    dplyr::mutate(binary = str_detect(annotation, "\\*")) %>%
    dplyr::mutate(annotation = str_replace(annotation, "\\*", ""))

  # read files
  cli::cli_progress_step("Reading files")
  hm3_df <- vroom::vroom(hm3_file, col_names = c("SNP", "Predictor"), col_select = c(1:2), col_types = "cc")
  sumstats_df <- vroom::vroom(sumstats_file, show_col_types = FALSE)
  phenotype <- fs::path_file(sumstats_file)


  # write summary statistics
  cli::cli_progress_step("Writing summary statistics")
  sumstats_df %>%
    dplyr::inner_join(hm3_df, by = c("SNP" = "SNP")) %>%
    dplyr::select(Predictor, A1, A2, n = N, Z) %>%
    dplyr::filter(is.finite(Z)) %>%
    vroom::vroom_write(ldak_in)

  cli::cli_progress_step("Running LDAK")
  processx::run(ldak_bin,
    args = c(
      "--sum-hers", phenotype,
      "--summary", ldak_in,
      "--tagfile", ldak_tagfile,
      "--check-sums", "NO",
      if (!is.null(population_prev)) {
        c("--prevalence", population_prev)
      },
      if (!is.null(sample_prev)) {
        c("--ascertainment", sample_prev)
      },
      "--cutoff", ldak_cutoff
    ),
    error_on_status = FALSE,
    echo_cmd = TRUE,
    echo = TRUE,
    wd = ldak_dir
  )

  h2_res <- vroom::vroom(fs::dir_ls(ldak_dir, glob = "*.hers*"), show_col_types = FALSE, col_names = c("component", "h2", "h2_sd", "influence", "influence_sd"), skip = 1) %>%
    dplyr::mutate(category = stringr::str_match(component, "\\d+")) %>%
    readr::type_convert() %>%
    dplyr::left_join(ldak_annotations)
  cat_res <- vroom::vroom(fs::dir_ls(ldak_dir, glob = "*.cats*"), col_names = c("component", "heritability", "sd"), show_col_types = FALSE, skip = 1) %>%
    dplyr::mutate(category = stringr::str_match(component, "\\d+")) %>%
    readr::type_convert() %>%
    dplyr::left_join(ldak_annotations)
  share_res <- vroom::vroom(fs::dir_ls(ldak_dir, glob = "*.share*"), col_names = c("component", "share", "sd"), show_col_types = FALSE, skip = 1) %>%
    dplyr::mutate(category = stringr::str_match(component, "\\d+")) %>%
    readr::type_convert() %>%
    dplyr::left_join(ldak_annotations)
  enrich_res <- vroom::vroom(fs::dir_ls(ldak_dir, glob = "*.enrich*"), col_names = c("component", "share", "share_sd", "expected", "enrichment", "enrichment_sd"), show_col_types = FALSE, skip = 1) %>%
    dplyr::mutate(category = str_match(component, "\\d+")) %>%
    readr::type_convert() %>%
    dplyr::left_join(ldak_annotations)
  # extra_res <- vroom::vroom(fs::dir_ls(ldak_dir, glob = "*.extra*"), show_col_types = FALSE, skip = 1)

  return(list(
    h2 = h2_res,
    cat = cat_res,
    share = share_res,
    enrich = enrich_res
  ))
}
