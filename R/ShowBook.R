#' View a book palette
#'
#' Generates a graphic object using a specified palette from WrensBookshelf.
#'
#' @param name Name of desired palette.
#'
#' @return Graphic object.
#' @export
#'
#' @examples
#' ShowBook(name ="BabyWrenAndTheGreatGift")
ShowBook <- function(name) {
  WrensBookshelfTemp <-  WrensBookshelf
  pal <- WrensBookshelfTemp[[name]]
  bardat <- data.frame(x = factor(seq(1:length(pal[[1]]))),
                       y = rep(1,length(pal[[1]])))
  barplot(bardat$y,
          col = pal[[1]],
          space = c(0),
          border = NA,
          yaxt="n",
          xaxt="n")
  title(main =  paste(name),adj=0)
  title(sub = paste(pal[["Author"]]), adj=1, line = 0)
}
