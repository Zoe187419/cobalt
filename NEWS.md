`cobalt` News and Updates
======

Version 3.10.0

* Added support for `mimids` and `wimids` objects from `MatchThem`.

* Added `sample.names` argument in `bal.plot` in response to this [post](https://stackoverflow.com/questions/57970679/change-name-of-groups-in-bal-plot) on Cross Validated.

* Added functionality to the `which` argument in `bal.plot`, allowing more specificity when multipel weights are used.

Version 3.9.0

* Added vignette for use of `love.plot`.

* Changed `grid` version requirement.

* Updated README.

* Fixed bugs that would occur when using `love.plot()` with various combinations of `var.order`, multiple `stats`, and `agg.fun = "range"`.

* Fixed bugs that would occur when using `bal.tab()` with objects from the `Matching` package. Calculated statistics are now the same as those generated using `Matching::MatchBalance`. Changes based on updates to `get.w.Match()`.

* Added balance summary functions `col_w_mean`, `col_w_sd`, `col_w_smd`, `col_w_vr`, `col_w_ks`, `col_w_ovl`, and `col_w_corr`. These make it easier to get quick, simple summaries of balance without calling `bal.tab`, for example, for use in programming other functions. Some of these are now used inside `bal.tab` to increase speed and simplify internal syntax.

* Other small bug fixes.

Version 3.8.0

* Added the ability to display balance on multiple measures (e.g., mean differences, variance ratios, KS statistics) at the same time with `love.plot()`.

* Bug fixes that make `bal.tab()` and `love.plot()` more usable within other functions and especially when called with `do.call()`.

* Made it easier to get proper `bal.tab` output when using `matchit()` with an argument to `distance` (in the call to `matchit()`). Include the original dataset in the `data` argument of `bal.tab()` to get the variables to display correctly.

* Changed the default shape in `love.plot()` to `"circle"`, which is a solid circle. I found this a prettier alternative to the open circle, especially on Windows. To get back open circles you set `shapes = "circle filled"` (yes, that is a bit confusing).

* Added ability to hide the gridlines easily in `love.plot()`.

* Changed the calculation of standard deviations (and standardized differences in proportion) for binary variables to be more in line with recommendations, as noted by @mbloechl05. Note this will make these values different from those in `MatchIt::summary` by a small amount.

* The KS statistic is now computed for binary variables. It is simply the difference in proportion.

* Allowed some methods to accept `mids` objects (the output of a call to `mice::mice()`) in the `data` argument to supply multiply imputed data. This essentially replaces `data = complete(imp.out, "long"), imp = ".imp"` with `data = imp.put`, assuming `imp.out` is a `mids` object.

* Other bug fixes and improvements.

Version 3.7.0

* Changes to some `bal.tab` defaults: `quick` is now set to `TRUE` by default. Adjusted and unadjusted means, standard deviations, and mean differences will always be computed, regardless of `quick`. Variance ratios and KS statistics will only be computed if `quick = FALSE` or `disp.v.ratio` or `disp.ks`, respectively, are `TRUE`.

* Variance ratios now respond to `abs`. When `abs = FALSE`, the default in `bal.tab`, the variance is ratio is the variance of the treated (1) divided by the variance of the control (0). When `abs = TRUE`, the numerator of the variance ratio is the larger variance and the denominator is the smaller variance, which was the old behavior. `v.threshold` still responds as if `abs` was set to `TRUE`, just like with mean differences. Any time variance ratios are aggregated (e.g., across imputations or clusters), the "mean" variance ratio is the geometric mean to account for the asymmetry in the ratios.

* `love.plot` has several changes that make it much more user-friendly. First, rather than supplying a `bal.tab` object to `love.plot`, you can simply supply the arguments that would have gone into the `bal.tab()` call straight into `love.plot()`. Second, if `quick = TRUE` (the new default) and the first argument to `love.plot()` is a call to `bal.tab()` (or arguments provided to `bal.tab()`) and `stat` is set to `"variance.ratios"` or `"ks.statistics"`, `bal.tab()` will be re-called with the corresponding `disp` argument set to `TRUE` so that `love.plot()` will display those statistics regardless of `quick`. This will not work if the argument supplied to `love.plot()` is a `bal.tab` object. Third, because unadjusted mean differences are computed regardless of `quick`, there will never be a circumstance in which only adjusted values will be displayed. If `quick = TRUE`, `un = FALSE`, and `stat` is `"variance.ratios"` or `"ks.statistics"`, `un` will automatically be set to `TRUE` in the `bal.tab()` re-call.

* When using `which.` arguments (e.g., `which.cluster`, `which.imp`, etc.), instead of supplying `NULL` and `NA`, you can supply `.all` and `.none` (not in quotes). This should make them easier to use. Note that these new inputs are not variables; they are keywords and are evaluated using nonstandard evaluation. If you actually have objects with those names, they will be ignored.

* Bugs in scoping related to the formula interface have been solved, in particularly making `bal.tab()` more usable within other functions.

* Fixed bug occurring when using `matchit` objects having set `discard` to something other than `NULL` and `reestimate = TRUE` in the call to `matchit()`. Thank you to Weiyi Xie for finding this bug.

* Fixed bug occurring when using balance thresholds with subclassification.

* Fixed bug occurring when printing `bal.tab` output for continuous treatments with clusters.

* Fixed bug occurring when using `bal.tab()` on `mnps` objects with multiple stop methods.

Version 3.6.1

* Fixed bug when installed version of R was earlier than 3.5.0.

Version 3.6.0

* Added `poly` argument to `bal.tab()` to display polynomials of continuous covariates (e.g., squares, cubes, etc.). This used to only be available with the `int` argument, which also displayed all interactions. Now, the polynomials can be requested separately. When `int = TRUE`, squares of the covariates will no longer be displayed; to replicate the old behavior, set `int = 2`, which is equivalent to `int = TRUE, poly = 2`.

* Fixed a bug where using `subset` would produce an error.

* Fixed a bug when using multiply imputed data with binary treatments that were factors or characters.

* Updated the `bal.tab` documentation to make it easier to navigate to the right page.

* Small documentation and syntax updates.

* Added the hidden and undocumented argument `center` to `bal.tab`, which, when set to `TRUE`, centers the covariates at the mean of the entire unadjusted sample prior to computing interactions and polynomials.

* Added `set.cobalt.options` function to more easily set the global options that can be used as defaults to some arguments. For example, `set.global.options(binary = "std")` makes it so that standardized mean difference are always displayed for binary covariates (in the present R session). The options can be retrieved with `get.cobalt.options`.

Version 3.5.0

* Several changes to `bal.tab()` display options (i.e., `imbalanced.only`, `un`, `disp.means`, `disp.v.ratio`, `disp.ks`, `disp.bal.tab`, `disp.subclass`, and parameters related to the display of balance tables with multinomial treatments, clusters, multiple imputations, and longitudinal treatments). First, the named arguments have been removed from the method-specific functions in order to clean them up and make it easier to add new functions, but they are still available to be specified. Second, a help page devoted just to these functions has been created, which can be accessed with `?options-display`. Third, global options for these arguments can be set with `options()` so they don't need to be typed each time. For example, if you wanted `un = TRUE` all the time, you could set `options(cobalt_un = TRUE)` once and not have to include it in the call to `bal.tab()`.

* Added `disp.sds` option to display standard deviations for each group in `bal.tab()`. This works in all the same places `disp.means` does.

* Added `cluster.fun` and `imp.fun` options to request that only certain functions (e.g., mean or maximum) of the balance statistics are displayed in the summary across clusters/imputations. Previously this option was only available by call `print()`. These parameters are part of the display options described above, so they are documented in `?options-display` and not in the `bal.tab` help files.

* Added `factor_sep` and `int_sep` options to change the separators between variable names when factor variables and interactions are displayed. This functionality had been available since version 3.4.0 but was not documented. It is now documented in the new `display_options` help page.

* In `bal.tab()`, `continuous` and `binary` can be specified with the global options `"cobalt_continuous"` and `"cobalt_binary"`, respectively, so that a global setting (e.g., to set `binary = "std"` to view standardized mean difference rather than raw differences in proportion for binary variables) can be used instead of specifying the argument each time in the call to `bal.tab()`.

* Minor updates to `f.build()` to process inputs more flexibly. The left hand side can now be empty, and the variables on the right hand side can now contain spaces.

* Fixed a bug when logical treatments were used. Thanks to @victorn1.

* Fixed a bug that would occur when a variable had only one value. Thanks to @victorn1.

* Made it so the names of 0/1 and logical variables are not printed with `"_1"` appended to them. Thanks to @victorn1 for the suggestion.

* Major updates to the organization of the code and help files. Certain functions have simplified syntax, relying more on `...`, and help pages have been shorted and consolidated for some methods. In particular, the code and help documents for the `Matching`, `optmatch`, `ebal`, and `designmatch` methods of `bal.tab()` have been consolidated since they all rely on exactly the same syntax.

Version 3.4.1

* Fixed a bug that would occur when `imabalanced.only = TRUE` in `bal.tab()` but all variables were balanced.

* Fixed a bug where the mean of a binary variable would be displayed as 1 minus its mean.

* Fixed a bug that would occur when missingness patterns were the same for multiple variables.

* Fixed a bug that would occur when a distance measure was to be assessed with `bal.tab()` and there were missing values in the covariates (thanks to Laura Helmkamp).

* Fixed a bug that would occur when `estimand` was supplied by the user when using the `default` method of `bal.tab()`.

* Fixed a bug where non-standard variable names (like `"I(age^2)"`) would cause an error.

* Fixed a bug where treatment levels that had different numbers of characters would yield an error.

* Added `disp.means` option to `bal.tab` with continuous treatments.

Version 3.4.0

* Added `default` method for `bal.tab` so it can be used with specially formatted output from other packages (e.g., from `optweight`). `bal.plot` should work with these outputs too. This, of course, will never be completely bug-free because infinite inputs are possible and cannot all be processed perfectly. Don't try to break this function :)

* Fixed some bugs occurring when standardized mean differences are not finite, thanks to Noémie Kiefer.

* Speed improvements in `bal.plot`, especially with multiple facets, and in `bal.tab`.

* Added new options to `bal.plot`, including the ability to display histograms rather than densities and mirrored rather than overlapping plots. This makes it possible to make the popular mirrored histogram plot for propensity scores. In addition, it's now easier to change the colors of the components of the plots.

* Made behavior around binary variables with interactions more like documentation, where interactions with both levels of the variable are present (thanks to @victorn1). Also, replaced `_` with ` * ` as the delimiter between variable names in interactions. For the old behavior, use `int_sep = "_"` in `bal.tab`.

* Expanded the flexibility of `var.names` in `love.plot` so that replacing the name of a variable will replace it everywhere it appears, including interactions. Thanks to @victorn1 for the suggestion.

* Added `var.names` function to extract and save variable names from `bal.tab` objects. This makes it a lot easier to create replacement names for use in `love.plot`. Thanks to @victorn1 for the suggestion.

* When weighted correlations are computed for continuous treatments, the denominator of the correlation now uses the unweighted standard deviations. See `?bal.tab` for the rationale.

Version 3.3.0

* Added methods for objects from the `designmatch` package.

* Added methods for `ps.cont` objects from the `WeightIt` package.

* Fixed bugs resulting form changes to how formula inputs are handled.

* Cleaned up some internal functions, also fixing some related bugs

* Added `subset` option in all `bal.tab()` methods (and consequently in `bal.plot()`) that allows users to specify a subset of the data to assess balance on (i.e., instead of the whole data set). This provides a workaround for methods were the `cluster` option isn't allowed (e.g., longitudinal treatments) but balance is desired on subsets of the data. However, in most cases, `cluster` with `which.cluster` specified makes more sense.

* Updated help files, in particular, more clearly documenting methods for `iptw` objects from `twang` and `CBMSM` objects from `CBPS`.

* Added pretty printing with `crayon`, inspired by Jacob Long's `jtools` package

* Added `abs` option to `bal.tab` to display absolute values of statistics, which can be especially helpful for aggregated output. This also affects how `love.plot()` handles aggregated balance statistics.

Version 3.2.3

* Added support for data with missing covariates. `bal.tab()` will produce balance statistics for the non-missing values and will automatically create a new variable indicating whether the variable is missing or not and produce balance statistics on this variable as well. 

* Fixed a bug when displaying maximum imbalances with subclassification.

* Fixed a bug where the unadjusted statistics were not displayed when using `love.plot()` with subclasses. (Thanks to Megha Joshi.)

* Add the ability to display individual subclass balance using `love.plot()` with subclasses.

* Under-the-hood changes to how `weightit` objects are handled.

* Objects in the environment are now handled better by `bal.tab()` with the formula interface. The `data` argument is now optional if all variables in the formula exist in the environment.

Version 3.2.2

* Fixed a bug when using `get.w()` (and `bal.tab()`) with `mnps` objects from `twang` with only one stop method.

* Fixed a bug when using `bal.tab()` with `twang` objects that contained missing covariate values.

* Fixed a bug when using `int = TRUE` in `bal.tab()` with few covariates.

* Fixed a bug when variable names had special characters.

* Added ability to check higher order polynomials by setting `int` to a number.

* Changed behavior of `bal.tab()` with multinomial treatments and `s.d.denom = "pooled"` to use the pooled standard deviation from the entire sample, not just the paired treatments.

* Restored some vignettes that required `WeightIt`.

Version 3.2.1

* Edits to vignettes and help files to respond to missing packages. Some vignette items may not display if packages are (temporarily) unavailable.

* Fixed issue with sampling weights in `CBPS` objects. (Thanks to @kkranker on Github.)

* Added more support for sampling weights in `get.w()` and help files.

Version 3.2.0

* Added support for longitudinal treatments in `bal.tab()`, `bal.plot()`, and `love.plot()`, including output from `iptw()` in `twang`, `CBMSM()` from `CBPS`, and `weightitMSM()` from `WeightIt`.

* Added a vignette to explain use with longitudinal treatments.

* Edits to help files.

* Added ability to change density options in `bal.plot()`.

* Added support for `imp` in `bal.tab()` for `weightit` objects.

* Fixed bugs when limited variables were present. (One found and fixed by @sumtxt on Github.)

* Fixed bug with multiple methods when weights were entered as a list.

Version 3.1.0

* Added full support for tibbles.

* Examples for `weightit` methods in documentation and vignette now work.

* Improved speed and performance.

* Added `pairwise` option for `bal.tab()` with multinomial treatments.

* Increased flexibility for displaying balance using `love.plot()` with clustered or multiply imputed data.

* Added `imbalanced.only` and `disp.bal.tab` options to `bal.tab()`.

* Fixes to the vignettes. Also, creation of a new vignette to simplify the main one.

Version 3.0.0

* Added support for multinomial treatments in `bal.tab()`, including output from `CBPS` and `twang`.

* Added support for `weightit` objects from `WeightIt`, including for multinomial treatments.

* Added support for `ebalance.trim` objects from `ebal`.

* Fixes to the vignette.

* Fixes to `splitfactor()` to handle tibbles better. 

* Fixed bug when using `bal.tab()` with multiply imputed data without adjustment. Fixed bug when using `s.weights` with the `formula` method of `bal.tab()`.

Version 2.2.0

* Added `disp.ks` and `ks.threshold` options to `bal.tab()` to display Kolmogorov-Smirnov statistics before and after preprocessing.

* Added support for sampling weights, which are applied to both control and treated units, using option `s.weights` in `bal.tab()`. Sampling weights are also now compatible with the sampling weights in `ps` objects from `twang`; the default is to apply the sampling weights before and after adjustment, mimicking the behavior of `bal.table()` in `twang`.

* Changed behavior of `bal.tab()` for `ps` objects to allow displaying balance for more than one stop method at a time, and to default to displaying balance for all available stop methods. The `full.stop.method` argument in `bal.tab()` has been renamed `stop.method`, but `full.stop.method` still works. `get.w()` for `ps` objects has also gone through some changes to be more like `twang`'s `get.weights()`.

* Added support in `bal.tab()` and `bal.plot()` for subclassification with continuous treatments.

* Added support in `splitfactor()` and `unsplitfactor()` for `NA` values

* Fixed a bug in `love.plot()` caused when `var.order` was specified to be a sample that was not present.

Version 2.1.0

* Added support in `bal.tab()`, `bal.plot()`, and `love.plot()` for examining balance on multiple weight specifications at a time

* Added new utilities `splitfactor()`, `unsplitfactor()`, and `get.w()`

* Added option in `bal.plot()` to display points sized by weights when treatment and covariate are continuous

* Added `which = "both"` option in `bal.plot()` to simultaneously display plots for both adjusted and unadjusted samples; changed argument syntax to accommodate

* Allowed `bal.plot()` to display balance for multiple clusters and imputations simultaneously

* Allowed `bal.plot()` to display balance for multiple subclasses simultaneously with `which.sub`

* Fixes to `love.plot()` to ensure adjusted points are in front of unadjusted points; changed colors and shape defaults and allowable values

* Fixed bug where `s.d.denom` and `estimand` were not functioning correctly in `bal.tab()`

* `distance`, `addl`, and `weights` can now be specified as lists of the usual arguments

Version 2.0.0

* Added support for matching using the `optmatch` package or by specifying matching strata.

* Added full support (`bal.tab()`, `love.plot()`, and `bal.plot()`) for multiply imputed data, including for clustered data sets.

* Added support for multiple distance measures, including special treatment in `love.plot()`

* Adjusted specifications in `love.plot()` for color and shape of points, and added option to generate a line connecting the points.

* Adjusted `love.plot()` display to perform better on Windows.

* Added capabilities for `love.plot()` and `bal.plot()` to display plots for multiple groups at a time

* Added flexibility to `f.build()`.

* Updated `bal.plot()`, giving the capability to view multiple plots for subclassified or clustered data. Multinomial treatments are also supported.

* Created a new vignette for clustered and multiply imputed data

* Speed improvements

* Fixed a bug causing mislabelling of categorical variables

* Changed calculation of weighted variance to be in line with recommendations; `CBPS` can now be used with standardized weights

Version 1.3.1

* Added support for entropy balancing through the `ebal` package.

* Changed default color scheme of `love.plot()` to be black and white and added options for color, shape, and size of points.

* Added sample size calculations for continuous treatments.

* Edits to the vignette.
    
Version 1.3.0

* Increased capabilities for cluster balance in `bal.tab()` and `love.plot()`

* Increased information and decreased redundancy when assessing balance on interactions

* Added `quick` option for `bal.tab()` to increase speed

* Added options for `print()`

* Bug fixes

* Speed improvements

* Edits to the vignette

Version 1.2.0

* Added support for continuous treatment variables in `bal.tab()`, `bal.plot()`, and `love.plot()`

* Added balance assessment within and across clusters

* Other small performance changes to minimize errors and be more intuitive

* Major revisions and adjustments to the vignette

Version 1.1.0

* Added a vignette.

* Fixed error in `bal.tab.Match()` that caused wrong values and and warning messages when used.

* Added new capabilities to `bal.plot()`, including the ability to view unadjusted sample distributions, categorical variables as such, and the distance measure. Also updated documentation to reflect these changes and make `which.sub` more focal.

* Allowed subclasses to be different from simply 1:S by treating them like factors once input is numerical

* Changed column names in Balance table output to fit more compactly, and updated documentation to reflect these changes.

* Other small performance changes to minimize errors and be more intuitive.