#' Create the sunburst plot.
#'
#' @param .dat A data frame (or tibble) for the plot with specific requirements. Use the `get_sunplot_dataset()` to generate this dataset.
#' @param .label_txt_size A numeric value with the size of the text labels.
#' @param ... Passed to `ggplot2::scale_fill_brewer()` allowing to change plot colours.
#'
#' @return A ggplot object.
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
#' plot_dat <- get_sunplot_dataset(
#' .dat = in_dat,
#' level1_var, level2_var, level3_var,
#' .count_var = values_var
#' )
#' 
#' draw_sunburst_plot(
#' .dat = plot_dat,
#' .label_txt_size = 4,
#' palette = "Dark2"
#' )
draw_sunburst_plot <- function(
    .dat, 
    .label_txt_size = 1,
    ...
){
  
  p <- ggplot2::ggplot(
    data = .dat,
    mapping = ggplot2::aes(
      xmin = .level,
      xmax = .level + 1,
      ymin = .box_min,
      ymax = .box_max,
      fill = .fill,
      label = .name
    )
  ) + 
    ggplot2::geom_rect(
      mapping = ggplot2::aes(
        alpha = .alpha
      ),
      colour = ifelse(is.na(.dat$.fill), NA, "gray90")
    ) + 
    ggplot2::geom_text(
      mapping = ggplot2::aes(
        x = .level + 0.5,
        y = (.box_max + .box_min)/2,
        angle = .angle
      ),
      size = .label_txt_size
    ) + 
    ggplot2::coord_polar(
      theta = "y"
    ) +
    ggplot2::scale_fill_brewer(
      ..., 
      na.translate = F) + 
    ggplot2::theme_void() +
    ggplot2::theme(
      legend.position = "none"
    )
  
  return(p)
  
}
