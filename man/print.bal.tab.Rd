\name{print.bal.tab}
\alias{print.bal.tab}
\alias{print.bal.tab.cont}
\alias{print.bal.tab.cluster}
\alias{print.bal.tab.subclass}
\alias{print.bal.tab.cont.cluster}
\title{
Print Results of a Call to bal.tab()
}
\description{
Prints \code{bal.tab()} output in a clean way. Provides options for printing.}
\usage{
\method{print}{bal.tab}(x, disp.m.threshold = "as.is", disp.v.threshold = 
      "as.is", un = "as.is", disp.means = "as.is", 
      disp.v.ratio = "as.is", digits = max(3, 
      getOption("digits") - 3), ...)

\method{print}{bal.tab.cont}(x, disp.r.threshold = "as.is", un = "as.is", 
      digits = max(3, getOption("digits") - 3), ...)

\method{print}{bal.tab.subclass}(x, disp.m.threshold = "as.is", disp.v.threshold = 
      "as.is", un = "as.is", disp.means = "as.is", 
      disp.v.ratio = "as.is", disp.subclass = "as.is", 
      digits = max(3, getOption("digits") - 3), ...)

\method{print}{bal.tab.cluster}(x, disp.m.threshold = "as.is", disp.v.threshold = 
      "as.is", un = "as.is", disp.means = "as.is", 
      disp.v.ratio = "as.is", which.cluster, 
      cluster.summary = "as.is", cluster.fun = NULL,
      digits = max(3, getOption("digits") - 3), ...)

\method{print}{bal.tab.cont.cluster}(x, disp.r.threshold = "as.is", un = "as.is", 
      which.cluster, cluster.summary = "as.is", 
      cluster.fun = NULL, 
      digits = max(3, getOption("digits") - 3), ...)

}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
a \code{bal.tab} object; the output of a call to \code{bal.tab()}.
}
  \item{disp.m.threshold}{
whether to display output related to specifying \code{m.threshold} in the call to \code{bal.tab()}, which includes the Mean Difference Threshold column in the Balance table, the Mean Difference Balance Tally, and the variable with the Maximum Mean Difference Imbalance. Either \code{FALSE} or \code{"as.is"}.
}
  \item{disp.v.threshold}{
whether to display output related to specifying \code{v.threshold} in the call to \code{bal.tab()}, which includes the Variance Ratio Threshold column in the Balance table, the Variance Ratio Balance Tally, and the variable with the Maximum Variance Ratio Imbalance. Either \code{FALSE} or \code{"as.is"}.
}
  \item{un}{
whether to display balance values for the unadjusted sample. Ignored (and set to \code{TRUE}) if no conditioning was performed.
}
  \item{disp.means}{
whether to print the group means in balance output.
}
  \item{disp.v.ratio}{
whether to display variance ratios in balance output.
}
  \item{digits}{
the number of digits to display.
}
  \item{disp.r.threshold}{
whether to display output related to specifying \code{r.threshold} in the call to \code{bal.tab()} with a continuous treatment, which includes the Correlation Threshold column in the Balance table, the Correlation Balance Tally, and the variable with the Maximum Correlation Imbalance. Either \code{FALSE} or \code{"as.is"}.}
  \item{disp.subclass}{
whether to display balance information for individual subclasses if subclassification is used in conditioning.
}
  \item{which.cluster}{
which cluster(s) to display. If \code{NULL}, all clusters will be displayed. If \code{NA}, no clusters will be displayed. Otherwise, can be a vector of cluster names or numerical indices for which to display balance. Indices correspond to the alphabetical order of cluster names. To display the clusters requested in the original call to \code{bal.tab()}, omit this argument, as specifying \code{"as.is"} will request a cluster called "as.is.".
}
  \item{cluster.summary}{
whether to display the cluster summary table. If \code{which.cluster} is \code{NULL}, \code{cluster.summary} will be set to \code{TRUE}.
}
  \item{cluster.fun}{
a character vector of functions of balance statistics to display when dislaying balance across clusters. Can be "mean", "median", "min", or "max". More than one are allowed. "min" cannot be used if \code{quick = TRUE} in the original \code{bal.tab()} call.
}
  \item{\dots}{
further arguments passed to or from other methods.
}
}
\details{
Simply calling \code{bal.tab()} will print its results, but it can be useful to store the results into an object and print them again later, possibly with different print options specified. The \code{print()} function automatically dispatches the correct method for the \code{bal.tab} object given. For balance tables generated from using weighting, matching, or no adjustement with a binary treatment, \code{print.bal.tab()} will be used. For balance tables generated from using weighting or no adjustment with a continuous treatment, \code{print.bal.tab.cont()} will be used. For balance tables generated from using weighting, matching, or no adjustement with a binary treatment and with clusters, \code{print.bal.tab.cluster()} will be used. For balance tables generated from using subclassification, \code{print.bal.tab.subclass()} will be used. For balance tables generated from using weighting or no adjustement with a continuous treatment, \code{print.bal.tab.cont.cluster()} will be used.

For all paramaters except \code{disp.m.threshold}, \code{disp.v.threshold}, \code{disp.r.threshold}, and \code{which.cluster}, either omitting the argument or setting it to \code{"as.is"} will use the corresponding print option stored in the \code{bal.tab} object, which results from the original call to \code{bal.tab()}. 

For \code{disp.m.threshold}, \code{disp.v.threshold}, and \code{disp.r.threshold}, setting the argument to \code{FALSE} will display the results as if the corresponding threshold value had been omitted or set to \code{NULL} in the original call to \code{bal.tab()}. If the original threshold was omitted or set to \code{NULL}, a new threshold cannot be set without a new call to \code{bal.tab()}, so \code{TRUE} is not an acceptable option here.

For \code{which.cluster}, to retain the display option of the original call to \code{bal.tab()}, the argument must omitted, as using \code{"as.is"} would cause \code{print()} to attempt to display balance for a cluster called \code{"as.is"}. If such a cluster existed and it was desired, it would otherwise be impossible to display it.

Any paramater used in \code{bal.tab()} for calculations, such as \code{int}, \code{addl}, or \code{distance}, cannot be used with \code{print()}; only those parameters listed above, those that solely determine printing options, can be used. To change computation options, a new call to \code{bal.tab()} must be performed.
}
\note{
If \code{quick = TRUE} in the original call to \code{bal.tab()}, some values may not be calculated, in which case using \code{print()} will not display these values even when requested. For example, if \code{disp.means = FALSE} and \code{quick = TRUE} in the original call to \code{bal.tab()}, setting \code{disp.means = TRUE} in \code{print()} will not print the covariate means because they were not calculated.
}
\author{
Noah Greifer \email{noah@unc.edu}
}

\seealso{
\code{\link[base]{print}}, \code{\link{bal.tab}}
}
\examples{
\dontrun{
## Assuming x was generated with matchit(), ps(), or CBPS():
b <- bal.tab(x, un = TRUE, v.threshold = 2)
print(b, un = FALSE, disp.v.threshold = FALSE)
}
}