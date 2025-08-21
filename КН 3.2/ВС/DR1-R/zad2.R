exD <- 183.8
dxD <- 7.1
exS <- 177.3
dxS <- 6.4
dutchProb <- 0.8
spanishProb <- 0.2
n <- 100

probBsim <- function() {
  exp <- function() {
    dutchHeights <- rnorm(dutchProb * n, exD, dxD)
    spanishHeights <- rnorm(spanishProb * n, exS, dxS)
    
    heights <- c(dutchHeights, spanishHeights)
    h <- sample(heights, 1)
    h >= 180 & h <= 190
  }
  
  res <- replicate(100000, exp())
  sum(res)/length(res)
}
probBsim()

probBfunc <- function() {
  dutchHeightsProb <- pnorm(190, exD, dxD) - pnorm(180, exD, dxD)
  spanishHeightsProb <- pnorm(190, exS, dxS) - pnorm(180, exS, dxS)
  prob <- dutchHeightsProb * dutchProb + spanishHeightsProb * spanishProb 
  prob
}
probBfunc()



probCsim <- function() {
  exp <- function() {
    dutchHeights <- rnorm(dutchProb * n, exD, dxD)
    spanishHeights <- rnorm(spanishProb * n, exS, dxS)
    
    heights <- c(dutchHeights, spanishHeights)
    h <- sample(heights, 1)
    h > 190
  }
  
  res <- replicate(100000, exp())
  sum(res)/length(res)
}
probCsim()

probCfunc <- function() {
  dutchHeightsProb <- 1 - pnorm(190, exD, dxD)
  spanishHeightsProb <- 1 - pnorm(190, exS, dxS)
  prob <- dutchHeightsProb * dutchProb + spanishHeightsProb * spanishProb 
  prob
}
probCfunc()
