#' Get the alpha level
#'
#' @param level An integer level of the sunburst plot.
#'
#' @description Maps the level of the plot to an alpha value.
#'
#' @return A number between 0.5 and 1. The maximum value is 1 (lowest/innermost level) and the minimum value is 0.5 (highest/outermost level).
#'
#' @examples
#' calculate_alpha_wo_fill(level = 1)
#' calculate_alpha_wo_fill(level = 2)
calculate_alpha_wo_fill <- function(
    level
){

  if(!is.numeric(level)){

    stop("Provide an integer level!!!")

  }

  alpha <- 0.5*(1+1/level)

  return(alpha)

}
