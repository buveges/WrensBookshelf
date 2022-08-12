#' Use WrensBookshelf with ggplot
#'
#' Wrapper function to allow easy integration with ggplot2. Sets continuous color scale.
#'
#' @param name Name of palette from WrensBookshelf.
#' @param direction Direction you want the palette to proceed;
#'     1 = direction shown in ShowBookshelf() or ShowBook(), -1 = reversed.
#' @param ... See scale_color_gradientn() for additional params.
#'
#' @return No return value, integrates WB_brewer into ggplot2 function.
#' @export
#'
#' @examples
#' ggplot2::ggplot(mtcars, ggplot2::aes(x=disp,y=wt, color = mpg))+
#' ggplot2::geom_point(size=3)+
#' scale_color_WB_c(name = "WhatWellBuild")
scale_color_WB_c <- function(name, direction=1, ...) {
  `%ni%` <- Negate(`%in%`)
  if (direction %ni% c(1,-1)){
    warning("Direction is not valid, defaulting to 1. Please use 1 for normal palette, or -1 for a reversed palette.")
    direction <- 1
  }
  ggplot2::scale_color_gradientn(colors = WB_brewer(name=name,
                                           direction = direction,
                                           override.order=FALSE))
}
