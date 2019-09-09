lambda <- 0.2
mean(rexp(4000, lambda))
?rexp

plot(rexp(3333,.2))
hist(runif(1000))




# How does the mean of the distribution means compare to the theoretical max?

mns = NULL
for (i in 1 : 1000) mns = c(mns, mean(rexp(40, lambda)))
hist(mns)


sim <- mean(mns)
theor <- 1/lambda
pct_err <- (sim-theor)/theor *100

# Variance
var(mns)
lambda ^(-2)

vr = NULL
for (i in 1 : 1000) vr = c(vr, var(rexp(40, lambda)))
hist(vr)
mean(vr)


# Normality test
shapiro.test(mns)
hist(mns)
densityplot(mns)

mean(mns > sim) # distribution is roughly symmetrical


'
Sample Project Report Structure

Of course, there are multiple ways one could structure a report to address the requirements above. However, the more clearly you pose and answer each question, the easier it will be for reviewers to clearly identify and evaluate your work.

A sample set of headings that could be used to guide the creation of your report might be:
        
        Title (give an appropriate title) and Author Name
Overview: In a few (2-3) sentences explain what is going to be reported on.
Simulations: Include English explanations of the simulations you ran, with the accompanying R code. Your explanations should make clear what the R code accomplishes.
Sample Mean versus Theoretical Mean: Include figures with titles. In the figures, highlight the means you are comparing. Include text that explains the figures and what is shown on them, and provides appropriate numbers.
Sample Variance versus Theoretical Variance: Include figures (output from R) with titles. Highlight the variances you are comparing. Include text that explains your understanding of the differences of the variances.
Distribution: Via figures and text, explain how one can tell the distribution is approximately normal.
'

##################


data("ToothGrowth")
df <- ToothGrowth
df$dose <- as.factor(df$dose)

# Summary of the data
summary(df)
str(df)
ggplot(df, aes(x = dose, y=len, fill=supp)) + geom_violin()

'
The response is the length of odontoblasts (cells responsible for tooth growth) in 60 guinea pigs. Each animal received one of three dose levels of vitamin C (0.5, 1, and 2 mg/day) by one of two delivery methods, orange juice or ascorbic acid (a form of vitamin C and coded as VC).
'

# My hypothesis is that for a dose of 1 mg, orange juice causes more growth than vitamin C alone
oj <- df$len[df$dose==1 & df$supp=='OJ']
vc <- df$len[df$dose==1][df$supp=='VC']
t.test(x = oj, y = vc, conf.level = .95)

# The t sample statistic is within the 95% confidence interval. Thus, we fail to reject the null hypothesis that the treatments outcomes pertain to the same distribution.

# Conclusions - state conclusions and assumptions







