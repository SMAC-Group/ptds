library("robotstxt")

paths_allowed(
    path = "explore?e=eJwdyzkKgDAURdHdvFIcy1cJ4h5E5BtjCJhEYnDYvWJzT3VdZJU1cNazyOHkZp1DPWx7qC8ddhYwK0-JVifZ4BQRZkZJ1ptjklNHMRqBiz4UrjSM3_BTvkCQHi4=",
    domain = "https://www.vivino.com/"
)

# 1. 
#-------------------------------------------------------------------------------

library("xml2")

wine <- read_html(
    "https://www.vivino.com/explore?e=eJwdyzkKgDAURdHdvFIcy1cJ4h5E5BtjCJhEYnDYvWJzT3VdZJU1cNazyOHkZp1DPWx7qC8ddhYwK0-JVifZ4BQRZkZJ1ptjklNHMRqBiz4UrjSM3_BTvkCQHi4="
)

# 2. 
#-------------------------------------------------------------------------------

# selectorgadget

# 3.
#-------------------------------------------------------------------------------

library("rvest")
library("magrittr")

wine %>% 
    html_nodes(".vintageTitle__wine--U7t9G") %>%
    html_text()