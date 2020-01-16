library(PortfolioAnalytics)
library(PerformanceAnalytics)
library(quantmod)
library(zoo)
library(plotly)
library(tidyquant)
library(dplyr)
library(DEoptim)
library(ROI)
require(ROI.plugin.glpk)
require(ROI.plugin.quadprog)
library(xts)

getSymbolData <- function(symbolList, start = "2019-06-01", end = "2019-12-31"){
  getSymbols(
    symbolList, 
    auto.assign = TRUE,
    from = start, 
    to = end,
  )
  # Assign to dataframe
  # Get adjusted prices
  p_data <- xts(
    get(symbolList[1])[, 6]
  )
  for (i in 2:length(symbolList)){
    p_data <- merge.xts(p_data, get(symbolList[i])[, 6])
  }
  colnames(p_data) <- symbolList
  # calculate returns
  r_data <- na.omit(CalculateReturns(p_data))
  colnames(r_data) <- symbolList
  list(returns_data = r_data, price_data = p_data)
}


# Stocks BNS Air Canada, Shopify, goeasy
my_stocks <- getSymbolData(c("BNS.TO", "AC", "SHOP", "GSY"))
# save(x = my_stocks, file = "my_stocks.RDS")
  
return_data <- as.data.frame(my_stocks$returns_data)
names(return_data) <- c("BNS_TO", "AC", "SHOP", "GSY")
#return_data$Date <- index(my_stocks$returns_data)
price_data <- as.data.frame(my_stocks$price_data)
names(price_data) <- c("BNS_TO", "AC", "SHOP", "GSY")

DATE = index(my_stocks$returns_data)
my_stocks$returns_data
# Look at plot
plotly::plot_ly(
  data = price_data,
  y = ~ BNS_TO,
  type = "scatter",
  mode = "lines"
) %>% layout(
  title = title,
  xaxis = list(
    type = "date"
  ),
  yaxis = list(
    title = "Price"
  )
)


returns <- my_stocks$returns_data
price <- my_stocks$price_data


# Mean returns amd covariance matrix
mean_returns <- colMeans(returns)
cov_matrix <- cov(returns)

# Portfolio specification
my_folio <- portfolio.spec(assets = colnames(returns))

# Add constraint 
my_folio <- add.constraint(
  portfolio = my_folio, 
  type = "box", 
  min = 0.05, 
  max = 0.65
)

my_folio <- add.constraint(
  portfolio = my_folio, 
  type = "leverage", # "full_investment"
  min_sum = 0.99,  
  max_sum = 1.01
) 

# Maximize the mean return with ROI
max_return <- add.objective(
  portfolio = my_folio, 
  type = "return", 
  name = "mean"
) 

# Optimization
opt_max_return <- optimize.portfolio(
  R = returns, 
  portfolio = max_return, 
  optimize_method = "ROI",
  trace = TRUE
)

print.default(opt_max_return)
print(opt_max_return)

# Plot optimized maximum mean
plot(
  opt_max_return, 
  risk.col = "StdDev", 
  return.col = "mean",
  main = "Minimum Variance Optimization", 
  chart.assets = TRUE,
  xlim = c(-0.5, 1), 
  ylim = c(-0.002, 0.004)
)


# Minimize variance (risk) with ROI
min_var <- add.objective(
  portfolio = my_folio, 
  type = "risk",
  name = "var"
)

# Optimize. Note that although ’var’ is the risk metric, 
# ’StdDev’ is returned as an objective measure.
opt_min_var <- optimize.portfolio(
  R = returns, 
  portfolio = min_var,
  optimize_method = "ROI",  
  trace = TRUE
)

print.default(opt_min_var)
print(opt_min_var)

# Plot optimized minimum var
plot(
  opt_min_var, 
  risk.col = "StdDev", 
  return.col = "mean",
  main = "Minimum Variance Optimization", 
  chart.assets = TRUE,
  xlim = c(-0.5, 1), 
  ylim = c(-0.002, 0.004)
)

meansd_ef <- create.EfficientFrontier(
  R = returns,
  portfolio = my_folio,
  type = "mean-sd",
  n.portfolios = 10,
)

# Plot efficient frontier
chart.EfficientFrontier(
  meansd_ef,
  match.col = "StdDev", # which column to use for risk
  type = "l", 
  RAR.text = "Sharpe Ratio",
  tangent.line = FALSE,
  chart.assets = TRUE,
  labels.assets = TRUE,
  xlim = c(-0.5, 1), 
  ylim = c(-0.002, 0.004),
  element.color = "blue"
)

