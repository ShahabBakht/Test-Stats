rm(list = ls())

library(lme4)  # load library
library(arm)  # convenience functions for regression in R
library(R.matlab)

# 
intercept.sbjt1.cond1 <- 1
intercept.sbjt1.cond2 <- .5
intercept.sbjt2.cond1 <- 1
intercept.sbjt2.cond2 <- .5

coeff.sbjt1.cond1 <- 1
coeff.sbjt1.cond2 <- .7
coeff.sbjt2.cond1 <- 1
coeff.sbjt2.cond2 <- .7

X.sbjt1.cond1 <- runif(10, min=-1, max=1)
X.sbjt1.cond2 <- runif(10, min=-1, max=1)
X.sbjt2.cond1 <- runif(10, min=-1, max=1)
X.sbjt2.cond2 <- runif(10, min=-1, max=1)

y.sbjt1.cond1 <- coeff.sbjt1.cond1 *  X.sbjt1.cond1 + intercept.sbjt1.cond1
y.sbjt1.cond2 <- coeff.sbjt1.cond2 *  X.sbjt1.cond2 + intercept.sbjt1.cond2
y.sbjt2.cond1 <- coeff.sbjt2.cond1 *  X.sbjt2.cond1 + intercept.sbjt2.cond1
y.sbjt2.cond2 <- coeff.sbjt2.cond2 *  X.sbjt2.cond2 + intercept.sbjt2.cond2

X.cond1 <- c(X.sbjt1.cond1,X.sbjt2.cond1)
X.cond2 <- c(X.sbjt1.cond2,X.sbjt2.cond2)
y.cond1 <- c(y.sbjt1.cond1,y.sbjt2.cond1)
y.cond2 <- c(y.sbjt1.cond2,y.sbjt2.cond2)
s.cond1 <- c(matrix(0,1,10),matrix(1,1,10))
s.cond2 <- c(matrix(0,1,10),matrix(1,1,10))

# to use the matlab files for the simulations, uncomment the lines below:
tble <- readMat("D:\\Project Codes\\Test-Stats\\matlab.mat")
X1 <- aperm(tble$X1)
Y1 <- aperm(tble$Y1)
C1 <- aperm(tble$C1)
X2 <- aperm(tble$X2)
Y2 <- aperm(tble$Y2)
C2 <- aperm(tble$C2)

X1 <- array(X.cond1, dim=c(20,1))
Y1 <- array(y.cond1, dim=c(20,1))
C1 <- array(s.cond1, dim=c(20,1))
X2 <- array(X.cond2, dim=c(20,1))
Y2 <- array(y.cond2, dim=c(20,1))
C2 <- array(s.cond2, dim=c(20,1))

df1 <- data.frame(X1,C1,Y1)
df2 <- data.frame(X2,C2,Y2)


# ordinary linear regression with glm library
MLexamp1.1 <- glm(Y1 ~ X1, data = df1)
MLexamp2.1 <- glm(Y2 ~ X2, data = df2)

cat("cond_1 Fixed-effect AIC = ", AIC(MLexamp1.1),"\n")
cat("cond_2 Fixed-effect AIC = ",AIC(MLexamp2.1),"\n")

# varying slope and intercept linear regression with lmer library
REexamp1.1 <- lmer(Y1 ~ X1 + (1+X1|C1), data = df1)
REexamp2.1 <- lmer(Y2 ~ X2 + (1+X2|C2), data = df2)

cat("cond_1 s&i Mixed-effect AIC = ", AIC(REexamp1.1),"\n")
cat("cond_2 s&i Mixed-effect AIC = ",AIC(REexamp2.1),"\n")

# varying intercept linear regression with lmer library
REexamp1.2 <- lmer(Y1 ~ X1 + (1|C1), data = df1)
REexamp2.2 <- lmer(Y2 ~ X2 + (1|C2), data = df2)

cat("cond_1 Mixed-effect AIC = ", AIC(REexamp1.2),"\n")
cat("cond_2 Mixed-effect AIC = ",AIC(REexamp2.2),"\n")
