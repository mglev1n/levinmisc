% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calc_credset.R
\name{calc_credset}
\alias{calc_credset}
\title{Perform Bayesian finemapping using the Approximate Bayes Factor approach}
\usage{
calc_credset(
  df,
  locus_marker_col = locus_marker,
  effect_col = effect,
  se_col = std_err,
  samplesize_col = samplesize,
  cred_interval = 0.99
)
}
\arguments{
\item{df}{Dataframe containing GWAS summary statistics}

\item{locus_marker_col}{Column containing a locus-level identifier}

\item{effect_col}{Column containing effect estimates}

\item{se_col}{Column containing standard errors fo the effect estimates}

\item{samplesize_col}{Column containing sample sizes}

\item{cred_interval}{Credible interval for the fine-mapped credible sets (default = 0.99; 0.95 is another common but artbitrarily determined interval)}
}
\value{
A data.frame containing credible sets at each locus. For each variant within the credible set, the prior probability of being the casual variant is provided.
}
\description{
Description
}
\examples{
\dontrun{
calc_credset(gwas_df)
}
}
\seealso{
Other {finemapping}: 
\code{\link{run_carma}()}
}
\concept{genomics}
\concept{{finemapping}}
