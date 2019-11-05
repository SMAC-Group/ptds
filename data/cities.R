# 0.
#-------------------------------------------------------------------------------

library("robotstxt")

paths_allowed(
    path = "wiki/List_of_cities_in_Switzerland",
    domain = "https://en.wikipedia.org/"
)


get_robotstxt(domain = "https://en.wikipedia.org/")

# https://www.comparis.ch/robots.txt

# 1. 
#-------------------------------------------------------------------------------

library("xml2")

wiki <- read_html(
    "https://en.wikipedia.org/wiki/List_of_cities_in_Switzerland"
)

# 2. 
#-------------------------------------------------------------------------------

# selectorgadget
# Town, Canton, Town proper

# 3.
#-------------------------------------------------------------------------------

library("rvest")
library("magrittr")

names <- wiki %>% 
    html_nodes("td:nth-child(1)") %>%
    html_text()

names <- names[1:258]

cantons <- wiki %>% 
    html_nodes("td:nth-child(4)") %>%
    html_text()

popultations <- wiki %>% 
    html_nodes("td:nth-child(5)") %>%
    html_text()

popultations <- popultations %>% 
    gsub(pattern = ",", replacement = "", fixed = TRUE) %>%
    gsub(pattern = "?", replacement = "", fixed = TRUE) %>%
    as.numeric()

ssiws_cities <- tibble::tibble(
    name = names,
    canton = cantons,
    popultation = popultations
)
