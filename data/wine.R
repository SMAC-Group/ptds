library("robotstxt")

paths_allowed(
    path = "/search/wines?q=Chasselas",
    domain = "https://www.vivino.com/"
)

# 1. 
#-------------------------------------------------------------------------------

library("xml2")

wine <- read_html(
    "https://www.vivino.com/search/wines?q=Chasselas"
)

# 2. 
#-------------------------------------------------------------------------------

# selectorgadget

# 3.
#-------------------------------------------------------------------------------

library("rvest")
library("magrittr")

names <- wine %>% 
    html_nodes(".link-color-alt-grey span:nth-child(1)") %>%
    html_text()

ratings <- wine %>% 
    html_nodes(".average__container:nth-child(1) .average__number") %>%
    html_text()

# (4.)
#-------------------------------------------------------------------------------

names <- names %>% gsub(pattern = "\n", replacement = "", fixed = TRUE)
ratings <- ratings %>%
    gsub(pattern = "\n", replacement = "", fixed = TRUE) %>%
    as.numeric()

wine <- data.frame(name = names, rating = ratings)
