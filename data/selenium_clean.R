library("RSelenium")
library("rvest")
library("magrittr")

# docker run -d -p 4445:4444 selenium/standalone-chrome

remDr <- RSelenium::remoteDriver(remoteServerAddr = "localhost",
                                 port = 4445L,
                                 browserName = "chrome")

remDr$open()

remDr$navigate("https://www.vivino.com/explore?e=eJwrL4mOtTVUKwdRRgAgBwRK")

remDr$screenshot(display = TRUE)

read_html(remDr$getPageSource()[[1]]) %>%
    html_nodes(".vintageTitle__wine--U7t9G") %>%
    html_text()

webElem <- remDr$findElement("css", "body")
webElem$sendKeysToElement(list(key = "end"))
