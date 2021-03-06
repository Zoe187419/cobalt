\name{class-bal.tab.subclass}
\alias{class-bal.tab.subclass}

\title{Using \code{bal.tab()} with Subclassified Data}

\description{
When using \code{bal.tab()} with subclassified data, i.e., data split into subclasses where balance may hold, the output will be different from the standard, non-subclassified case, and there is an additional option for controlling display. This page outlines the outputs and options in this case.

There are two main components of the output of \code{bal.tab()} with subclassified data: the balance within subclasses and the balance summary across subclasses. The within-subclass balance displays essentially are standard balance displays for each subclass, except that only "adjusted" values are available, because the subclassification itself is the adjustment.

The balance summary is, for each variable, like a weighted average of the balance statistics across subclasses. This is computed internally by assigning each individual a weight based on their subclass and treatment group membership and then computing weighted balance statistics as usual with these weights. This summary is the same one would get if subclasses were supplied to the \code{match.strata} argument rather than to \code{subclass}. Because the means and mean differences are additive, their computed values will be weighted averages of the subclass-specific values, but for other statistics, the computed values will not be. 

}
\arguments{
There are two arguments for \code{bal.tab()} that relate to subclasses: \code{subclass} and \code{disp.subclass}.
\item{subclass}{For the data.frame and formula methods of \code{bal.tab}, a vector of subclass membership or the name of the variable in \code{data} containing subclass membership. When using subclassification with a function compatible with \pkg{cobalt}, such as \code{matchit()} in \pkg{MatchIt}, this argument can be omitted because the subclass are in the output object.}
\item{disp.subclass}{This is a display option that does not affect computation. If \code{TRUE}, balance for each subclass will be displayed. This can be cumbersome with many subclasses or covariates. The default is \code{FALSE}.}
}
\value{
The output is a \code{bal.tab.subclass} object, which inherits from \code{bal.tab}. It has the following elements:

\item{Subclass.Balance}{A list of data frames containing balance information for each covariate in each subclass.}

\item{Balance.Across.Subclass}{A data frame containing balance statistics for each covariate aggregated across subclasses and for the original sample (i.e., unadjusted). See \code{\link{bal.tab}} for details on what this includes.}
}

\author{
Noah Greifer 
}

\seealso{
\code{\link{bal.tab}}, \code{\link{bal.tab.data.frame}}, \code{\link{print.bal.tab.subclass}}
}