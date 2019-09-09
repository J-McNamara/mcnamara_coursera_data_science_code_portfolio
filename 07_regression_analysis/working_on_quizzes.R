### Much of this was copied and pasted from quizzes posted online to test, debug, and compare my answers

###
#Q2
###
mtcars$cyl <- factor(mtcars$cyl)
mtcars$am <- factor(mtcars$am)
levels(mtcars$am) <- c('-auto', '-manual')
lm(mpg ~ cyl + wt, mtcars)

mtcars$cyl <- factor(mtcars$cyl)
mtcars$am <- factor(mtcars$am)
levels(mtcars$am) <- c('-auto', '-manual')
lm(mpg ~ cyl, mtcars)

###
#Q3
###
mtcars$cyl <- factor(mtcars$cyl)
mtcars$am <- factor(mtcars$am)
levels(mtcars$am) <- c('-auto', '-manual')
fit1 <- lm(mpg ~ cyl + wt, mtcars)

mtcars$cyl <- factor(mtcars$cyl)
mtcars$am <- factor(mtcars$am)
levels(mtcars$am) <- c('-auto', '-manual')
fit2 <- lm(mpg ~ cyl + wt + cyl:wt, mtcars)

library(lmtest)

fit1
fit2
lrtest(fit1, fit2)

###
#Q4
###
lm(mpg ~ I(wt * 0.5) + factor(cyl), data = mtcars)

###
#Q5
###
x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)
fit <- lm(y ~ x)
max(hatvalues(fit))

###
#Q6
###
x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)
model <- lm(y~x)
influence.measures(model)

#########
# Quiz 4
#########

###
#Q1
###

library(MASS)
?shuttle
shuttle$use.binary <- as.integer(shuttle$use == "auto")
fit <- glm(use.binary ~ wind + magn -1, data = shuttle, family = binomial)
summary(fit)$coef

###
#Q4
###
model <- glm(count ~ factor(spray)-1, family="poisson",data=InsectSprays)
summary(model)
#######

x <- -5:5
y <- c(5.12, 3.93, 2.67, 1.87, 0.52, 0.08, 0.93, 2.05, 2.54, 3.87, 4.97)
knots<-c(0)
splineTerms<-sapply(knots,function(knot) (x>knot)*(x-knot))
xmat<-cbind(1,x,splineTerms)
fit<-lm(y~xmat-1)
yhat<-predict(fit)
summary(fit)$coef


