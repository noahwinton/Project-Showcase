
myCAPM <- function(a= NULL,b=NULL ,c=NULL ,d=NULL ,market ='SPY' ,rf= rf,period= 90){
  library(tidyquant)
  library(dplyr)
  library(magrittr)
  install.packages("scales")                                   # Install and load scales
  library("scales")
  rf <- c(tq_get('DGS10',get='economic.data'))
  rf$price <- rf$price[!is.na(rf$price)]
  rf = mean(rf$price, na.rm = T)
  helper <- function(stock,period){
    
    stock_info <- tq_get(stock,get = 'stock.prices', from = (Sys.Date()-period))
    close_prices <- c(stock_info['close'])
    DailyLog <- c()
    for (i in close_prices){
      DailyLog <- (log(i)-lag(log(i)))
    }
    DailyLog
    DailyLog <- DailyLog[!is.na(DailyLog)]
    
    DailyLog
    
  }
  #Finding Ave_Ret for all four stock prices
  r_a <- helper(a,period)
  ReturnA <- mean(r_a,na.rm = T)
  r_b <- helper(a,period)
  ReturnB <- mean(r_b,na.rm = T)
  r_c <- helper(c,period)
  ReturnC <- mean(r_c,na.rm = T)
  r_d <- helper(d,period)
  ReturnD <- mean(r_d,na.rm = T)
  Ave_Return <- c(ReturnA,ReturnB,ReturnC,ReturnD)
  #Getting Beta Values using lm() for each stock 
  r_a <- helper(a,period)
  b_a <- helper(market,period)
  Beta <- lm(r_a ~ b_a)
  Beta1 <- Beta$coefficients[2]
  r_b <- helper(b,period)
  b_a <- helper(market,period)
  Beta <- lm(r_b ~ b_a)
  Beta2 <- Beta$coefficients[2]
  r_c <- helper(c,period)
  b_a <- helper(market,period)
  Beta <- lm(r_c ~ b_a)
  Beta3 <- Beta$coefficients[2]
  r_d <- helper(d,period)
  b_a <- helper(market,period)
  Beta <- lm(r_d ~ b_a)
  Beta4 <- Beta$coefficients[2]
  Beta <- c(Beta1,Beta2,Beta3,Beta4)
  #average daily return for market benchmark
  bench_return <- helper(market,period)
  bench_return <- mean(bench_return)
  bench_return
  #average daily return for each stock
  Ave_Return2 <- helper(a,period)
  Ave_Return2 <- mean(Ave_Return2,na.rm = T)
  Ave_Return2
  #average fed rate
  fed_rates <- tq_get('FEDFUNDS',get = 'economic.data',from = (Sys.Date()-period))
  fed_rates
  ave_rate<-data.frame(fed_rates[,3])
  fed_rates <- as.numeric(unlist(ave_rate))
  ave_fed_rate <- mean(fed_rates)
  Alpha1 <- (Ave_Return2 - ave_fed_rate - Beta1*(bench_return - ave_fed_rate))#average daily return for market benchmark
  bench_return <- helper(market,period)
  bench_return <- mean(bench_return)
  bench_return
  Ave_Return2 <- helper(b,period)
  Ave_Return2 <- mean(Ave_Return2,na.rm = T)
  Ave_Return2
  #average fed rate
  fed_rates <- tq_get('FEDFUNDS',get = 'economic.data',from = (Sys.Date()-period))
  fed_rates
  ave_rate<-data.frame(fed_rates[,3])
  fed_rates <- as.numeric(unlist(ave_rate))
  ave_fed_rate <- mean(fed_rates)
  Alpha2 <- (Ave_Return2 - ave_fed_rate - Beta2*(bench_return - ave_fed_rate))#average daily return for market benchmark
  bench_return <- helper(market,period)
  bench_return <- mean(bench_return)
  bench_return
  Ave_Return2 <- helper(c,period)
  Ave_Return2 <- mean(Ave_Return2,na.rm = T)
  Ave_Return2
  #average fed rate
  fed_rates <- tq_get('FEDFUNDS',get = 'economic.data',from = (Sys.Date()-period))
  fed_rates
  ave_rate<-data.frame(fed_rates[,3])
  fed_rates <- as.numeric(unlist(ave_rate))
  ave_fed_rate <- mean(fed_rates)
  Alpha3 <- (Ave_Return2 - ave_fed_rate - Beta3*(bench_return - ave_fed_rate))
  #average daily return for market benchmark
  bench_return <- helper(market,period)
  bench_return <- mean(bench_return)
  bench_return
  Ave_Return2 <- helper(d,period)
  Ave_Return2 <- mean(Ave_Return2,na.rm = T)
  Ave_Return2
  #average fed rate
  fed_rates <- tq_get('FEDFUNDS',get = 'economic.data',from = (Sys.Date()-period))
  fed_rates
  ave_rate<-data.frame(fed_rates[,3])
  fed_rates <- as.numeric(unlist(ave_rate))
  ave_fed_rate <- mean(fed_rates)
  Alpha4 <- (Ave_Return2 - ave_fed_rate - Beta4*(bench_return - ave_fed_rate))
  Alpha <- c(Alpha1,Alpha2,Alpha3,Alpha4)
  #over_under function
  over1 <- ifelse(Alpha1 > 0,'Over','Under')
  over2 <- ifelse(Alpha2 > 0,'Over','Under')
  over3 <- ifelse(Alpha3 > 0,'Over','Under')
  over4 <- ifelse(Alpha4 > 0,'Over','Under')
  Over_Under<- c(over1,over2,over3,over4)
  Stocks <- c(a,b,c,d)
  output <- data.frame(matrix(ncol = 4,nrow = 4))
  output <- data.frame(scales::percent(Ave_Return),round(Beta,3),round(Alpha,4),Over_Under)
  x <- c('Average Return','Beta','Alpha','Over/Under')
  colnames(output) <- x
  row.names(output) <- Stocks
  output
}


myCAPM('PFE','AAPL','FB','GOOGL')


