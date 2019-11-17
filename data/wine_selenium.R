library("RSelenium")
library("rvest")
library("magrittr")

# docker run -d -p 4445:4444 selenium/standalone-chrome

remDr <- RSelenium::remoteDriver(remoteServerAddr = "localhost",
                                 port = 4445L,
                                 browserName = "chrome")

remDr$open()


# Problem 1: prices

remDr$navigate("https://www.vivino.com/search/wines?q=Chasselas")

remDr$screenshot(display = TRUE)

read_html(remDr$getPageSource()[[1]]) %>%
    html_nodes(".wine-price-value") %>%
    html_text()

# Problem 2: all wines

remDr$navigate(
    paste0(
        "https://www.vivino.com/explore?e=eJwdy70OQDAYBdC3uaP4iZjuxgtITCLyqW",
        "qaKFJN8fbEdKbjPIukhLMbKzi5WaRQD-sGik3X4mAGszCKtzrICqeIfaKXYDdzjhK1F6",
        "Oxc9anwhX64Qs_-Qs1lh4c"
    )
)

remDr$screenshot(display = TRUE)

read_html(remDr$getPageSource()[[1]]) %>%
    html_nodes(".vintageTitle__wine--U7t9G") %>%
    html_text()

# scrolling down
webElem <- remDr$findElement("css", "body")
webElem$sendKeysToElement(list(key = "end"))
remDr$screenshot(display = TRUE)

# scrolling just a little bit 
webElem$sendKeysToElement(list(key = "down_arrow"))
remDr$screenshot(display = TRUE)

# scrolling to the top
webElem$sendKeysToElement(list(key = "home"))
remDr$screenshot(display = TRUE)

# selecting only red wines (i.e., clicking White wine to disselect)
webElem <- remDr$findElement(
    using = 'css selector', ".filterByWineType__pill--DDMJ3:nth-child(2) .pill__inner--2uty5"
)
webElem$clickElement()
remDr$screenshot(display = TRUE)

remDr$quit()
