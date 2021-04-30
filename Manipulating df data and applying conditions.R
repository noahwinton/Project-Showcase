install.packages('randomNames') # a library that samples from a dataset of real names
library(randomNames) # attach the package to session
Names <- randomNames(100) # create a vector of random names
Credit <- sample(300:850,100,replace=T) # create a vector of random credit scores
data <- data.frame(Names,Credit) # store Names and Credit in a data frame
head(data) # to check out the first few rows
n <- 1:100
#splitting first and last names
for (i in n){
  name_list <- unlist(strsplit(data[n,1],', '))
}
# attach the even posiiton names to first_name
first_name <- c()
first_name <- name_list[c(FALSE,TRUE)]
#attach the odd position names to last_name
last_name <- c()
last_name <- name_list[c(TRUE,FALSE)]
#create a new data frame with all three catagories
addresses <- c()
for (i in n){
  addresses <- paste(first_name[n],'.',last_name[n],'@bank.com',sep='')
}
x <- paste('Congrats ',addresses[n],', you are qualifiedfor a loan based on your credit score of ',Credit[n],'.')
#aggregating data into df and applying conditions for rejection
EmailMessage <- vector(mode = 'list',length = 100)
EmailMessage <- ifelse(Credit < 700,'Rejected', x)
credit_information <- data.frame(first_name,last_name,Credit,EmailMessage)
credit_information
