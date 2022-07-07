#' Customize WrensBookshelf palettes
#'
#' Function used to create continuous/discrete palettes using the palettes in WrensBookshelf.
#'
#' @param name Name of palette from WrensBookshelf
#' @param n Number of colors to select, or size of continuous palette if n > length(palette)
#' @param type Type of palette you wish to generate ("continuous" or "discrete")
#' @param direction Direction you want the palette to proceed; 1 = direction shown in ShowBookshelf() or ShowBook(), -1 = reversed.
#' @param override.order Argument used to override the prescribed order that colors are selected from palettes for discrete palettes where n < length(palette). Default = FALSE.
#'
#' @return A color palette.
#' @export
#'
#' @examples
#' WB_brewer(name = "BabyWrenAndTheGreatGift", type = "continuous", n = 200)
#' WB_brewer(name = "JulienIsAMermaid", type = "discrete",
#'           direction = -1, n = 7, override.order = TRUE)
WB_brewer <- function(name,n,type = c("discrete", "continuous"), direction = c(1,-1),override.order=FALSE){
  `%ni%` <- Negate(`%in%`)
  pal <- WrensBookshelf[[name]]
  if (is.null(pal) | is.numeric(name)){
    stop("Invalid palette name. Use ShowBookshelf() to see available palettes.")
  }
  if (missing(n)){
    n <- length(pal[[1]])
  }
  if (missing(direction)){
    direction <- 1
  }
  if (direction %ni% c(1,-1)){
    warning("Direction is not valid, defaulting to 1. Please use 1 for normal palette, or -1 for a reversed palette.")
    direction <- 1
  }
  if (missing(type)) {
    if (n > length(pal[[1]])) {
      type <- "continuous"
    }
    else {
      type <- "discrete"
    }
  }
  type <- match.arg(type)
  if (type == "discrete" && n > length(pal[[1]])) {
    stop("*n* is too large for the selected palette of discrete colors, plase use type = continuous instead, or reduce *n*.")
  }
  continuous <- if (direction == 1) {
    (grDevices::colorRampPalette(pal[[1]]))(n)
  }
  else {
    (grDevices::colorRampPalette(rev(pal[[1]])))(n)
  }
  discrete <- if (direction == 1 & override.order == FALSE) {
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
  out <- switch(type, continuous = continuous, discrete = discrete)
  structure(out, class = "palette", name = name)
}

# Function for printing palette

#' @export
#' @importFrom grDevices rgb
#' @importFrom graphics rect par image text

print.palette <- function(x, ...) {
  n <- length(x)
  old <- par(mar = c(0.5, 0.5, 0.5, 0.5))
  on.exit(par(old))

  image(1:n, 1, as.matrix(1:n), col = x,
        ylab = "", xaxt = "n", yaxt = "n", bty = "n")

  rect(0, 0.92, n + 1, 1.08, col = rgb(1, 1, 1, 0.8), border = NA)
  text((n + 1) / 2, 1, labels = attr(x, "name"), cex = 1.5, family = "serif")
}
