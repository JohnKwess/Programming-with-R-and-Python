
# Visualization of Stock Datas (the largest tech-companies) 
# We install quantmod package to scrape data from yahoo.finance

# Clear the console
cat("\f")

# Get quantmod and magrittr 
install.packages("quantmod")
install.packages("magrittr")
# Import the library
library(quantmod)
library(magrittr) # for the log change 

# Stocks Datas over 1 year period
start_date <- as.Date("2019-01-30")
end_date <- as.Date("2020-01-31")
getSymbols("AAPL", src="yahoo", from=start_date, to=end_date)
# Read the first 10 rows (e.g APPLE)
head(AAPL, n=10L, header=TRUE)

getSymbols("AMZN", src ="yahoo", from=start_date, to=end_date)
getSymbols("MSFT", src = "yahoo", from = start_date, to = end_date)
getSymbols("FB", src ="yahoo", from=start_date, to=end_date)

# Create an xts object that contains the closing price
stocks<- as.xts(data.frame(AAPL = AAPL[, "AAPL.Close"], MSFT = MSFT[, "MSFT.Close"], 
                           AMZN = AMZN[, "AMZN.Close"], FB=FB[, "FB.Close"]))
head(stocks, n=10L)

#  The log differences 
stock_change = stocks %>% log %>% diff
head(stock_change)

# Create a plot showing all series,  using as.zoo is a
# method which allows multiple series to be plotted on same plot

plot(as.zoo(stocks), screens = 1, lty = 1:4, xlab = "Date", ylab = "Price")
legend("right", c("AAPL", "MSFT", "AMZN", "FB"), lty = 1:4, cex = 0.5)

plot(as.zoo(stock_change),screens = 1,  lty = 1:3, xlab = "Date", ylab = "Log Difference")
legend("topleft", c("AAPL", "MSFT", "AMZN", "FB"), lty = 1:3, cex = 0.5)


# Correlation matrix
correlations <- cor(as.matrix(stock_return ), method="spearman")
correlations 
