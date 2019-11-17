# 1. Start Docker 

# 2. Run Docker container of the selenium chrome browser
# (i.e., execute the command below in the terminal)
# docker run -d -p 4445:4444 selenium/standalone-chrome

# 3. Load required packages
library("RSelenium")
library("rvest")
library("magrittr")

# 4. Connect to a running server
# Note for Windows: If you are using Docker toolbox, your remote server address
# will not be localhost. You need to use the ip address of the VM that is
# running docker. Run the command below in the terminal and replace the
# "localhost" by the appeared address.
# docker-machine ip

remDr <- RSelenium::remoteDriver(remoteServerAddr = "localhost",
                                 port = 4445L,
                                 browserName = "chrome")

# 5. Open the headless browser
remDr$open()

# 6. In your favorite broser open the Pathe cinema main page and navigate to 
# "Upcoming". Copy the link into the following command to navigate your headless 
# browser to that page.
remDr$navigate("paste_link_here")

# 6.1. Verify that the headless browser has opened what was desired.
remDr$screenshot(display = TRUE)

# 7. Back to your browser. Using SelectorGadget define css elements of names and
# release dates.


names <- read_html(remDr$getPageSource()[[1]]) %>%
    html_nodes("paste_css_of_nodes") %>%
    html_text()

dates <- read_html(remDr$getPageSource()[[1]]) %>%
    html_nodes("paste_css_of_nodes") %>%
    html_text()

# 8. We also need to scrape links: for this we need to get not the text of
# buttons "Details" but their attributes, particularely, "href" elements.

links <- read_html(remDr$getPageSource()[[1]]) %>%
    html_nodes("paste_css_of_buttons") %>%
    html_attrs() %>% 
    sapply(function(element) element["href"]) 

# 9. Create the tibble.

movies <- tibble::tibble(
    name = names, 
    date = dates,
    link = links
)

# 10. Close the connection.

remDr$quit()
