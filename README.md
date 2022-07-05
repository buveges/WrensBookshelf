
<!-- README.md is generated from README.Rmd. Please edit that file -->

# WrensBookshelf

<!-- badges: start -->

This package is a collection of color pallettes that were extracted from
various books on my sons(Wren) bookshelf. Also included are a number of
functions and wrappers to utilize them in base R and ggplot2 plotting
functions, as well as to subset the packages to desired number/specific
colors. It was heavily inspired by and modeled after the
[MetBrewer](https://github.com/BlakeRMills/MetBrewer),
[PNWColors](https://github.com/jakelawlor/PNWColors), and
[wesanderson](https://github.com/karthik/wesanderson) packages, and of
course
[RColorBrewer](https://cran.r-project.org/web/packages/RColorBrewer/RColorBrewer.pdf),
so if you are here you should check them out too! Logo designed using
[hexSticker](https://github.com/GuangchuangYu/hexSticker) and
illustrator.

<img src="man/images/WrenHex2.png" width="200" /> <!-- badges: end -->

## Installation

You can install the released version of WrensBookshelf from

``` r
devtools::install_github("buveges/WrensBookshelf")
```

## Palettes

### All palettes

Can view all palettes from Wren’s bookshelf using the `ShowBookshelf()`
function

``` r
library(WrensBookshelf)
ShowBookshelf()
```

![](man/figures/README-AllPalettes-1.png)<!-- -->

``` r
names(WrensBookshelf)
#>  [1] "BabyBeluga"                   "BabyWrenAndTheGreatGift"     
#>  [3] "BatheTheCat"                  "BlueberriesForSal"           
#>  [5] "BoTheBrave"                   "BoTheBraveCVDS"              
#>  [7] "BurtDow"                      "BurtDowCVDS"                 
#>  [9] "CapsForSale"                  "GustavoTheShyGhost1"         
#> [11] "GustavoTheShyGhost2"          "HaroldAndThePurpleCrayon"    
#> [13] "JeffGoesWild"                 "JulienIsAMermaid"            
#> [15] "LastStopOnMarketStreet"       "LittleBlueHouseBesideTheSea1"
#> [17] "LittleBlueHouseBesideTheSea2" "Madelline"                   
#> [19] "MakeWayForDucklings"          "Moongame"                    
#> [21] "MoreThanALittle"              "OhThePlacesYoullGo"          
#> [23] "Opposites"                    "StackTheCats"                
#> [25] "TheDucklingGetsACookie"       "TheHoneybee1"                
#> [27] "TheHoneybee2"                 "ThePoutPoutFish"             
#> [29] "TheRunawayBunny"              "TheSnowyDay"                 
#> [31] "TheStoryOfBabar"              "TheseWordsIShapedForYou"     
#> [33] "ThisMooseBelongsToMe"         "ThreeLittleVikings"          
#> [35] "TigerDays"                    "TinyPerfectThings"           
#> [37] "Vampenguin"                   "WhatWellBuild"               
#> [39] "WhereTheWildThingsAre"        "YouMatter"
```

### Color Vision Deficiency (CVD) safe palettes

Can display only CVD safe palettes using `CVDsafe` option.

``` r
ShowBookshelf(CVDsafe = TRUE)
```

![](man/figures/README-CVDsafe-1.png)<!-- -->

### Palettes for Discrete/Continuous data

All palettes can be used for either discrete or continuous data display,
however some apply themselves to one better than the other. Use the
`BestFor` option to view palettes that, in my own view, work best for
“discrete” or “continuous” variables. This can be combined/stacked with
the `CVDsafe` option as well

``` r
ShowBookshelf(BestFor = "continuous")
```

![](man/figures/README-BestFor-1.png)<!-- -->

## Functions

### ShowBook()

Similar to `ShowBookshelf()` which shows all palettes with given
filters, but `ShowBook()` is used to display a single book as a modified
plot object.

``` r
ShowBook(name ="BabyWrenAndTheGreatGift")
```

![](man/figures/README-ShowBook-1.png)<!-- -->

### WB_brewer()

Select/create palettes from Wren’s bookshelf. For discrete palettes, I
have assigned a specific order that the colors will be selected from a
given palette in order to give the best contrast between discrete
variables. This can be removed using `override.order = TRUE`.

``` r
WB_brewer("BurtDow")
```

![](man/figures/README-WBbrewer-1.png)<!-- -->

``` r
WB_brewer("Opposites", n = 5, direction = 1, override.order = FALSE, type="discrete")
```

![](man/figures/README-WBbrewer-2.png)<!-- -->

``` r
WB_brewer("GustavoTheShyGhost2", n = 20,type="continuous")
```

![](man/figures/README-WBbrewer-3.png)<!-- -->

``` r
WB_brewer("LittleBlueHouseBesideTheSea1",100,type="continuous")
```

![](man/figures/README-WBbrewer-4.png)<!-- -->

### WB_subset_brewer()

This function is just another way of customizing palettes that I tried
building before finding out that `MetBrewer` had already figured things
out better. So, this is a relic that still works, and gives a little
more intuitive(to me at least…) or specific control over the final
product.

``` r
WB_subset_brewer(name = "WhereTheWildThingsAre", type = "discrete", LCR = c(1,4,5,6))
```

![](man/figures/README-WBsubsetbrewer-1.png)<!-- -->

``` r
WB_subset_brewer(name = "JulienIsAMermaid", n = 5, LCR = "left", type = "continuous", n2 = 200)
```

![](man/figures/README-WBsubsetbrewer-2.png)<!-- -->

### ggplot wrapper functions

Some convenience functions to make integration of palettes into ggplot2
easier.

``` r
library(ggplot2)

ggplot(mtcars, aes(x = disp, y = wt, color = factor(cyl)))+
  geom_point(size = 5)+
  scale_color_WB_d(name = "YouMatter")+
  theme_bw()
```

![](man/figures/README-ggplotWrappers-1.png)<!-- -->

``` r
ggplot(mtcars, aes(x = disp,y = wt, fill= mpg))+
     geom_point(size=5, shape = 21)+
     scale_fill_WB_c(name = "BabyBeluga", direction = -1)+
     theme_bw()
```

![](man/figures/README-ggplotWrappers-2.png)<!-- -->

``` r

ggplot(diamonds, aes(x = price, fill = color))+
  geom_density(position="stack", color = "white")+
  scale_fill_WB_d("CapsForSale", override.order = TRUE)+
  theme_classic()
```

![](man/figures/README-ggplotWrappers-3.png)<!-- -->

Can also simply utilize `WB_brewer()` within the normal ggplot2 scale
functions.

``` r
library(usmap)
library(magrittr)
library(dplyr)
statepop2 <- statepop %>% 
  mutate(logPop = log(pop_2015, base = 10))
plot_usmap(data = statepop2, 
           values = "logPop",
           regions = "states", 
           color = "white") + 
  labs(title = "State Populations",
       subtitle = expression('Population by state for the year 2015 on a'~'log'[10]~'scale'),
       fill = expression('log'[10]~'(Population)')) + 
  scale_fill_gradientn(colors = WB_brewer("WhatWellBuild"))+
  theme(panel.background=element_blank(),
        legend.position = c(0.6,0.01),
        legend.direction = "horizontal")
```

![](man/figures/README-ggplot-1.png)<!-- -->

``` r
ggplot(data.frame(x = rnorm(10000), y = rnorm(10000)),aes(x=x,y=y))+
  stat_density_2d(aes(fill = ..level..), geom = "polygon", colour="white")+
  scale_fill_WB_c("TinyPerfectThings",direction = -1)+
  theme_void()
```

![](man/figures/README-ggplot-2.png)<!-- -->

## The Bookshelf

![](man/images/BookShelf.png)

## Contact

Twitter: @benuveges
