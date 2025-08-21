###
# zad1

sim.5balls <- function() {
  x <- sample( c(1:5), 2, replace=T )
  x[1]==x[2]
}

res <- replicate( 100000, sim.5balls() )
sum(res)/length(res)


###
# zad2

sim.socks <- function() {
  socks <- c(1,1,2,2,3,3)
  x <- sample( socks, 2, replace=F )
  x[1]==x[2]
}

prob.socks <- function(Nrep) {
  res <- replicate( Nrep, sim.socks() )
  sum(res)/length(res) 
}

prob.socks(100000)


###
# zad3

sim.keys <- function() {
  x <- sample( c(1:5), 5, replace=F )
  x[5]==1  ## означаваме верният ключ с номер 1
}

prob.keys <- function(Nrep) {
  res <- replicate( Nrep, sim.keys() )
  sum(res)/length(res) 
}

prob.keys(100000)


###
# zad4

sim.exam <- function() {
  questions <- c( rep(0,3), rep(1,17) )
  x <- sample( questions, 2, replace=F )
  sum(x)==1
}

prob.exam <- function(Nrep) {
  res <- replicate( Nrep, sim.exam() )
  sum(res)/length(res)
}

prob.exam(100000)


###
# zad5

sim.bday <- function(k) {
  x <- sample( c(1:365), k, replace=T )
  any( duplicated(x) )
}

prob.bday <- function(Nrep, k) {
  res <- replicate( Nrep, sim.bday(k) )
  sum(res)/length(res)
}

prob.bday(100000, 25)


###
# zad6

sim.gifts <- function(k) {
  x <- sample( c(1:k), k, replace=F )
  d <- x - c(1:k)
  any(d==0)
}

prob.gifts <- function(Nrep, k) {
  res <- replicate( Nrep, sim.gifts(k) )
  sum(res)/length(res)
}

prob.gifts(100000, 20)


###
# zad7

sim.ants <- function() {
  a1 <- sample( c(2,3), 1 )
  a2 <- sample( c(1,3), 1 )
  a3 <- sample( c(1,2), 1 ) 
  all( c(1,2,3) %in% c(a1,a2,a3) )
  # length( unique( c(a1,a2,a3) ) ) == 3
  # any( duplicated( c(a1,a2,a3) ) ) == F
}

prob.ants <- function(Nrep) {
  res <- replicate( Nrep, sim.ants() )
  sum(res)/length(res)
}

prob.ants(100000)


###
# zad8

# а)
sim.dice.ball.a <- function() {
  dice <- sample( c(1:6), 1 )
  if (dice==6) {
    ball <- sample( c("g", "g", "r", "r"), 1 )
  } else {
    ball <- sample( c("g", "r", "r", "r", "r"), 1 )
  }
  ball=="g"
}

res <- replicate( 100000, sim.dice.ball.a() )
sum(res)/length(res)

# б)
sim.dice.ball.b <- function() {
  dice <- sample( c(1:6), 1 )
  if (dice==6) {
    ball <- sample( c("g", "g", "r", "r"), 1 )
  } else {
    ball <- sample( c("g", "r", "r", "r", "r"), 1 )
  }
  c(dice, ball)
}

res <- replicate( 100000, sim.dice.ball.b() )
# б)
sum(res[1,]!="6" & res[2,]=="g") / sum(res[2,]=="g")
# а)
sum(res[2,]=="g") / length(res[2,])


###
# zad9

# а)
sim.coins.a <- function() {
  coin <- sample( c(11, 11, 22, 12, 12), 1 )
  if (coin==12) {
    up <- sample( c(1,2), 1 )
  } else {
    if (coin==22) {
      up <- 2
    } else {
      up <- 1
    }
  }
  up==1
}

res <- replicate( 100000, sim.coins.a() )
sum(res)/length(res)

# б)
sim.coins.b <- function() {
  coin <- sample( c("11", "11", "22", "12", "12"), 1 )
  side <- sample( c(1,2), 1 )
  up <- substr( coin, start=side, stop=side )
  c(up, coin)
}

res <- replicate( 100000, sim.coins.b() )
# б)
sum(res[1,]=="1" & res[2,]=="12") / sum(res[1,]=="1")
# а)
sum(res[1,]=="1") / length(res[1,])


###
# zad16

# X = брой шестици при 10 хвърляния на зар
# X ~ Bi(n=10, p=1/6)

# P(X = 2)
dbinom(2, 10, 1/6)
choose(10,2)*(1/6)^2*(5/6)^8

# P(X <= 2)
pbinom(2, 10, 1/6)

# P(X >= 2) = 1 - P(X <= 1)
1 - pbinom(1, 10, 1/6)

# P(3 <= X <= 8) = P(X <= 8) - P(X <= 2) 
pbinom(8, 10, 1/6) - pbinom(2, 10, 1/6)
sum( dbinom(3:8, 10, 1/6) )


###
# zad17

# X = брой хвърляния до падане на шестица (вкл.)
# X ~ Ge(p=1/6)

# P(X <= 10)
pgeom(10-1, 1/6)

# P(X >= 6) = 1 - P(X <= 5)
1 - pgeom(5-1, 1/6)


###
# zad18

# X = брой хвърляния докато се паднат общо 3 шестици
# X ~ NB(r=3, p=1/6)

# P(X <= 20)
pnbinom(20-3, 3, 1/6)


###
# zad19

# X = брой нови батерии от избраните

# вероятност двете избрани да са нови
# P(X = 2)
dhyper(2, 5, 3, 2)
choose(5,2)*choose(3,0)/choose(8,2)

# вероятност само една от избраните да е нова
# P(X = 1)
dhyper(1, 5, 3, 2)
choose(5,1)*choose(3,1)/choose(8,2)


###
# zad20

# X = брой грешки на 1500 думи
# X ~ Bi(n=1500, p=1/500)

n <- 1500
p <- 1/500

# P(X <= 2)
pbinom(2, n, p)
ppois(2, n*p)

# P(1 <= X <= 3) = P(X=1) + P(X=2) + P(X=3)
sum( dbinom(1:3, n, p) )

# P(1 <= X <= 3) = P(X <= 3) - P(X <= 0)
pbinom(3, n, p) - pbinom(0, n, p)
ppois(3, n*p) - ppois(0, n*p)

# Тук може да използваме Поасоновото разпределение като приближение на биномното.
# Виждаме, че приближението е добро (получаваме близки вероятности).


###
# zad21

# X = брой верни отговори, дадени от Иван на теста
# X ~ Bi(n=10, p=1/4)

# P(X >= 5) = 1 - P(X <= 4)
1 - pbinom(4, 10, 1/4)


###
# zad22

# въпрос 1
# X = брой тествани до намиране на първия доброволец с дадения ген (вкл.)
# X ~ Ge(p=1/10)

# P(X >= 5) = 1 - P(X <= 4)
1 - pgeom(4-1, 1/10)

# въпрос 2
# X = брой тествани до намиране на 10 доброволци с дадения ген (вкл.)
# X ~ NB(r=10, p=1/10)

# P(X >= 50) = 1 - P(X <= 49)
1 - pnbinom(49-10, 10, 1/10)


###
# zad27

x1 <- runif(5000, 2, 3)
hist(x1)
hist(x1, probability=T)
curve( dunif(x, 2, 3), from=2, to=3, add=T, lwd=2 )


###
# zad28

x1 <- rexp(500, 1/7)
hist(x1, probability=T)
curve( dexp(x, 1/7), from=0, to=max(x1), add=T, lwd=2 )


###
# zad29

x1 <- rnorm(5000, 0, 1)
hist(x1, probability=T)
curve( dnorm(x, 0, 1), add=T, lwd=2 )


###
# zad30

# X = количество душ гел
# X ~ U(248, 255)
# uniform

# P(X < 250) = P(X <= 250)
punif(250, 248, 255)

# v=?  P(X > v) = 0.95
# P(X <= v) = 0.05
qunif(0.05, 248, 255)

punif(248.35, 248, 255)


###
# zad31

# X = време на живот на лазерен диод
# X ~ Exp(1/10)

# P(X > 10) = 1 - P(X <= 10)
1 - pexp(10, 1/10)

# P(7 < X < 11) = P(X < 11) - P(X < 7)
pexp(11, 1/10) - pexp(7, 1/10)

# t=?  P(X > t) = 0.97
# P(X <= t) = 0.03
qexp(0.03, 1/10)


###
# zad32

# X = изразходвано количество кашкавал за седмица
# X ~ N(mu=41, sigma=5)

# P(X>51) = 1 - P(X<=51)
1 - pnorm(51, 41, 5)

# P(45 < X < 50) = P(X < 50) - P(X < 45)
pnorm(50, 41, 5) - pnorm(45, 41, 5)

# t=?  P(X <= t) = 0.99
qnorm(0.99, 41, 5)


###
# zad33

# P(A) със симулации
vol <- rnorm(100000, 252, 3)
sum(vol>250)/length(vol)
# 0.75

# P(B) със симулации
sim.5cups <- function() {
  volume5cups <- rnorm(5, 252, 3)
  sum(volume5cups>250) <= 2
}
res <- replicate( 100000, sim.5cups() )
sum(res)/length(res)
# 0.1

# алтернативно решение
volume5cups <- replicate( 100000, rnorm(5, 252, 3) )
cups.gt.250 <- apply( volume5cups, 2, function(x) sum(x>250) )
sum(cups.gt.250<=2)/length(cups.gt.250)

# теоретично
# X = обем течност, който машина налива в една чаша
# X ~ N(mu=252, sigma=3)

# P(A) = P(X > 250) = 1 - P(X <= 250)
p.a <- 1 - pnorm(250, 252, 3)

# Y = брой наливания с над 250 мл от общо 5 наливания
# Y ~ Bi(n=5, p=p.a)

# P(B) = P(Y<=2)
pbinom(2, 5, p.a)


###
# zad34

n <- 10^7
x <- runif(n, -1, 1)
y <- runif(n, -1, 1)
4*sum(x^2 + y^2 < 1)/n
pi

# картинка
n <- 10000
x <- runif(n, -1, 1)
y <- runif(n, -1, 1)
plot(x, y, pch=".", col="gray")
curve( sqrt(1-x^2), from=-1, to=1, add=T, col="red" )
curve( -sqrt(1-x^2), from=-1, to=1, add=T, col="red" )


###
# zad34

f <- function(x) {
  exp(-x^2/2)*(1/sqrt(2*pi))
}

# метод 1
a <- 0.8
b <- 4
n <- 10^7
x <- runif(n, a, b)
y <- runif(n, 0, f(a))
(sum(y < f(x))/n)*(b-a)*f(a)

# Интегралът е равен на вероятността P(0.8 < X < 4), X ~ N(0,1).
# Вероятността пресметната с функцията pnorm:
pnorm(4) - pnorm(0.8)

# картинка (метод 1)
n <- 10000
x <- runif(n, a, b)
y <- runif(n, 0, f(a))
plot(x, y, pch=".", col="gray")
curve( f(x), from=a, to=b, add=T, col="red" )

# метод 2
a <- 0.8
b <- 4
n <- 10^7
x <- runif(n, a, b)
sum(f(x))*(b-a)/n


###
# zad39

library(MASS)
data(survey)
?survey

table(survey$Exer)

attach(survey)
table(Exer)

sort( table(Exer), decreasing=T )
100*table(Exer)/length(Exer)
100*prop.table( table(Exer) )

barplot( table(Exer) )
barplot( sort( table(Exer), decreasing=T ) )
barplot( 100*table(Exer)/length(Exer) )
pie( table(Exer) )
pie( table(Exer), col=c("red", "yellow", "blue") )


###
# zad40

table(Smoke)
table(Smoke, useNA="ifany")
which( is.na(Smoke) )

sort( table(Smoke), decreasing=T )
100*table(Smoke)/length(Smoke)

barplot( table(Smoke) )
barplot( sort( table(Smoke), decreasing=T ) )
barplot( 100*table(Smoke)/length(Smoke) )
pie( table(Smoke) )


###
# zad41

# а)
tb1 <- 100*table(Smoke)/length(Smoke)
tb1
tb1[2]
tb1["Never"]
# отг. 79.75

# б)
table(Smoke, Exer)
table(Smoke, Exer)[2, 1]
table(Smoke, Exer)["Never", "Freq"]
# отг. 87

# в)
tab.smoke.exer <- table(Smoke, Exer)
# Таблица, в която сумата на всички стойности е 100%:
100*prop.table( tab.smoke.exer )
100*prop.table( tab.smoke.exer )[2, 1]
100*prop.table( tab.smoke.exer )["Never", "Freq"]
# отг. 36.86

# г)
# Таблица, в която сумата на всеки ред е 100%:
100*prop.table( tab.smoke.exer, margin=1 )
100*prop.table( tab.smoke.exer, margin=1 )[2, 1]
100*prop.table( tab.smoke.exer, margin=1 )["Never", "Freq"]
# отг. 46.03

# д)
# Таблица, в която сумата на всяка колона е 100%:
100*prop.table( tab.smoke.exer, margin=2 )
100*prop.table( tab.smoke.exer, margin=2 )[2, 1]
100*prop.table( tab.smoke.exer, margin=2 )["Never", "Freq"]
# отг. 75.65


###
# zad42

barplot( table(Smoke, Exer) )

barplot( table(Smoke, Exer), legend=T )

barplot( table(Smoke, Exer), legend=T,
         args.legend=list(x="top") )

barplot( 100*prop.table( tab.smoke.exer, 2 ), 
         legend=T, xlim=c(0,5),
         args.legend=list(x="right") )


###
# zad43

barplot( table(Exer, Smoke), legend=T, 
         args.legend=list(x="topright") )

barplot( table(Exer, Smoke), legend=T, 
         beside=T,
         args.legend=list(x="topright") )

tab.exer.smoke <- table(Exer, Smoke)

barplot( 100*prop.table( tab.exer.smoke, 2 ), 
         legend=T, xlim=c(0,6),
         args.legend=list(x="right") )


###
# zad44

table(Pulse)
table(Pulse, useNA="ifany")

pulse.grp <- cut(Pulse, breaks=seq(30,110,10))
pulse.grp
table(pulse.grp)

barplot( table(pulse.grp) )
hist(Pulse)
hist(Pulse, breaks=seq(30,110,5))

stripchart(Pulse, method="stack", pch=20)
stripchart(Pulse, method="stack", pch=18)
stripchart(Pulse, method="stack", pch=1)


###
# zad45

table(Age)

age.grp <- cut(Age, breaks=seq(15,75,10))
table(age.grp)

barplot( table(age.grp) )
hist(Age)

stripchart(Age, method="stack", pch=20)


###
my.summary <- function(x) {
  res <- c( median(x, na.rm=T), mean(x, na.rm=T), sd(x, na.rm=T) )
  names(res) <- c("Median", "Mean", "StDev")
  res
}


###
# zad46

library(MASS)
data(survey)
attach(survey)

# а)
median( Pulse, na.rm=T )
mean( Pulse, na.rm=T )
sd( Pulse, na.rm=T )
my.summary( Pulse )

# б)
median( Pulse[Sex=="Female"], na.rm=T )
mean( Pulse[Sex=="Female"], na.rm=T )
sd( Pulse[Sex=="Female"], na.rm=T )
my.summary( Pulse[Sex=="Female"] )

# в)
median( Pulse[Age<=25], na.rm=T )
mean( Pulse[Age<=25], na.rm=T )
sd( Pulse[Age<=25], na.rm=T )
my.summary( Pulse[Age<=25] )

# г)
median( Pulse[Exer=="Freq"], na.rm=T )
mean( Pulse[Exer=="Freq"], na.rm=T )
sd( Pulse[Exer=="Freq"], na.rm=T )
my.summary( Pulse[Exer=="Freq"] )

# д)
median( Pulse[Smoke=="Never" & Exer=="Freq"], na.rm=T )
mean( Pulse[Smoke=="Never" & Exer=="Freq"], na.rm=T )
sd( Pulse[Smoke=="Never" & Exer=="Freq"], na.rm=T )
my.summary( Pulse[Smoke=="Never" & Exer=="Freq"] )


###
# zad47

boxplot(Pulse ~ W.Hnd)

my.summary( Pulse[W.Hnd=="Left"] )
my.summary( Pulse[W.Hnd=="Right"] )


###
# zad48

library(MASS)
data(Traffic)
attach(Traffic)

boxplot(y ~ limit)

my.summary( y[limit=="no"] )
my.summary( y[limit=="yes"] )

detach(Traffic)


###
# zad49

my.plot01 <- function(x) {
  i1 <- min( mean(x)-3*sd(x), min(x) )
  i2 <- max( mean(x)+3*sd(x), max(x) )
  boxplot( x, ylim=c(i1,i2), horizontal=T )
  points( mean(x), 1, pch=18, col="darkorange1", cex=1.7 )
  points( mean(x)-3*sd(x), 1, pch="[", col="darkorange1", cex=1.5 )
  points( mean(x)+3*sd(x), 1, pch="]", col="darkorange1", cex=1.5 )
}

# а)
x <- runif(500, 3, 7)
my.plot01(x)

# б)
x <- rexp(500, 1/5)
my.plot01(x)

# в)
x <- rnorm(500, 5, 1)
my.plot01(x)


###
# zad53

par(mfrow=c(1,2))
lambda <- 1/8
x <- rexp(5000, lambda)
hist(x, probability=T)
y <- 1 - exp(-lambda*x)
hist(y, probability=T)


###
# zad54

par(mfrow=c(1,2))
x <- runif(5000, 0, 1)
hist(x, probability=T)
lambda <- 1/8
y <- -(1/lambda)*log(1-x)
hist(y, probability=T)
curve( dexp(x, lambda), from=0, to=max(y), add=T, lwd=2 )
par(mfrow=c(1,1))


###
# zad55

e03sum <- replicate( 10000, sum( rexp(3, 1/5) ) )
e07sum <- replicate( 10000, sum( rexp(7, 1/5) ) )
e10sum <- replicate( 10000, sum( rexp(10, 1/5) ) )
e30sum <- replicate( 10000, sum( rexp(30, 1/5) ) )
e90sum <- replicate( 10000, sum( rexp(90, 1/5) ) )
e200sum <- replicate( 10000, sum( rexp(200, 1/5) ) )

hist(e03sum)
hist(e07sum)
hist(e10sum)
hist(e30sum)
hist(e90sum)
hist(e200sum)

# алтернативно решение
rs <- sapply( c(3, 7, 10, 30, 90, 200), 
              function(n) replicate(10000, sum(rexp(n, 1/5))) )
colnames(rs) <- as.character(c(3, 7, 10, 30, 90, 200))

par(mfrow=c(2,3))
sapply( 1:6,
        function(i) 
          hist(rs[,i], 
               xlab="",
               main=paste("Sum of Exp, n =", colnames(rs)[i])) )
par(mfrow=c(1,1))


###
# zad56

e03mean <- replicate( 10000, mean( rexp(3, 1/5) ) )
e07mean <- replicate( 10000, mean( rexp(7, 1/5) ) )
e10mean <- replicate( 10000, mean( rexp(10, 1/5) ) )
e30mean <- replicate( 10000, mean( rexp(30, 1/5) ) )
e90mean <- replicate( 10000, mean( rexp(90, 1/5) ) )
e200mean <- replicate( 10000, mean( rexp(200, 1/5) ) )

hist(e03mean)
hist(e07mean)
hist(e10mean)
hist(e30mean)
hist(e90mean)
hist(e200mean)


###
# zad57

u03mean <- replicate( 10000, mean( runif(3, 2, 8) ) )
u07mean <- replicate( 10000, mean( runif(7, 2, 8) ) )
u10mean <- replicate( 10000, mean( runif(10, 2, 8) ) )
u30mean <- replicate( 10000, mean( runif(30, 2, 8) ) )
u90mean <- replicate( 10000, mean( runif(90, 2, 8) ) )
u200mean <- replicate( 10000, mean( runif(200, 2, 8) ) )

hist(u03mean)
hist(u07mean)
hist(u10mean)
hist(u30mean)
hist(u90mean)
hist(u200mean)


###
# zad58

# с използване на ЦГТ (централната гранична теорема)
a <- (980-900)/(900/sqrt(100))
1 - pnorm(a)

# със симулации
mean.vals <- replicate(100000, mean(rexp(100, 1/900)))
sum(mean.vals > 980)/length(mean.vals)


###
# zad59

# с използване на ЦГТ
a <- (35-30)/(60/(sqrt(12)*sqrt(50)))
pnorm(a) - pnorm(-a)

# със симулации
mean.vals <- replicate(100000, mean(runif(50, 0, 60)))
sum(mean.vals > 25 & mean.vals < 35)/length(mean.vals)


###
# zad60

# с използване на ЦГТ
a <- (5.5-5)/(sqrt(5)/sqrt(80))
pnorm(a) -  pnorm(-a)

# със симулации
mean.vals <- replicate(100000, mean(rpois(80, 5)))
sum(mean.vals > 4.5 & mean.vals < 5.5)/length(mean.vals)


###
# zad61 

# пресмятаме mu, sigma
x <- c(4:7)
p <- c(0.2,0.4,0.3,0.1)
mu <- sum(x*p)
sigma <- sqrt( sum(x^2*p) - mu^2 )

# с използване на ЦГТ
a <- (5.5-mu)/(sigma/sqrt(49))
1 - pnorm(a)

# със симулации
mean.vals <- replicate(100000, mean(sample(x, 49, replace=T, prob=p)))
sum(mean.vals > 5.5)/length(mean.vals)


###
# zad62

# с използване на ЦГТ
a <- (4000 - 160*24)/(7*sqrt(160))
1 - pnorm(a)

# Не можем да решим задачата със симулации, 
# понеже не знаем разпределението на X_1,..., X_n.


###
# t distribution
curve( dt(x, df=10), from=-5, to=5, lwd=1.8, col="orange" )
curve( dnorm(x,0,1), add=T, lwd=1.8, lty="dashed", col="blue" )

curve( dt(x, df=30), from=-5, to=5, lwd=1.8, col="orange" )
curve( dnorm(x,0,1), add=T, lwd=1.8, lty="dashed", col="blue" )

curve( dt(x, df=90), from=-5, to=5, lwd=1.8, col="orange" )
curve( dnorm(x,0,1), add=T, lwd=1.8, lty="dashed", col="blue" )


###
# zad63

mu <- 6.7
sigma <- 0.1
n <- 45
x.bar <- 6.756

# P( |X.bar - 6.7| >= 0.056 ) 
# = P( X.bar - 6.7 >= 0.056 ) + P( X.bar - 6.7 <= -0.056 )

a <- 0.056/(sigma/sqrt(n))
1 - pnorm(a) + pnorm(-a)
2*(1-pnorm(a))
# 0.000172


###
# zad64
x <- 64
n <- 100
p <- 0.5

1 - pbinom(x-1, 100, 0.5)
# 0.0033

a <- (x - n*p)/sqrt(n*p*(1-p))
1 - pnorm(a)
# 0.0026


###
# zad65

# X_i = дължина на дясното ухо на i-тата жена
# mu = E(X_i), т.е. mu = средна дължина на дясното ухо на жените (18-30 години)
# H0: mu = 60
# H1: mu != 60

x.bar <- 61.9
sigma <- 4.1
n <- 66
mu <- 60
z.obs <- (x.bar-mu)/(sigma/sqrt(n))
z.obs
p.value <- 2*(1-pnorm(abs(z.obs)))
p.value

# p.value = 0.000167 < 0.05 
# => отхвърляме нулевата хипотеза в полза на алтернативната.
# Имаме основание да твърдим, че средната дължина на дясното ухо 
# на жените на възраст между 18 и 30 години е различна от 60 мм.


###
# zad66

# X_i = концентрация на кадмий в i-тата гъба
# mu = E(X_i), т.е. mu = средна концентрация на кадмий в горските гъбите
# H0: mu = 4
# H1: mu < 4

x <- c(3.1, 3.0, 3.7, 2.6, 4.2, 3.8, 3.6, 2.7, 3.8, 4.4)
mu <- 4
n <- length(x)
t.obs <- (mean(x)-mu)/(sd(x)/sqrt(n))
t.obs
p.value <- pt(t.obs, n-1)
p.value

t.test( x, mu=4, alternative="less" )

# p.value = 0.0137 < 0.05
# => отхвърляме нулевата хипотеза в полза на алтернативната.
# Имаме основание да твърдим, че средната концентрация на кадмий
# в горските гъбите в дадената местност е по-малко от 4 мг/кг.


###
# zad67

# p = вероятност гълъб от дадения вид да намери пътя към дома си
# H0: p = 0.51
# H1: p > 0.51

x <- 22
n <- 38 
p <- 0.51
z.obs <- (x/n - p)/sqrt(p*(1-p)/n)
z.obs
p.value <- 1-pnorm(z.obs)
p.value

prop.test( x=22, n=38, p=0.51, alternative="greater", correct=F )

# p.value = 0.1976 > 0.05
# => нямаме основание да отвърлим нулевата хипотеза.
# Данните не подкрепят твърдението, че вероятността гълъб от 
# дадения вид да намери пътя към дома си е над 51%.


###
# zad68 а)

# X_i = ниво на хемоглобин на i-тото дете
# mu = E(X_i), т.е. mu = средно ниво на хемоглобин при децата страдащи от болестта
# H0: mu = 14.6
# H1: mu != 14.6

x <- c(12.3, 11.2, 14.2, 15.3, 14.8, 13.5, 11.1, 15.1, 15.4, 13.2)
mu <- 14.6
n <- length(x)
t.obs <- (mean(x)-mu)/(sd(x)/sqrt(n))
t.obs
p.value <- 2*(1-pt(abs(t.obs), n-1))
p.value 

t.test( x, mu=14.6 )

# p.value = 0.0877 > 0.05
# => нямаме основание да отхвърлим нулевата хипотеза.
# Нямаме основание да твърдим, че средното ниво на хемоглобин при 
# децата страдащи от тази болест е различно от нормалното ниво от 14.6.


###
# zad68 б)

# X_i = ниво на хемоглобин на i-тото дете
# mu = E(X_i), т.е. mu = средно ниво на хемоглобин при децата страдащи от болестта
# H0: mu = 14.6
# H1: mu < 14.6

x <- c(12.3, 11.2, 14.2, 15.3, 14.8, 13.5, 11.1, 15.1, 15.4, 13.2)
mu <- 14.6
n <- length(x)
t.obs <- (mean(x)-mu)/(sd(x)/sqrt(n))
t.obs
p.value <- pt(t.obs, n-1)
p.value 

t.test( x, mu=14.6, alternative="less" )

# p.value = 0.04387 < 0.05
# => отхвърляме нулевата хипотеза в полза на алтернативната.
# Имаме основание да твърдим, че средното ниво на хемоглобин при 
# децата страдащи от тази болест е по-малко от 14.6.


###
# zad69 а)

# p = вероятност стока в хипермаркета да е с грешна цена
# H0: p = 0.075
# H1: p != 0.075

x <- 14
n <- 200
p <- 0.075
z.obs <- (x/n - p)/sqrt(p*(1-p)/n)
z.obs
p.value <- 2*(1-pnorm(abs(z.obs)))
p.value

prop.test( x=14, n=200, p=0.075, correct=F )

# p.value = 0.7883 > 0.05
# => нямаме основание да отхвърлим нулевата хипотеза.
# Нямаме основание да твърдим, че процентът на стоки с 
# грешна цена се е променил спрямо 2009 година.


###
# zad69 б)
# p = вероятност стока в хипермаркета да е с грешна цена
# H0: p = 0.075
# H1: p < 0.075

x <- 14
n <- 200
p <- 0.075
z.obs <- (x/n - p)/sqrt(p*(1-p)/n)
z.obs
p.value <- pnorm(z.obs)
p.value

prop.test( x=14, n=200, p=0.075, alternative="less", correct=F )

# p.value = 0.3942 > 0.05
# => нямаме основание да отхвърлим нулевата хипотеза.
# Нямаме основание да твърдим, че процентът на стоки с 
# грешна цена е намалял спрямо 2009 година.


###
# zad70

# X_i = количество течност при i-тото наливане
# mu = E(X_i), т.е. mu = средно количество течност, което налива автоматът
# H0: mu = 170
# H1: mu < 170

x.bar <- 168
sigma <- 3.9
n <- 50
mu <- 170

z.obs <- (x.bar-mu)/(sigma/sqrt(n))
z.obs
p.value <- pnorm(z.obs)
p.value

# p.value = 0.00014 < 0.05 
# => отхвърляме нулевата хипотеза в полза на алтернативната.
# Имаме основание да твърдим, че в средно автоматът налива 
# по-малко от 170 грама.


###
# zad71

# X_i = оценка на i-тия студент с вариант А
# Y_i = оценка на i-тия студент с вариант В
# mu_X = E(X_i), т.е. mu_X = средна оценка при падане на вариант А
# mu_Y = E(Y_i), т.е. mu_Y = средна оценка при падане на вариант В
# H0: mu_X = mu_Y
# H1: mu_X > mu_Y

examAB <- read.table( "examAB.txt", header=T )
x <- examAB$points[examAB$variant=="A"]
y <- examAB$points[examAB$variant=="B"]
t.test( x, y, alternative="greater" )

# p.value = 0.01668 < 0.05
# => отхвърляме нулевата хипотеза в полза на алтернативната.
# Имаме основание да твърдим, че в средно студентите получават 
# по-малко точки ако им се е падне вариант В.

# алтернативен синтаксис
t.test( points ~ variant, data=examAB, alternative="greater" )


###
# zad72

# X_i = време на реакция на i-тия участник преди изпиване на 50 мл водка  
# Y_i = време на реакция на i-тия участник след изпиване на 50 мл водка
# mu_X = E(X_i), т.е. mu_X = средно време на реакция преди изпиване на 50 мл водка
# mu_Y = E(Y_i), т.е. mu_Y = средно време на реакция след изпиване на 50 мл водка
# H0: mu_X = mu_Y
# H1: mu_X < mu_Y

react <- read.table( "reacttime.txt", header=T )
x <- react$before
y <- react$after
t.test( x, y, alternative="less", paired=T )
options(scipen=99)
t.test( x, y, alternative="less", paired=T )$p.value

# това ни дава същия резултат
t.test( x-y, alternative="less" )

# p.value = 0.000000000324 < 0.05
# => отхвърляме нулевата хипотеза в полза на алтернативната.
# Имаме основание да твърдим, че след изпиване на 50 мл водка
# времето на реакция в средно се увеличава.


###
# zad73

# p_A = вероятност машина А да произведе дефектен болт
# p_B = вероятност машина B да произведе дефектен болт
# H0: p_A = p_B
# H1: p_A != p_B

x <- c(8, 15)
n <- c(200, 200)

p.hat <- (x[1] + x[2]) / (n[1] + n[2])
z.obs <- (x[1]/n[1] - x[2]/n[2]) / sqrt(p.hat*(1-p.hat)*(1/n[1] + 1/n[2]))
z.obs
p.value <- 2*(1-pnorm(abs(z.obs)))
p.value

# може да ползваме и функцията prop.test
prop.test( x=x, n=n, correct=F )
prop.test( x, n, correct=F )

# p.value = 0.1327 > 0.05
# => нямаме основание да отхвърлим нулевата хипотеза.
# Нямаме основание да твърдим, че двете машини се различават
# по отношение на вероятността да произведат дефектен болт.


###
# zad75

sim.t2 <- function(n, mu1, mu2, sigma1, sigma2) {
  x <- rnorm(n, mean=mu1, sd=sigma1)
  y <- rnorm(n, mean=mu2, sd=sigma2)
  t.test(x,y)$p.value
}

rs <- replicate( 10000, sim.t2(n=500, mu1=5, mu2=5, sigma1=1, sigma2=0.8) )
sum(rs<=0.05)/length(rs)


###
# zad76

rs <- replicate( 10000, sim.t2(n=1000, mu1=5, mu2=5.2, sigma1=1, sigma2=1) )
sum(rs<=0.05)/length(rs)


###
# zad77

# p1 = вероятност някой да е вегетарианец през 2007
# p2 = вероятност някой да е вегетарианец през 2019
# H0: p1 = p2
# H1: p1 < p2

x <- c(26, 43)
n <- c(500, 540)
prop.test( x=x, n=n, alternative="less", correct=F )

# p.value = 0.03683 < 0.05
# => отхвърляме нулевата хипотеза в полза на алтернативната.
# Имаме основание да твърдим, че процентът на вегетарианците 
# през 2019 година се е увеличил спрямо 2007 година.


###
# zad78

# mu_X = средно съдържание на примеси при определяне по метод 1
# mu_Y = средно съдържание на примеси при определяне по метод 2
# H0: mu_X = mu_Y
# H1: mu_X != mu_Y

# копирали сме таблицата с данни (без заглавния ред) в "zad78.txt"
zad78 <- read.table( "zad78.txt" )
x <- zad78[,2]
y <- zad78[,3]

t.test( x, y, paired=T )

# p.value = 0.01026 < 0.05
# => отхвърляме нулевата хипотеза в полза на алтернативната.
# Не може да се приеме, че двата метода
# дават в средно едни и същи резултати.

d <- x - y
n <- length(d)
t.obs <- mean(d)/(sd(d)/sqrt(n))
t.obs
p.value <- 2*(1-pt(abs(t.obs), n-1))
p.value 


###
# zad79

# mu_X = средно време за четене при първия шрифт
# mu_Y = средно време за четене при втория шрифт
# H0: mu_X = mu_Y
# H1: mu_X != mu_Y

x.bar <- 7.88
s.x <- 1.73
y.bar <- 8.48
s.y <- 2.12
n <- 50
m <- 50

t.obs <- (x.bar - y.bar) / sqrt(s.x^2/n + s.y^2/m)
t.obs
df <- (s.x^2/n + s.y^2/m)^2 / (((s.x^2/n)^2)/(n-1) + ((s.y^2/m)^2)/(m-1))
df
p.value <- 2*(1-pt(abs(t.obs), df))
p.value 

# p.value = 0.1243729 > 0.05
# => нямаме основание да отхвърлим нулевата хипотеза.
# Нямаме основание да твърдим, че средното време за четене  
# е различно за двата шрифта.

# Ако използваме нормално разпределение,
# получаваме приблизително същото p.value.
p.value1 <- 2*(1-pnorm(abs(t.obs)))
p.value1 


###
# zad80

z1.ci <- function(x.bar, sigma, n, alpha) {
  b1 <- x.bar - qnorm(1-alpha/2)*(sigma/sqrt(n))
  b2 <- x.bar + qnorm(1-alpha/2)*(sigma/sqrt(n))
  c(b1, b2)
}

z1.ci( x.bar=61.9, sigma=4.1, n=66, alpha=0.05 )

z1.ci( x.bar=61.9, sigma=4.1, n=88, alpha=0.05 )


###
# zad81

t1.ci <- function(x.bar, s, n, alpha) {
  b1 <- x.bar - qt(1-alpha/2, df=n-1)*(s/sqrt(n))
  b2 <- x.bar + qt(1-alpha/2, df=n-1)*(s/sqrt(n))
  c(b1, b2)
}

x <- c(3.1, 3.0, 3.7, 2.6, 4.2, 3.8, 3.6, 2.7, 3.8, 4.4)

t1.ci( x.bar=mean(x), s=sd(x), n=length(x), alpha=0.05 )

t.test( x, conf.level=0.95 )$conf.int[1:2]

t1.ci( x.bar=mean(x), s=sd(x), n=length(x), alpha=0.1 )

t.test( x, conf.level=0.9 )$conf.int[1:2]


###
# zad82

prop1.ci <- function(x, n, alpha) {
  p.hat <- x/n
  b1 <- p.hat - qnorm(1-alpha/2)*sqrt(p.hat*(1-p.hat)/n)
  b2 <- p.hat + qnorm(1-alpha/2)*sqrt(p.hat*(1-p.hat)/n)
  c(b1, b2)
}

prop1.ci( x=22, n=38, alpha=0.05 )

prop.test( x=22, n=38, conf.level=0.95, correct=F )$conf.int[1:2]


###
# zad83

sim1 <- function(n, alpha) {
  x <- runif(n, 5, 9)
  ci <- t.test(x, conf.level=1-alpha)$conf.int[1:2]
  cnd1 <- ( ci[1] <= 7 & ci[2] >= 7 )
  cnd1
}

rs1 <- replicate( 10000, sim1(n=500, alpha=0.05) )
table(rs1)/length(rs1)


###
# zad84

sim2 <- function(n, alpha) {
  x <- runif(n, 5, 9)
  p.val <- t.test(x, mu=7)$p.value
  cnd2 <- ( p.val > alpha )
  cnd2
}

rs2 <- replicate( 10000, sim2(n=500, alpha=0.05) )
table(rs2)/length(rs2)


###
# zad85

sim3 <- function(n, alpha) {
  x <- runif(n, 5, 9)
  t.result <- t.test(x, mu=7, conf.level=1-alpha)
  ci <- t.result$conf.int[1:2]
  p.val <- t.result$p.value
  cnd1 <- ( ci[1] <= 7 & ci[2] >= 7 )
  cnd2 <- ( p.val > alpha )
  c( cnd1, cnd2 )
}

rs3 <- replicate( 10000, sim3(n=500, alpha=0.05) )
cnd1r <- rs3[1, ]
cnd2r <- rs3[2, ]
table(cnd1r, cnd2r)


###
# zad86

# p_i = вероятност да се падне i, i=1...6
# H0: p_i = 1/6, i=1...6
# H1: p_i != 1/6 за поне едно i

x <- c(28, 36, 36, 30, 27, 23)
probs <- rep(1/6, 6)

n <- sum(x)
k <- length(probs)
chi2.obs <- sum( (x - n*probs)^2 / (n*probs) )
chi2.obs
p.value <- 1-pchisq(chi2.obs, df=k-1)
p.value

chisq.test(x, p=probs)
chisq.test(x, p=probs)$p.value

# p.value > 0.05 
# => нямаме основания да отхвърлим H0.
# Можем да считаме, че зарът е правилен 
# (всяка от страните се пада с вероятност 1/6).

tb1 <- rbind( probs, x/sum(x) )
colnames(tb1) <- as.character(c(1:6))
rownames(tb1) <- c("probability (H0)", "observed freq")
barplot(tb1, beside=T, legend=T, ylim=c(0,0.3))


###
# zad87

# p_E = вероятност да срещнем буква Е
# p_T = вероятност да срещнем буква T
# ...
# H0: (p_E, p_T, ...) = (0.1202, 0.0910, ...)
# H1: (p_E, p_T, ...) != (0.1202, 0.0910, ...)

load("letterFreq.RData")
probs*100
x1

chisq.test(x1, p=probs)

# p.value < 0.05 
# => отхвърляме H0 в полза на H1.
# Нямаме основания да твърдим, че вероятностите за срещане 
# на съответните букви са както в английския език.

tb1 <- rbind( probs, x1/sum(x1) )
rownames(tb1) <- c("probability (H0)", "observed freq")
barplot(tb1, beside=T, legend=T, args.legend=list(x="top"))


###
# zad90

library(MASS)
tb <- table( survey$Sex, survey$Smoke )
tb

# H0: пушенето и пола са независими
# H1: пушенето и пола не са независими (има връзка между пушене и пол)

n <- sum(tb)
df <- (nrow(tb)-1)*(ncol(tb)-1)
sex <- apply(tb, 1, sum)
smk <- apply(tb, 2, sum)

expected <- (sex %o% smk)/n
observed <- tb
chi2.obs <- sum( (observed - expected)^2 / expected )
chi2.obs
p.value <- 1-pchisq(chi2.obs, df)
p.value

chisq.test(tb)

# p.value > 0.05 
# => нямаме основания да отхвърлим нулевата хипотеза.
# Нямаме основания да твърдим, че има връзка между пушенето и пола.

observed
chisq.test(tb)$observed
expected
chisq.test(tb)$expected


###
# zad91

eyecol <- read.table("ManWomanEye.txt", header=T)
attach(eyecol)
tb <- table(man, woman, deparse.level=2)
tb

# H0: цвета на очите на мъжа и цвета на очите на жената са независими
# H1: има връзка между цвета на очите на мъжа и цвета на очите на жената

n <- sum(tb)
df <- (nrow(tb)-1)*(ncol(tb)-1)
males <- apply(tb, 1, sum)
females <- apply(tb, 2, sum)

expected <- (males %o% females)/n
observed <- tb
chi2.obs <- sum( (observed - expected)^2 / expected )
chi2.obs
p.value <- 1-pchisq(chi2.obs, df)
p.value

chisq.test(tb)

# p.value < 0.05 
# => отхвръляме нулевата хипотеза в полза на алтернативната.
# Можем да твърдим, че има връзка между
# цвета на очите на мъжа и цвета на очите на жената.

mosaicplot(tb)
barplot(tb)
barplot( prop.table(tb, 2) )


###
# zad94

sim.dice1 <- function(n) {
  dice <- sample( c(1:6), n, replace=T )
  x <- tabulate(dice, nbins=6)
  chisq.test( x, p=rep(1/6, 6) )$p.value
}

res <- replicate( 10000, sim.dice1(100) )
sum(res>0.05)/length(res)

# Заключението на теста е вярно ако не отхвърлим H0, 
# т.е. ако p.value > 0.05.


###
# zad95

# а)
n <- 100
x <- rnorm(n, 5, 1)
y <- 2*x
plot(x,y)
cor(x,y)

# б)
x <- rnorm(n, 5, 1)
eps <- rnorm(n, 0, 1)
y <- 2*x + eps
plot(x,y)
cor(x,y)

# в)
x <- rnorm(n, 5, 1)
eps <- rnorm(n, 0, 2)
y <- 2*x + eps
plot(x,y)
cor(x,y)

# г)
x <- rnorm(n, 5, 1)
eps <- rnorm(n, 0, 0.5)
y <- 0.1*x + eps
plot(x,y, ylim=c(-4,4))
cor(x,y)

# д)
x <- rnorm(n, 5, 1)
y <- rnorm(n, 5, 1)
plot(x,y)
cor(x,y)

# е)
x <- rnorm(n, 5, 1)
eps <- rnorm(n, 0, 1)
y <- (-2)*x + eps
plot(x,y)
cor(x,y)


###
# zad96

alco <- read.table("bac.txt", header=T)

# a)
m1 <- lm( bac ~ beers, data=alco )
m1
# y = съдържание на алкохол в кръвта (bac)
# x = брой изпити бутилки бира (beers)
# модел:
# y = beta0 + beta1*x + eps
#  друг запис: bac = beta0 + beta1*beers + eps
# оценено регресионно уравнение:
# y.hat = -0.01270 + 0.01796*x
#  друг запис: bac.hat = -0.01270 + 0.01796*beers

plot( bac ~ beers, data=alco )
abline( coef(m1), lwd=2 )

# графика на остатъците срещу y.hat
plot( fitted(m1), resid(m1) )

# б)
# Според оцененото регресионно уравнение:
# 
# При изпиване на още една бира съдържанието на алкохол в кръвта
# се увеличава средно с 0.01796.
# 
# При нула изпити бири средното съдъжание на алкохол в кръвта е -0.01270.

# в)
# H0: beta1 = 0
# H1: beta1 != 0

summary(m1)
summary(m1)$coefficients
p.value <- summary(m1)$coefficients[2,4]
p.value < 0.05

# p.value < 0.05 => отхвърляме H0.
# Можем да твърдим, че има линейна връзка между броя на 
# изпитите бутилки бира и съдържанието на алкохол в кръвта.

# г)
# H0: beta1 = 0.02
# H1: beta1 != 0.02

# доверителни интервали (ДИ) за beta0 и beta1
confint(m1)

# 0.02 е в ДИ [0.0128, 0.0231] за beta1 => не отхвърляме H0.
# Нямаме основания да отхвърлим хипотезата, че при изпиването на 
# още една бира съдържанието на алкохол в кръвта се увеличава 
# средно с 0.02.

# д)
predict( m1, data.frame( beers=5 ), interval="confidence" )

# [ -0.01270 + 0.01796*5 = fit ]
# 
# Доверителният интервал е [0.066, 0.088]

# е)
plot( bac ~ beers, data=alco )
abline( coef(m1), lwd=2 )

xx <- data.frame( beers=seq(1, 9, 0.5) )

# доверителни интервали
cint <- predict( m1, xx, interval="confidence" )
lines( xx$beers, cint[,2], type="l", lty="dotted", lwd=2 )
lines( xx$beers, cint[,3], type="l", lty="dotted", lwd=2 )

# интервали за прогноза
pint <- predict( m1, xx, interval="prediction" )
lines( xx$beers, pint[,2], type="l", lty="dotted", col="coral", lwd=2 )
lines( xx$beers, pint[,3], type="l", lty="dotted", col="coral", lwd=2 )


###
# zad97

# a)
set.seed(12)
n <- 50
beta0 <- 2
beta1 <- 1.5
sigma <- 2
x <- runif(n, 1, 7)
eps <- rnorm(n, 0, sigma)
y <- beta0 + beta1*x + eps

m1 <- lm(y~x)
plot(x, y)
abline( coef(m1), lwd=2 )
abline( a=beta0, b=beta1, col="coral", lwd=2 )

summary(m1)
summary(m1)$r.squared
confint(m1)

# б)
set.seed(12)
n <- 50
beta0 <- 2
beta1 <- 1.5
sigma <- 1
x <- runif(n, 1, 7)
eps <- rnorm(n, 0, sigma)
y <- beta0 + beta1*x + eps

m2 <- lm(y~x)
plot(x, y)
abline( coef(m2), lwd=2 )
abline( a=beta0, b=beta1, col="coral", lwd=2 )

summary(m2)
summary(m2)$r.squared
confint(m2)

# в)
set.seed(12)
n <- 50
beta0 <- 2
beta1 <- 0.17
sigma <- 1
x <- runif(n, 1, 7)
eps <- rnorm(n, 0, sigma)
y <- beta0 + beta1*x + eps

m3 <- lm(y~x)
plot(x, y, ylim=c(0,13))
abline( coef(m3), lwd=2 )
abline( a=beta0, b=beta1, col="coral", lwd=2 )

summary(m3)
summary(m3)$r.squared
confint(m3)


###
# zad98

set.seed(12)
n <- 50
beta0 <- 2
beta1 <- 1.1
sigma <- 2.5
x <- runif(n, 1, 7)
eps <- rnorm(n, 0, sigma)
y <- beta0 + beta1*x^2 + eps

m4 <- lm(y~x)
plot(x, y)
abline( coef(m4), lwd=2 )

summary(m4)
summary(m4)$r.squared
confint(m4)

plot( fitted(m4), resid(m4) )


###
# zad99

satgpa <- read.table("satgpa.txt", header=T)

# scatter plot matrix
pairs( satgpa, gap=0, cex.labels=0.9 )

# а)
m1 <- lm( fy_gpa ~ hs_gpa, data=satgpa )
m1
# y = успех от първата година в колежа (fy_gpa)
# x = успех от гимназията (hs_gpa)
# модел:
# y = beta0 + beta1*x + eps
# оценено регресионно уравнение:
# y.hat = 0.09132 + 0.74314*x

plot( fy_gpa ~ hs_gpa, data=satgpa )
abline( coef(m1), lwd=2 )

# графика на остатъците срещу y.hat
plot( fitted(m1), resid(m1) )

# б)
# Според оцененото регресионно уравнение,
# успех от гимназията по-висок с 1 съответства на 
# успех от първата година в колежа по-висок средно с 0.74314.

# H0: beta1 = 0
# H1: beta1 != 0
summary(m1)
p.value <- summary(m1)$coefficients[2,4]
p.value < 0.05 
# => отхвърляме H0.
# Можем да твърдим, че има линейна връзка между успеха от гимназията
# и успеха от първата година в колежа.

# в)
# доверителен интервал
predict( m1, data.frame( hs_gpa=3.5 ), interval="confidence" )

# интервал за прогноза
predict( m1, data.frame( hs_gpa=3.5 ), interval="prediction" )

# г)
m2 <- lm( fy_gpa ~ hs_gpa + sat_sum, data=satgpa )
summary(m2)
plot( fitted(m2), resid(m2) )

m3 <- lm( fy_gpa ~ hs_gpa + sat_m, data=satgpa )
summary(m3)
plot( fitted(m3), resid(m3) )

m4 <- lm( fy_gpa ~ hs_gpa + sat_v, data=satgpa )
summary(m4)
plot( fitted(m4), resid(m4) )

summary(m1)$adj.r.squared
summary(m2)$adj.r.squared
summary(m3)$adj.r.squared
summary(m4)$adj.r.squared
# Моделът m2 има най-голям adj.r.squared => е най-добър от трите
# (ако считаме, че моделът с най-висок adj.r.squared е най-добър).


###
# zad100

cher <- read.table("cherry.txt", header=T)
# scatter plot matrix
pairs( cher, gap=0, cex.labels=0.9 )

# а)
m1 <- lm( volume ~ diam, data=cher )
m1
# y = обем (volume)
# x = диаметър (diam)
# модел:
# y = beta0 + beta1*x + eps
# оценено регресионно уравнение:
# y.hat = -36.943 + 5.066*x

plot( volume ~ diam, data=cher )
abline( coef(m1), lwd=2 )

summary(m1)
plot( fitted(m1), resid(m1) )

# б)
# Според оцененото регресионно уравнение, ако диаметърът е по-голям с 1 инч, 
# обемът ще е по-голям средно с 5.066 кубични фута.

# в)
m2 <- lm( volume ~ diam + height, data=cher )
m2
# y = обем (volume)
# x1 = диаметър (diam)
# x2 = височина (height)
# модел:
# y = beta0 + beta1*x1 + beta2*x2 + eps
# оценено регресионно уравнение:
# y.hat = -57.9877 + 4.7082*x1 + 0.3393*x2

summary(m2)
plot( fitted(m2), resid(m2) )

# Според оцененото регресионно уравнение:
# 
# Ако диаметърът е по-голям с 1 инч при фиксирана височина, 
# обемът ще е по-голям средно с 4.7082 кубични фута.
# 
# Ако височината е по-голяма с 1 фут при фиксиран диаметър, 
# обемът ще е по-голям средно с 0.3393 кубични фута.

# г)
ci.g <- predict( m2, data.frame( diam=14, height=70 ), interval="confidence" )
ci.g

# д)
cher$diam2 <- cher$diam^2
m3 <- lm( volume ~ diam2 + height, data=cher )
summary(m3)
plot( fitted(m3), resid(m3) )

ci.d <- predict( m3, data.frame( diam2=14^2, height=70 ), interval="confidence" )
ci.d

# Доверителният интервал с модел m3 е по-къс:
ci.g[3] - ci.g[2]
ci.d[3] - ci.d[2]

summary(m1)$adj.r.squared
summary(m2)$adj.r.squared
summary(m3)$adj.r.squared
# Моделът m3 има най-голям adj.r.squared

# Друг начин да включим квадрата на диаметъра:
m4 <- lm( volume ~ I(diam^2) + height, data=cher )
predict( m4, data.frame( diam=14, height=70 ), interval="confidence" )


###
# zad101

duke <- read.csv("duke_forest.csv", header=T)
pairs( duke[,c(2,3,4,5,7,11)], gap=0, cex.labels=0.9 )

# backward elimination:
# Построяваме модел включващ всички възможни предиктори.
# Премахваме предиктора с най-голямо p.value докато получим модел,
# в който всички предиктори имат p.value < 0.05.

options(scipen=999)

m01 <- lm( price ~ bed + bath + area + year_built + lot, data=duke )
summary(m01)$coefficients

m02 <- lm( price ~ bath + area + year_built + lot, data=duke )
summary(m02)$coefficients

m03 <- lm( price ~ bath + area + lot, data=duke )
summary(m03)$coefficients

# Получаваме модел m03 като резултат от backward elimination.

# Друг подход:
# В модела не е желателно да има предиктори, които са силно корелирани.
# От корелационната матрица виждаме, че bed, bath и area са силно корелирани помежду си.
cor( duke[,c(3,4,5)], use="complete.obs" )

# Затова в модела може да включим само една от променливите bed, bath и area, 
# като запазим year_built + lot.

m21 <- lm( price ~ area + year_built + lot, data=duke )
summary(m21)$coefficients

m22 <- lm( price ~ bed + year_built + lot, data=duke )
summary(m22)$coefficients

m23 <- lm( price ~ bath + year_built + lot, data=duke )
summary(m23)$coefficients

summary(m21)$adj.r.squared
summary(m22)$adj.r.squared
summary(m23)$adj.r.squared

# От горните три модела, m21 има най-голям adj.r.squared. 
# В модела m21 всички предиктори имат p.value < 0.05.

# Ако сравним adj.r.squared на m21 и m03, ще видим, че не се различават съществено.
summary(m03)$adj.r.squared


###
# zad102

sim.lm.a <- function(n) {
  x <- runif(n, 1, 10)
  y <- 2 + 5*x + rnorm(n, 0, 5) 
  m1 <- lm(y~x)
  c( coef(m1)["x"], confint(m1, "x"), use.names=F )
}

sim.lm.b <- function(n) {
  x <- runif(n, 1, 10)
  y <- 2 + 5*x + rexp(n, 1/5)
  m1 <- lm(y~x)
  c( coef(m1)["x"], confint(m1, "x"), use.names=F )
}

smry <- function(rs) {
  mean.b1.hat <- mean( rs[1,] )
  ci.coverage <- sum( rs[2,] <= 5 & 5 <= rs[3,] ) / ncol(rs)
  mean.ci.len <- mean( rs[3,] - rs[2,] )
  c(mean.b1.hat, ci.coverage, mean.ci.len)
}


res.a.30 <- replicate( 10000, sim.lm.a(30) )
res.b.30 <- replicate( 10000, sim.lm.b(30) )

smry(res.a.30)
smry(res.b.30)

res.a.50 <- replicate( 10000, sim.lm.a(50) )
res.b.50 <- replicate( 10000, sim.lm.b(50) )

smry(res.a.50)
smry(res.b.50)

res.a.100 <- replicate( 10000, sim.lm.a(100) )
res.b.100 <- replicate( 10000, sim.lm.b(100) )

smry(res.a.100)
smry(res.b.100)

res.a.500 <- replicate( 10000, sim.lm.a(500) )
res.b.500 <- replicate( 10000, sim.lm.b(500) )

smry(res.a.500)
smry(res.b.500)


###


