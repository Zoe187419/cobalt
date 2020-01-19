\name{bal.tab.sbw}
\alias{bal.tab.sbw}
\title{
Balance Statistics for sbw Objects
}
\description{
Generates balance statistics for \code{sbwcau} objects from \pkg{sbw}.
}
\usage{
\method{bal.tab}{sbwcau}(sbwcau, 
    int = FALSE, 
    poly = 1, 
    distance = NULL, 
    addl = NULL, 
    data = NULL, 
    continuous,  
    binary, 
    s.d.denom, 
    m.threshold = NULL, 
    v.threshold = NULL, 
    ks.threshold = NULL,
    cluster = NULL, 
    imp = NULL,
    abs = FALSE,
    subset = NULL,
    quick = TRUE, 
    ...)
}

\arguments{
  \item{sbwcau}{
an \code{sbwcau} object; the output of a call to \code{sbw()} from the \pkg{sbw} package.
}
  \item{int}{
\code{logical} or \code{numeric}; whether or not to include 2-way interactions of covariates included in \code{covs} and in \code{addl}. If \code{numeric}, will be passed to \code{poly} as well.
}
  \item{poly}{
\code{numeric}; the highest polynomial of each continuous covariate to display. For example, if 2, squares of each continuous covariate will be displayed (in addition to the covariate itself); if 3, squares and cubes of each continuous covariate will be displayed, etc. If 1, the default, only the base covariate will be displayed. If \code{int} is numeric, \code{poly} will take on the value of \code{int}.
}
  \item{distance}{
Optional; either a vector or data.frame containing distance values (e.g., propensity scores) for each unit or a string containing the name of the distance variable in \code{data}.
}
  \item{addl}{
an optional data frame or the quoted names of additional covariates for which to present balance. These may be covariates included in the original dataset but not included in the call to \code{sbw()}. If variable names are specified, \code{bal.tab()} will look first in the argument to \code{data}, if specified, and next in the \code{sbwcau} object.
}
  \item{data}{
an optional data frame containing variables that might be named in arguments to \code{distance}, \code{addl}, \code{cluster}, and \code{imp}. Can also be \code{mids} object, the output of a call to \code{mice} from the \pkg{mice} package, containing multiply imputed data sets. In this case, \code{imp} is automatically supplied using the imputation variable created from processing the \code{mids} object.
}
  \item{continuous}{
whether mean differences for continuous variables should be standardized ("std") or raw ("raw"). Default "std". Abbreviations allowed. This option can be set globally using \code{\link{set.cobalt.options}}. This argument is used to set \code{std} in \code{\link{col_w_smd}}.
}
  \item{binary}{
whether mean differences for binary variables (i.e., difference in proportion) should be standardized ("std") or raw ("raw"). Default "raw". Abbreviations allowed. This option can be set globally using \code{\link{set.cobalt.options}}. This argument is used to set \code{std} in \code{\link{col_w_smd}}.
}
  \item{s.d.denom}{
whether the denominator for standardized differences (if any are calculated) should be the standard deviation of the treated group ("treated"), the standard deviation of the control group ("control"), the pooled standard deviation ("pooled", computed as the square root of the mean of the group variances), or the standard deviation in the full sample ("all"). Abbreviations allowed. If not specified, \code{bal.tab()} will figure out which one is best based on the \code{par} component of the \code{sbwcau} object: if "att", "treated"; if "atc", "control"; otherwise "pooled".
}
  \item{m.threshold}{
a numeric value for the threshold for mean differences.
}
  \item{v.threshold}{
a numeric value for the threshold for variance ratios. Will automatically convert to the inverse if less than 1.
}
  \item{ks.threshold}{
a numeric value for the threshold for Kolmogorov-Smirnov statistics. Must be between 0 and 1. 
}
  \item{cluster}{
either a vector containing cluster membership for each unit or a string containing the name of the cluster membership variable in \code{data} or the \code{sbwcau} object. See \code{\link{bal.tab.cluster}} for details.
}
  \item{imp}{
either a vector containing imputation indices for each unit or a string containing the name of the imputation index variable in \code{data} or the original data set used in the call to \code{sbw()}. See \code{\link{bal.tab.imp}} for details. Not necessary if \code{data} is a \code{mids} object.
}
  \item{abs}{
\code{logical}; whether displayed balance statistics should be in absolute value or not. 
}
  \item{subset}{
a \code{logical} vector denoting whether each observation should be included. It should be the same length as the variables in the original call to \code{sbw()}. \code{NA}s will be treated as \code{FALSE}. This can be used as an alternative to \code{cluster} to examine balance on subsets of the data.
}
  \item{quick}{
\code{logical}; if \code{TRUE}, will not compute any values that will not be displayed. Set to \code{FALSE} if computed values not displayed will be used later.
}
  \item{...}{
further arguments to control display of output. See \link[=options-display]{display options} for details.
}
}
\details{
\code{bal.tab.sbwcau()} generates a list of balance summaries for the \code{sbwcau} object given, and functions similarly to \code{summarize()} in \pkg{sbw}.

The threshold values (\code{m.threshold}, \code{v.threshold}, and \code{ks.threshold}) control whether extra columns should be inserted into the Balance table describing whether the balance statistics in question exceeded or were within the threshold. Including these thresholds also creates summary tables tallying the number of variables that exceeded and were within the threshold and displaying the variables with the greatest imbalance on that balance measure.

}
\value{

If clusters are not specified, an object of class \code{"bal.tab"} containing balance summaries for the \code{sbwcau} object. See \code{\link{bal.tab}} for details.

If clusters are specified, an object of class \code{"bal.tab.cluster"} containing balance summaries within each cluster and a summary of balance across clusters. See \code{\link{bal.tab.cluster}} for details.
}

\author{
Noah Greifer 
}

\seealso{
\code{\link{bal.tab}} for details of calculations.
}
\examples{
library(sbw); data("lalonde", package = "cobalt")

## Stable balancing weights for the ATT
sbw.out <- sbw(splitfactor(lalonde, drop.first = "if2"),
               ind = "treat",
               bal = list(bal_cov = c("age", "educ", "race_black", 
                                      "race_hispan", "race_white", 
                                      "married", "nodegree", 
                                      "re74", "re75"),
                          bal_alg = FALSE, 
                          bal_tol = .001),
               par = list(par_est = "att"))
bal.tab(sbw.out, un = TRUE, poly = 2)

}
\keyword{tables}