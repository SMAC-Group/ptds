library("xml2")
library("rvest")

# Problem 1: prices

chasselas <- read_html(
    "https://www.vivino.com/search/wines?q=Chasselas"
)

chasselas %>% 
    html_nodes(".wine-price-value") %>%
    html_text()

# Problem 2: all wines

wine <- read_html(
    paste0(
        "https://www.vivino.com/explore?e=eJwdy70OQDAYBdC3uaP4iZjuxgtITCLyqW",
        "qaKFJN8fbEdKbjPIukhLMbKzi5WaRQD-sGik3X4mAGszCKtzrICqeIfaKXYDdzjhK1F6",
        "Oxc9anwhX64Qs_-Qs1lh4c"
    )
)

wine %>% 
    html_nodes(".vintageTitle__wine--U7t9G") %>%
    html_text()
