% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gg_manhattan_df.R
\name{gg_manhattan_df}
\alias{gg_manhattan_df}
\title{Create a Manhattan Plot}
\usage{
gg_manhattan_df(
  sumstats_df,
  annotation_df = NULL,
  chr_col = chromosome,
  pos_col = position,
  pval_col = p_value,
  pval_threshold = 0.001,
  label_col = gene,
  build = "hg19",
  color1 = "#045ea7",
  color2 = "#82afd3",
  speed = "slow",
  ...
)
}
\arguments{
\item{sumstats_df}{Dataframe containing GWAS summary statistics}

\item{annotation_df}{Optional dataframe containing chromosome, position, and annotation labels}

\item{chr_col}{Name of chromosome column}

\item{pos_col}{Name of position column}

\item{pval_col}{Name of p-value column}

\item{pval_threshold}{Threshold for plotting p-values (p-values greater than this value are excluded from the plot; default = \code{0.001})}

\item{label_col}{Name of column in \code{annotation_df} containing annotations to include on the plot}

\item{build}{(string) One of "hg18", "hg19", or "hg38" (passed to \code{ggfastman})}

\item{color1}{(string) Color for odd-numbered chromosomes (passed to \code{ggfastman})}

\item{color2}{(string) Color for even-numbered chromosomes (passed to \code{ggfastman})}

\item{speed}{(string) One of "slow", "fast", or "ultrafast"; passed to \code{ggfastman} to control plotting speed}

\item{...}{Arguments passed to \link[ggfastman:fast_manhattan]{ggfastman::fast_manhattan}}
}
\value{
A ggplot2 object
}
\description{
This function is a wrapper around \link[ggfastman:fast_manhattan]{ggfastman::fast_manhattan} which allows for the creation of a Manhattan plot from a dataframe containing GWAS summary statistics.
}
\examples{
\dontrun{
gg_manhattan_df(sumstats_df)
}
}
\seealso{
Other {plotting}: 
\code{\link{gg_qq_df}()}
}
\concept{genomics}
\concept{{plotting}}
