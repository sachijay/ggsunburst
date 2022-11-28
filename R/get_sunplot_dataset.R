#' Get a prepared dataset to draw the sunburst plot.
#' 
#' @description Creates a dataset prepared as input to the `draw_sunburst_plot` function.
#'
#' @param .dat The data frame or a tibble with the variables and the values for the plot. See the example for the input dataset structure.
#' @param ... Variables in `.dat` that matches the order of the circles in the sunburst plot (innermost to outermost).
#' @param .count_var The variable with the values to decide the sizes of the circles. 
#' 
#' @details The returned dataset includes the following columns.  
#' - `.name`: Label of the segment.
#' - `.level`: Level of the sunburst plot. Level 1 is the innermost level.
#' - `.fill`: Value for the fill variable. This is not the final colour in the plot, but the same value will have the same colour for all levels.
#' - `.box_min` & `.box_max`: Minimum and maximum bounds for the segment.
#' - `.alpha`: The transparency for that level.
#' - `.angle`: The angle of the text label.
#'
#' @return A tibble to provide as input to the `draw_sunburst_plot` function. See details for the list of variables.
#' 
#' @export
#'
#' @examples
#' in_dat <- tibble::tibble(
#' level1_var = c(
#' rep("l1 A", times = 3),
#' rep("l1 B", times = 4)
#' ),
#' level2_var = c(
#' "l2 A", "l2 A", "l2 B", 
#' "l2 C", "l2 C", "l2 D", "l2 D"
#' ),
#' level3_var = c(
#' "l3 A", "l3 B", "l3 C", 
#' "l3 D", "l3 E", "l3 F", "l3 G"
#' ),
#' values_var = c(
#' 123, 456, 798, 
#' 987, 654, 321, 159
#' )
#' )
#' 
#' in_dat
#' 
#' 
#' get_sunplot_dataset(
#' .dat = in_dat,
#' level1_var, level2_var, level3_var,
#' .count_var = values_var
#' )
get_sunplot_dataset <- function(
    .dat,
    ...,
    .count_var
){
  
  n_levels <- rlang::dots_n(...)
  dots_vars <- rlang::enquos(...)
  
  l0 <- tibble::tibble(
    .name = NA,
    .level = 0,
    .fill = NA,
    .box_min = 0,
    .box_max = 1
  )
  
  l <- lapply(
    1:n_levels,
    function(level){
      
      dat_level_grouped <- dplyr::group_by(
        .dat,
        !!!dots_vars[1:level]
      )
      
      dat_level_summarised <- dplyr::summarise(
        .data = dat_level_grouped,
        .value = sum({{ .count_var }}),
        .groups = "drop"
      )
      
      dat_level_arranged <- dplyr::arrange(
        .data = dat_level_summarised,
        !!!dots_vars[1:level]
      )
      
      dat_level_mutated <- dplyr::mutate(
        .data = dat_level_arranged,
        .level = level,
        .fill = !!dots_vars[[1]],
        .perc = .value/sum(.value),
        .box_max = cumsum(.perc),
        .box_min = .box_max - .perc
      )
      
      dat_level <- dplyr::select(
        .data = dat_level_mutated,
        .name = !!dots_vars[[level]], 
        .level, 
        .fill, 
        .box_min, 
        .box_max
      )
      
      return(dat_level)
      
    })
  
  plot_dat_combined <- dplyr::bind_rows(l0, l)
  
  plot_dat <- dplyr::mutate(
    .data = plot_dat_combined,
    .level = as.integer(.level),
    .alpha = calculate_alpha(.level, .fill),
    .angle = calculate_angle(.box_min, .box_max)
  )
  
  return(plot_dat)
  
}
