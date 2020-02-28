
# Visualization of Stock Datas (the largest tech-companies) 
# We install quantmod package to scrape data from yahoo.finance

# Clear the console
cat("\f")

# Get Packages
install.packages("quantmod")
install.packages("magrittr")
install.packages("ggplot2")
install.packages("ggcorrplot")

# Import the library
library(quantmod)


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

library(magrittr) # for the log change 

#  The log differences 
stock_change = stocks %>% log %>% diff
head(stock_change)

# Create a plot showing all series,  using as.zoo is a
# method which allows multiple series to be plotted on same plot

plot(as.zoo(stocks), screens = 1, lty = 1:4, xlab = "Date", ylab = "Price")
legend("right", c("AAPL", "MSFT", "AMZN", "FB"), lty = 1:4, cex = 0.5)

plot(as.zoo(stock_change),screens = 1,  lty = 1:3, xlab = "Date", ylab = "Log Difference")
legend("topleft", c("AAPL", "MSFT", "AMZN", "FB"), lty = 1:3, cex = 0.5)


library(ggcorrplot) # to visualize correlation matrix


# create a dataframe, corr, to hold the correlation matrix, rounded to two digits
correlations_matrix = round(cor(stock_return),2)

# Plot the correlation matrix 
ggcorrplot(correlations_matrix, hc.order = TRUE, type ="lower", 
           outline.color = "white")
# Add the lab=TRUE parameter to show the correlation values
ggcorrplot(correlations_matrix, hc.order = TRUE, type = "lower",
           outline.col = "white", lab=TRUE)

# create a dataframe, p.mat to contain the p values of the correlations
p.mat <- cor_pmat(stock_return)

# The color of the data values is also updated to white to mask out zero values
ggcorrplot(correlations_matrix, p.mat = p.mat, hc.order = TRUE,
           type = "lower", insig = "blank", lab=TRUE, lab_col="white")

       