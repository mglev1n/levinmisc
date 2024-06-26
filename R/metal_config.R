# WARNING - Generated by {fusen} from dev/flat_genomics_functions.Rmd: do not edit by hand

#' Create a configuration file for METAL
#'
#' This function can be used to generate a configuration for METAL, a tool for performing meta-analysis of GWAS summary statistics <https://github.com/statgen/METAL>. The file created by this function can be used to run a meta-analysis. Details of the arguments to METAL are described in the METAL documentation: <https://genome.sph.umich.edu/wiki/METAL_Documentation>.
#'
#' @param config_name (string) Name of the configuration
#' @param output_dir (path) Path to output directory where GWAS meta-analysis data should be stored
#' @param study_files (vector) Character vector of paths to summary statistics that should be included in the GWAS
#' @param SCHEME (string) Either "SAMPLESIZE" or "STDERR" (default), corresponding to the METAL analysis scheme
#' @param AVERAGEFREQ (string) Either "ON" (default) or "OFF", allowing METAL to report the mean effect allele frequency across files
#' @param MINMAXFREQ (string) Either "ON" (default) or "OFF", allowing METAL to report the min/max effect allele frequency across files
#' @param TRACKPOSITIONS (string) Either "ON" (default) or "OFF", allowing METAL to report chromosome/position in the output
#' @param MARKERLABEL (string) Column containing unique markers to analyze (this column must be named the same across all input files)
#' @param CHROMOSOMELABEL (string) Column containing chromosomes (this column must be named the same across all input files)
#' @param POSITIONLABEL (string) Column containing genomic positions (this column must be named the same across all input files)
#' @param EFFECT_ALLELE (string) Column containing effect alleles (this column must be named the same across all input files)
#' @param OTHER_ALLELE (string) Column containing non-effect alleles (this column must be named the same across all input files)
#' @param EFFECTLABEL (string) Column containing effect sizes corresponding to the effect allele (this column must be named the same across all input files)
#' @param STDERR (string) Column containing standard errors fo the effect estimate (this column must be named the same across all input files)
#' @param FREQLABEL (string) Column containing effect allele frequencies (this column must be named the same across all input files)
#' @param NCASE (string) Column containing number of cases (this column must be named the same across all input files)
#' @param NCONTROL (string) Column containing number of controls (this column must be named the same across all input files)
#' @param SAMPLESIZE (string) Column containing total samplesize (this column must be named the same across all input files)
#'
#' @return Path to METAL configuration file
#' @concept genomics
#' @family GWAS meta-analysis
#' @seealso Run GWAS meta-analysis using METAL: [levinmisc::metal_run()]
#' @export
#' @examples
#' \dontrun{
#' metal_config(config_name = "name-of-analysis", output_dir = "/path/to/output/", study_files = c("/path/to/sumstats_1.txt", "/path/to/sumstats_2.txt"))
#' }

metal_config <- function(config_name, output_dir, study_files, SCHEME = "STDERR", AVERAGEFREQ = "ON", MINMAXFREQ = "OFF", TRACKPOSITIONS = "ON", MARKERLABEL = "MARKER", CHROMOSOMELABEL = "CHROM", POSITIONLABEL = "POS", EFFECT_ALLELE = "EFFECT_ALLELE", OTHER_ALLELE = "OTHER_ALLELE", EFFECTLABEL = "BETA", STDERR = "SE", FREQLABEL = "EAF", NCASE = NULL, NCONTROL = NULL, SAMPLESIZE = NULL) {
  fs::dir_create(output_dir, recurse = TRUE)

  config_outfile <- fs::path(output_dir, paste0(config_name, "_metal-config.txt"))
  meta_outfile <- fs::path(normalizePath(output_dir), config_name)

  study_files <- paste0(glue::glue("PROCESS {normalizePath(study_files)}"), collapse = "\n")

  config_text <- glue::glue(
    "SCHEME {SCHEME}
    AVERAGEFREQ {AVERAGEFREQ}
    MINMAXFREQ {MINMAXFREQ}
    TRACKPOSITIONS {TRACKPOSITIONS}
    MARKERLABEL {MARKERLABEL}
    CHROMOSOMELABEL {CHROMOSOMELABEL}
    POSITIONLABEL {POSITIONLABEL}
    ALLELELABELS {EFFECT_ALLELE} {OTHER_ALLELE}
    EFFECTLABEL {EFFECTLABEL}
    STDERR {STDERR}
    FREQLABEL {FREQLABEL}

    "
  )

  if (!is.null(NCASE)) {
    config_text <- glue::glue("
    {config_text}\n
    CUSTOMVARIABLE NCASE
    LABEL NCASE as {NCASE}
    ")
  }

  if (!is.null(NCONTROL)) {
    config_text <- glue::glue("
    {config_text}\n
    CUSTOMVARIABLE NCONTROL
    LABEL NCONTROL as {NCONTROL}")
  }

  if (!is.null(SAMPLESIZE)) {
    config_text <- glue::glue("
    {config_text}\n
    CUSTOMVARIABLE SAMPLESIZE
    LABEL SAMPLESIZE as {SAMPLESIZE}")
  }

  config_text <- glue::glue("
    {config_text}

    {study_files}

    OUTFILE {meta_outfile}_metal- .txt
    ANALYZE HETEROGENEITY

    QUIT")

  readr::write_lines(x = config_text, file = config_outfile)

  return(config_outfile)
}
