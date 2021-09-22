# Cryptocurrency Return Analysis and Distribution Modeling

Cryptocurrency is a "rising star" in financial industry as a brain-new virtual currency and captures a signicant amount of attention around the world.

The project conducts exploratory data analysis on the first and most popular cryptocurrency, Bitcoin (BTC) along with two other currencies, Ethereum (ETH) and Ripple (XRP) to check if our observations are generalizable.

The cryptocurrency prices in USD are acquired from the R package [“quantmod”](https://cran.r-project.org/web/packages/quantmod/quantmod.pdf) with Tiingo source. Sample time frame is from Jan 1, 2017 to Feb 11, 2021.
The log returns are calculated from the closing prices at the end of each trading date.

Here, the R code accounts for the EDA part:

### Part 1 
Summary Statistics
- All of the average log returns are above 0
- Even with the overall growing pattern, we cannot ignore the high volatility, which may indicate the large amount of loss during the "bad time"

### Part 2
Histogram of Log Returns
- Histogram is one of the most common methods in estimating the density plots
- The plots of log returns across three cryptocurrencies are fairly similar to normal distributions, but with heavy tails

### Part 3
Kernel Density Estimation
- Another way to estimate the sample data density is to use kernel density estimation.
- We use the "Sheather-Jones" method in R function `density()` to automatically select the bandwidth by balancing the bias-variance trade-off. 

### Part 4
Empirical CDF
- Could also estimate the actual cumulative density functions by empirical CDF method
- Empirical CDF will help to better understand the distribution of the sample log returns and might be utilized to find the optimal distribution models
- According to fitted Empirical CDF, Bitcoin log returns might have left skewness; Ethereum log returns might also have left skewness and Ripple log returns might have right skewness (right skewness is rarely to observe)

Conclusion: We found a slightly suprising result: from both EDA and distribution modeling, Bitcoin and Ethereum have semi heavy tails. Ripple have relatively heavier tails, thus a light tailed distribution (Laplace distribution) gives the best fit for the former two and a heavy tailed distribution (t distribution) for the latter. In summary, the tail behaviour of cryptocurrency returns may not follow that of traditional financial assets.

