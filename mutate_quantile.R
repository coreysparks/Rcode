mutate_quantile_brks <- function (input, variable,n, ...) 
{
  var_string <- deparse(substitute(variable))
  quants <- classIntervals(input[[var_string]], style = "quantile",n=n, 
                          ...)$brks
  if (any(0 == quants)) 
    brk_vec <- quants
  else brk_vec <- c(0, quants)
  lab_length <- length(brk_vec) - 1
  brk_labs <- vector(mode = "character", length = lab_length)
  for (i in seq(lab_length)) {
    if (any(brk_vec%%1 != 0)) {
      brk_labs[i] <- paste0(round(brk_vec[i], 2), "-", 
                            round(brk_vec[i + 1], 2))
    }
    else if (any(brk_vec%%1 == 0)) {
      brk_labs[i] <- paste0(brk_vec[i], "-", brk_vec[i + 
                                                       1])
    }
  }
  input[[paste0(var_string, "_qbrks")]] <- cut(input[[var_string]], 
                                              breaks = brk_vec, labels = brk_labs, include.lowest = TRUE)
  return(input)
}
