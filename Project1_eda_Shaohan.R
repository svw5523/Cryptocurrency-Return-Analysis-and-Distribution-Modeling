# clean up workspace environment
rm(list = ls())
# load library 
library(DataComputing)
library(ggplot2)
library(quantmod)
library(moments)

### Data Preparation
sDate <- as.Date("2016-12-31")
eDate <- as.Date("2021-2-11")

# extract the data from `quantmod` package
getSymbols("btcusd", src = "tiingo", api.key = "26c671a9103140ad167775e70d8976e362c150c4", from = sDate, to = eDate) # extract BTC price in USD
getSymbols("ethusd", src = "tiingo", api.key = "26c671a9103140ad167775e70d8976e362c150c4", from = sDate, to = eDate) # extract ETH price in USD
getSymbols("xrpusd", src = "tiingo", api.key = "26c671a9103140ad167775e70d8976e362c150c4", from = sDate, to = eDate) # extract XRP price in USD

### Exploratory Data Analysis (EDA)
# find daily log returns from the closing prices
# BTC
Closing_btc <- Cl(btcusd) # Bitcoin closing price
logreturns_btc <- diff(log(Closing_btc))[-1] # Bitcoin log returns

# ETH
Closing_eth <- Cl(ethusd) # Ethereum closing price
logreturns_eth <- diff(log(Closing_eth))[-1] # Ethereum log returns

# XRP
Closing_xrp <- Cl(xrpusd) # Ripple closing price
logreturns_xrp <- diff(log(Closing_xrp))[-1] # Ripple log returns

#### Summary Statistics
summary(as.vector(logreturns_btc))
skewness(as.vector(logreturns_btc)) # skewness for Bitcoin log returns
kurtosis(as.vector(logreturns_btc)) # kurtosis for Bitcoin log returns
summary(as.vector(logreturns_eth))
skewness(as.vector(logreturns_eth)) # skewness for Ethereum log returns
kurtosis(as.vector(logreturns_eth)) # kurtosis for Ethereum log returns
summary(as.vector(logreturns_xrp))
skewness(as.vector(logreturns_xrp)) # skewness for Ripple log returns
kurtosis(as.vector(logreturns_xrp)) # kurtosis for Ripple log returns

#### Histograms
#png(filename="Bitcoin_hist.png", width=960, height=960, res=120)
logreturns_btc %>%
  ggplot(aes(x = logreturns_btc)) +
  geom_histogram(col = "black", fill = "grey80", bins = 80) +
  geom_rug(sides = "b") +
  xlab('Bitcoin daily log returns') +
  ggtitle("Histogram of Bitcoin daily log returns") +
  theme(plot.title = element_text(hjust = 0.5))
#graphics.off()

#png(filename="Ethereum_hist.png", width=960, height=960, res=120)
logreturns_eth %>%
  ggplot(aes(x = logreturns_eth)) +
  geom_histogram(col = "black", fill = "grey80", bins = 80) +
  geom_rug(sides = "b") +
  xlab('Ethereum daily log returns') +
  ggtitle("Histogram of Ethereum daily log returns") +
  theme(plot.title = element_text(hjust = 0.5))
#graphics.off()

#png(filename="Ripple_hist.png", width=960, height=960, res=120)
logreturns_xrp %>%
  ggplot(aes(x = logreturns_xrp)) +
  geom_histogram(col = "black", fill = "grey80", bins = 80) +
  geom_rug(sides = "b") +
  xlab('Ripple daily log returns') +
  ggtitle("Histogram of Ripple daily log returns") +
  theme(plot.title = element_text(hjust = 0.5))
#graphics.off()

#### Trend of the Closing prices and Log Returns
#png(filename="Bitcoin_price.png", width=960, height=960, res=120)
Closing_btc %>%
  ggplot(aes(x =index(Closing_btc), y = Closing_btc)) +
  geom_line(col = "deepskyblue4") +
  geom_rug(sides = "l") +
  xlab("Date") +
  ylab("Bitcoin prices") +
  ggtitle("Bitcoin prices") +
  theme(plot.title = element_text(hjust = 0.5))
#graphics.off()

#png(filename="Bitcoin_logreturn.png", width=960, height=960, res=120)
logreturns_btc %>%
  ggplot(aes(x =index(logreturns_btc), y = logreturns_btc)) +
  geom_line(col = "deepskyblue4") +
  geom_rug(sides = "l") +
  xlab("Date") +
  ylab("Bitcoin Log returns") +
  ggtitle("Bitcoin daily log return") +
  theme(plot.title = element_text(hjust = 0.5))
#graphics.off()

#png(filename="Ethereum_price.png", width=960, height=960, res=120)
Closing_eth %>%
  ggplot(aes(x =index(Closing_eth), y = Closing_eth)) +
  geom_line(col = "deepskyblue4") +
  geom_rug(sides = "l") +
  xlab("Date") +
  ylab("Ethereum prices") +
  ggtitle("Ethereum prices") +
  theme(plot.title = element_text(hjust = 0.5))
#graphics.off()

#png(filename="Ethereum_logreturn.png", width=960, height=960, res=120)
logreturns_eth %>%
  ggplot(aes(x =index(logreturns_eth), y = logreturns_eth)) +
  geom_line(col = "deepskyblue4") +
  geom_rug(sides = "l") +
  xlab("Date") +
  ylab("Ethereum Log returns") +
  ggtitle("Ethereum daily log return") +
  theme(plot.title = element_text(hjust = 0.5))
#graphics.off()

#png(filename="Ripple_price.png", width=960, height=960, res=120)
Closing_xrp %>%
  ggplot(aes(x =index(Closing_xrp), y = Closing_xrp)) +
  geom_line(col = "deepskyblue4") +
  geom_rug(sides = "l") +
  xlab("Date") +
  ylab("Ripple prices") +
  ggtitle("Ripple prices") +
  theme(plot.title = element_text(hjust = 0.5))
#graphics.off()

#png(filename="Ripple_logreturn.png", width=960, height=960, res=120)
logreturns_xrp %>%
  ggplot(aes(x =index(logreturns_xrp), y = logreturns_xrp)) +
  geom_line(col = "deepskyblue4") +
  geom_rug(sides = "l") +
  xlab("Date") +
  ylab("Ripple Log returns") +
  ggtitle("Ripple daily log return") +
  theme(plot.title = element_text(hjust = 0.5))
#graphics.off()

#### Kernel Density Estimation
# Bitcoin log returns
#png(filename="Bitcoin_KDE.png", width=960, height=960, res=120)
par(mfrow = c(2,3))
for (i in 1:6){
  densityBit = density(logreturns_btc, bw = "SJ-dpi", adj = i) # choose automatic bandwidth selector "Sheather-Jones"
  plot(densityBit, main = paste("Bitcoin KDE for adj =", i))
}
#graphics.off()

# Ethereum log returns
#png(filename="Ethereum_KDE.png", width=960, height=960, res=120)
par(mfrow = c(2,3))
for (i in 1:6){
  densityEth = density(logreturns_eth, bw = "SJ-dpi", adj = i)
  plot(densityEth, main = paste("Ethereum KDE for adj =", i))
}
#graphics.off()

# Ripple log returns
#png(filename="Ripple_KDE.png", width=960, height=960, res=120)
par(mfrow = c(2,3))
for (i in 1:6){
  densityXrp = density(logreturns_xrp, bw = "SJ-dpi", adj = i)
  plot(densityXrp, main = paste("Ripple KDE for adj =", i))
}
#graphics.off()

#### Empirical CDF
# Bitcoin log returns empirical CDF
#png(filename="Bitcoin_ECDF.png", width=960, height=960, res=120)
par(mfrow = c(1,1))
logreturns_btc2 <- as.vector(logreturns_btc)
plot(ecdf(logreturns_btc2), xlab = "Bitcoin daily log returns", main = "Empirical CDF of Bitcoin log returns")
#graphics.off()

# Ethereum log returns empirical CDF
#png(filename="Ethereum_ECDF.png", width=960, height=960, res=120)
logreturns_eth2 <- as.vector(logreturns_eth)
plot(ecdf(logreturns_eth2), xlab = "Ethereum daily log returns", main = "Empirical CDF of Ethereum log returns")
#graphics.off()

# Ripple log returns empirical CDF
#pdf(filename="Ripple_ECDF.pdf", width=6, height=5)
logreturns_xrp2 <- as.vector(logreturns_xrp)
plot(ecdf(logreturns_xrp2), xlab = "Ripple daily log returns", main = "Empirical CDF of Ripple log returns")
#graphics.off()

