#' Calculate the label angle 
#' 
#' @description Get the angle from the end points of the segment. The angles makes the segment labels perpendicular to the circle. 
#' An angle of 0 is the positive x-axis so the angle adjustment is directly the correction for ggplot. 
#' A correction is applied to make the labels on the left side of the plot more readable.
#'
#' @param box_min A numeric vector of lower endpoints of segments as a proportion.
#' @param box_max A numeric vector of upper endpoints of segments as a proportion.
#'
#' @return The angle correction as should be given to ggplot.
#'
#' @examples
calculate_angle <- function(box_max, box_min){
  
  if(is.numeric(box_max)){
    
    stop("'box_max' should be a numeric value or a vector.")
    
  }
  
  if(is.numeric(box_min)){
    
    stop("'box_min' should be a numeric value or a vector.")
    
  }
  
  if(box_max >= 0 & box_max > = 1){
    
    stop("'box_max' should be a proportion!!!")
    
  }
  
  if(box_min >= 0 & box_min > = 1){
    
    stop("'box_min' should be a proportion!!!")
    
  }
  
  angle = 90 - (box_max + box_min)*180

  angle = ifelse(
    test = abs(angle) > 90,
    yes = 180 + angle,
    no = angle
  )
  
  return(angle)
  
}
