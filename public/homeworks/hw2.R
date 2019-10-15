library(quantmod)
library(rvest)
sp500 <- read_html("https://en.wikipedia.org/wiki/List_of_S%26P_500_companies")

sp500 %>% 
  html_nodes(".text") %>% 
  html_text() -> ticker_sp500

SP500_symbol <- ticker_sp500[(1:499)*2+1]

# Replace "." by "-"
SP500_symbol <- gsub(".","-",SP500_symbol,fixed=T)

# Specify timing
tot_length <- 3 * 365
today <- Sys.Date()
seq_three_years <- seq(today,by=-1,length.out=tot_length)
three_year_ago <- seq_three_years[tot_length]

# Retrieve data for a stock
i <- 1
getSymbols(SP500_symbol[i],from=three_year_ago,to=today)
stock_price <- ClCl(get(SP500_symbol[i]))

stocks <- matrix(nrow=tot_length,ncol=length(SP500_symbol))
for(i in seq_len(tot_length)){
  getSymbols(SP500_symbol[i],from=three_year_ago,to=today)
  stocks[,i] <- ClCl(get(SP500_symbol[i]))
}


three_year_ago <- seq(today, length = 2, by = "-3 year")[2]
stocks_tickers <- c("AAPL", "MSFT")
getSymbols(stocks_tickers, from = three_year_ago, to = today)
nb_ticker <- length(stocks_tickers)
var_stocks <- rep(NA, nb_ticker)
names(var_stocks) <- stocks_tickers

for (i in 1:nb_ticker){
  Xt = na.omit(ClCl(get(stocks_tickers[i])))
  stocks_tickers[i] = var(Xt)
}
stocks_tickers
Xt = na.omit(ClCl(get(SP500_symbol[1])))
getSymbols("ABT")
