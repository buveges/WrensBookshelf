#' View all of Wren's Books
#'
#' Generates a graphic object with desired subset of palettes from WrensBookshelf.
#'
#' @param CVDsafe Argument used to restrict displayed palettes to those that are color vision deficiency (CVD) safe. Default is FALSE, set to TRUE to enact filter.
#' @param BestFor Argument used to restrict displayed palettes to those that are best for either continuous or discrete data types. Arguments are "discrete" or "continuous"
#'
#' @return Graphic object.
#' @export
#'
#' @examples
#' ShowBookshelf()
#' ShowBookshelf(CVDsafe = TRUE, BestFor = "continuous")
ShowBookshelf <- function(CVDsafe = FALSE, BestFor = NA) {
  oldpar <- par(no.readonly = TRUE)
  on.exit(par(oldpar))
  WrensBookshelfTemp <-  WrensBookshelf
  if (CVDsafe == TRUE) {
    for (i in names(WrensBookshelfTemp )){
      if(isFALSE(WrensBookshelfTemp [[i]][[3]])){
        WrensBookshelfTemp [[i]] <- NULL
      }
    }
  }
  `%ni%` <- Negate(`%in%`)
  if (!is.na(BestFor) & BestFor %ni% c("discrete","continuous")) {
    stop("Entry for BestFor not valid. Options are 'discrete' and 'continuous'.")
  }
  if (BestFor %in% c("discrete","continuous")) {
    for (i in names(WrensBookshelfTemp)){
      if(WrensBookshelfTemp [[i]][[4]]!=BestFor){
        WrensBookshelfTemp [[i]] <- NULL
      }
    }
  }
  WB.bar <- function(name) {
    pal <- WrensBookshelfTemp[[name]]
    bardat <- data.frame(x = factor(seq(1:length(pal[[1]]))),
                         y = rep(1,length(pal[[1]])))
    barplot(bardat$y,
            col = pal[[1]],
            space = c(0),
            border = NA,
            yaxt="n",
            xaxt="n",
            bty= "n"
    )
    title(main =  paste(name),adj=0, cex.main = 0.75)
    title(sub = paste(pal[["Author"]]), adj=1, line = 0, cex.sub = 0.5)
  }
  par(mfrow = c(ceiling(length(WrensBookshelfTemp)/4),4),
      mai = c(0.2,0.2,0.2,0.2))
  invisible(mapply(FUN = WB.bar, names(WrensBookshelfTemp)))
}
