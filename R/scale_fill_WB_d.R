#' Use WrensBookshelf with ggplot
#'
#' Wrapper function to allow easy integration with ggplot2. Sets discrete color scale.
#'
#' @param name Name of palette from WrensBookshelf.
#' @param direction Direction you want the palette to proceed;
#'     1 = direction shown in ShowBookshelf() or ShowBook(), -1 = reversed.
#' @param override.order Argument used to override the prescribed order
#'     that colors are selected from palettes for discrete palettes where n < length(palette). Default = FALSE.
#' @param ... See discrete_scale() for additional params.
#'
#' @return No return value, integrates WB_brewer into ggplot2 function.
#' @export
#'
#' @examples
#' ggplot2::ggplot(mtcars, ggplot2::aes(x = disp,y = wt, fill = factor(cyl)))+
#' ggplot2::geom_point(size = 3, shape = 21)+
#' scale_fill_WB_d(name = "YouMatter")
scale_fill_WB_d <- function(name, direction=1,override.order=FALSE,...) {
  WB.discrete <- function(name, direction = c(1, -1),
                          override.order = FALSE) {
    `%ni%` <- Negate(`%in%`)
    pal <- WrensBookshelf[[name]]
    if (is.null(pal) | is.numeric(name)){
      stop("Invalid palette name. Use ShowBookshelf() to see available palettes.")
    }
    if (direction %ni% c(1,-1)){
      warning("Direction is not valid, defaulting to 1. Please use 1 for normal palette, or -1 for a reversed palette.")
      direction <- 1
    }
    function(n) {
      if (direction == 1 & override.order == FALSE) {
        pal[[1]][sort(pal[[2]][1:n])]
        #pal[[1]][which(pal[[2]] %in% c(1:n) == TRUE)]
      }
      else if (direction == -1 & override.order == FALSE) {
        rev(pal[[1]][sort(pal[[2]][1:n])])
        #rev(pal[[1]][which(pal[[2]] %in% c(1:n) == TRUE)])
      }
      else if (direction == 1 & override.order == TRUE) {
        pal[[1]][1:n]
      }
      else {
        rev(pal[[1]])[1:n]
      }
    }
  }
  ggplot2::discrete_scale(aesthetics = "fill", scale_name = "WB_d",
                 palette = WB.discrete(name=name,direction = direction,
                                       override.order = override.order))
}
