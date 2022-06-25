#' Customize WrensBookshelf palettes
#'
#' Function used to create customized continuous/discrete palettes using the palettes in WrensBookshelf, offering more specific control over selected colors than WB_brewer.
#'
#' @param name Name of palette from WrensBookshelf.
#' @param n Number of colors to select/subset.
#' @param LCR Location from which you want select n colors from in specified palette ("left","right", "center"). Can also use a vector of specific color numbers within palette (e.g. c(1,4,7))
#' @param type Type of palette you wish to generate ("continuous" or "discrete")
#' @param direction Direction you want the palette to proceed; 1 = direction shown in ShowBookshelf() or ShowBook(), -1 = reversed.
#' @param n2 If type = "continuous", length of palette to generate.
#'
#' @return Color palette.
#' @export
#' @importFrom graphics barplot par title
#'
#' @examples
#' WB_subset_brewer(name = "JulienIsAMermaid", n = 5,
#'                  LCR = "left", type = "continuous", n2 = 200)
#' WB_subset_brewer(name = "WhereTheWildThingsAre", type = "discrete", LCR = c(1,4,5,6))
WB_subset_brewer <- function(name, n=NA, LCR, type = c("continuous","discrete"),
         direction = c(1,-1), n2=NULL) {
  `%ni%` <- Negate(`%in%`)
  pal <- WrensBookshelf[[name]]
  if (is.null(pal) | is.numeric(name)){
    stop("Invalid palette name. Use ShowBookshelf() to see available palettes.")
  }
  if (missing(n) && !is.vector(LCR)){
    n <- length(pal[[1]])
    warning("*n* not specified, defaulting to length of palette")
  }
  if (missing(n) && is.vector(LCR)){
    n <- length(LCR)
  }
  if (missing(direction)){
    direction <- 1
  }
  if (direction %ni% c(1,-1)){
    warning("Direction is not valid, defaulting to 1. Please use 1 for normal palette, or -1 for a reversed palette.")
    direction <- 1
  }
  if(missing(LCR)){
    LCR = "center"
    warning("LCR not specified, defaulting to 'center'. Options include 'left', 'center',
            'right' or a vector of desired color indexes.")
  }
  if(!is.character(LCR)) {
    colors <- pal[[1]][LCR]
  }
  else {
    if(LCR == "left") {
      s = 1
      e = n
    }
    else if(LCR == "center") {
      if( length(pal[[1]]) %% 2 == 0){
        s = length(pal[[1]])/2 - n/2 +1
        e =length(pal[[1]])/2 + n/2
      }
      else {
        s = (length(pal[[1]])/2+0.5) - (n/2-0.5)
        e = (length(pal[[1]])/2+0.5) + (n/2-0.5)
      }
    } else if (LCR == "right") {
      s = length(pal[[1]])-n
      e = length(pal[[1]])
    }
    colors <- pal[[1]][s:e]
  }
  if (missing(type)) {
    if (n > length(colors)) {
      type <- "continuous"
    }
    else {
      type <- "discrete"
    }
  }
  type <- match.arg(type)
  if (type == "discrete" && n > length(colors)) {
    stop("*n* is too large for the selected palette of discrete colors, plase use type = continuous instead, or reduce *n*.")
  }
  if(missing(n2) && type == "continuous") {
    n2 <- 20
    warning("*n2* is missing for a continuous scale, defaulting to n2 = 20")
  }
  continuous <- if (direction == 1) {
    (grDevices::colorRampPalette(colors))(n2)
  }
  else {
    (grDevices::colorRampPalette(rev(colors)))(n2)
  }
  discrete <- if (direction == 1) {
    colors
  }
  else if (direction == -1) {
    rev(colors)
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
