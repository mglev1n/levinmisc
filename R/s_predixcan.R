# WARNING - Generated by {fusen} from dev/flat_genomics_functions.Rmd: do not edit by hand

#' Run a TWAS using S-PrediXcan
#'
#' This function is a wrapper around S-PrediXcan, a method of integrating GWAS summary statistics with gene-expression/splicing data to identify genes associated with a trait. The PrediXcan/MetaXcan method is described in Barbeira et al. (Nature Communications 2018; <https://doi.org/10.1038/s41467-018-03621-1>). The MetaXcan tools can be found on Github (<https://github.com/hakyimlab/MetaXcan>) and PredictDB (<https://predictdb.org/>). If S-PrediXcan is run across multiple tissues, the results can be integrated using [levinmisc::s_multixcan()].

#' @param df Dataframe containing GWAS summary statistics
#' @param snp Column containing rsid
#' @param effect_allele Column containing effect allele
#' @param other_allele Column containing non-effect allele
#' @param beta Column containing effect size
#' @param eaf Column containing effect allele frequency
#' @param chr Column containing chromosome
#' @param pos Column containing position
#' @param se Column containing standard error of the effect estimate
#' @param pval Column containing p-value
#' @param samplesize Column containing samplesize
#' @param data Path to MetaXcan data (eg. `"MetaXcan/data"`)
#' @param metaxcan Path to MetaXcan (eg. `"MetaXcan/software"`)
#' @param output Output directory to save S-PrediXcan results
#' @param model_db_path Path to PrediXcan model database
#' @param model_covariance_path Path to PrediXcan model covariance
#' @param trait_name Name of GWAS trait (used to name output files)
#'
#' @return A dataframe containing the S-PrediXcan results
#' @family TWAS
#' @family Gene-based testing
#' @concept genomics
#' @import dplyr
#' @export
#' @examples
#' \dontrun{
#' s_predixcan(df, data = "MetaXcan/data", metaxcan = "MetaXcan/software", output = "/path/to/output", model_db_path = "MetaXcan/data/models/eqtl/mashr/mashr_Liver.db", model_covariance_path = "MetaXcan/data/models/eqtl/mashr/mashr_Liver.txt.gz", trait_name = "GWAS_trait")
#' }

s_predixcan <- function(df, snp = SNP, effect_allele = effect_allele, other_allele = other_allele, beta = beta, eaf = eaf, chr = chr, pos = pos, se = se, pval = pval, samplesize = samplesize, data, metaxcan, output, model_db_path, model_covariance_path, trait_name) {
  fs::dir_create(output, recurse = TRUE)

  shell <- ifelse(Sys.info()["sysname"] == "Windows", "cmd", "sh")
  # write temporary summary statistics file for harmonization
  .fn <- tempfile()
  df %>%
    dplyr::select(rsid = {{ snp }}, noneffect_allele = {{ other_allele }}, effect_allele = {{ effect_allele }}, effect = {{ beta }}, p_value = {{ pval }}) %>%
    vroom::vroom_write(.fn)

  .eqtl_name <- fs::path_file(model_db_path) %>% str_replace("\\.db$", "")
  .harmonize <- paste0(
    "export DATA=", shQuote(data, type = shell),
    # "; export GWAS_TOOLS=", shQuote(gwas_tools, type = shell),
    "; export METAXCAN=", shQuote(metaxcan, type = shell),
    # "; export OUTPUT=", fn,
    "; python3 $METAXCAN/M03_betas.py",
    " --snp_map_file $DATA/coordinate_map/map_snp150_hg19.txt.gz",
    " --gwas_file ", shQuote(.fn, type = shell),
    " --snp_column rsid ",
    " --non_effect_allele_column noneffect_allele ",
    " --effect_allele_column effect_allele ",
    " --beta_column effect ",
    " --pvalue_column p_value ",
    " --keep_non_rsid ",
    " --throw ",
    " --output ", .fn, "_harmonized.txt",
    "; python3 $METAXCAN/SPrediXcan.py",
    " --gwas_file ", .fn, "_harmonized.txt",
    " --snp_column snp",
    " --effect_allele_column effect_allele",
    " --non_effect_allele_column non_effect_allele",
    " --zscore_column zscore",
    " --model_db_path ", shQuote(model_db_path, type = shell),
    " --covariance ", shQuote(model_covariance_path, type = shell),
    " --keep_non_rsid",
    " --additional_output",
    " --model_db_snp_key varID",
    " --throw",
    " --output_file ", fs::path(output, paste0(trait_name, "_", .eqtl_name, "_S-prediXcan.csv"))
  )
  withr::with_envvar(
    new = c(
      "DATA" = data,
      # "GWAS_TOOLS" = gwas_tools,
      "METAXCAN" = metaxcan,
      "OUTPUT" = .fn
    ),
    system(.harmonize)
  )
  on.exit(system(paste0("rm ", .fn, "*")))
  # system(.harmonize)

  vroom::vroom(fs::path(output, paste0(trait_name, "_", .eqtl_name, "_S-prediXcan.csv"))) %>%
    dplyr::mutate(tissue = .eqtl_name) %>%
    data.table::fwrite(fs::path(output, paste0(trait_name, "_", .eqtl_name, "_S-prediXcan.csv")))

  return(fs::path(output, paste0(trait_name, "_", .eqtl_name, "_S-prediXcan.csv")))
}
