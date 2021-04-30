library(wooldridge)
data(wage1)
str(wage1)
#doing reg analysis and identifying coefficients and educ 
reg_model <- lm(formula=wage ~ educ, data = wage1)
reg_summary <- summary(reg_model)
upper_bound_coef <- reg_summary$coefficients[1,1]+1.96*((reg_summary$coefficients[1,2])/sqrt(526))
lower_bound_coef <- reg_summary$coefficients[1,1]-1.96*((reg_summary$coefficients[1,2])/sqrt(526))
upper_bound_educ <- reg_summary$coefficients[2,1]+1.96*((reg_summary$coefficients[2,2])/sqrt(526))
lower_bound_educ <- reg_summary$coefficients[2,1]-1.96*((reg_summary$coefficients[2,2])/sqrt(526))
#creating df and aggregating data
df <- data.frame(matrix(ncol = 2, nrow = 2))
df <- data.frame(c(upper_bound_coef,upper_bound_educ),c(lower_bound_coef,lower_bound_educ))
x <- c('Upper','Lower')
colnames(df) <- x
y <- c('(Intercept)','educ')
row.names(df) <- y
reg_summary <- matrix(unlist(reg_summary$coefficients),ncol = 4)
row.names(reg_summary) <- c('(Intercept)','educ')
colnames(reg_summary) <- c('Estimate','Std.Error','t value','Pr(>|t|)')
df <- data.matrix(df,rownames.force = NA)
reg_summary <- cbind(reg_summary,df)
reg_summary
