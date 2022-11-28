#' Get the alpha level
#'
#' @param level An integer level of the sunburst plot.
#'
#' @description Maps the level of the plot to an alpha value.
#'
#' @return A number between 0.5 and 1. The maximum value is 1 (lowest/innermost level) and the minimum value is 0.5 (highest/outermost level).
calculate_alpha_wo_fill <- function(
    level
){
  
  if(!is.numeric(level)){
    
    stop("Provide an integer level!!!")
    
  }
  
  alpha <- 0.5*(1+1/level)
  
  return(alpha)
  
}


#' Get the alpha level
#' 
#' @description A wrapper for [calculate_alpha_wo_fill()] with 0 alpha values for non filled parts.
#'
#' @param level An integer level of the sunburst plot.
#' @param fill A character vector (or a factor) with the fill levels. 
#'
#' @return A number between 0.5 and 1. The maximum value is 1 (lowest/innermost level) and the minimum value is 0.5 (highest/outermost level). 0 if the fill is `NA`.
#'
#' @details The value of the fill is not important. The only importance of the argument is to check if the fill is missing or not.
calculate_alpha <- function(
    level, 
    fill
){
  
  if(length(level) != length(fill)){
    
    stop("level and fill lengths should be equal!!!")
    
  }
  
  alpha <- ifelse(
    test = is.na(fill),
    yes = 0,
    no = calculate_alpha_wo_fill(level)
  )
  
  return(alpha)
  
}
