num_simulations <- 10000
n_values <- c(5, 10, 20, 30, 50, 100)  
prob <- c(0.1, 0.1, 0.1, 0.1, 0.1, 0.5)  

simulate_rolls <- function(n, probabilities) {
  sides <- length(probabilities)
  rolls <- sample(1:sides, n, replace = TRUE, prob = probabilities)
  return(rolls)
}

test_hypothesis <- function(rolls) {
  r <- as.numeric(table(factor(rolls, levels = 1:6)))
    
  result <- chisq.test(r)
  return(result$p.value > 0.05)
}

test_sample <- function(n) {
  result <- replicate(10000, {
    rolls <- simulate_rolls(n, prob)
    test_hypothesis(rolls)
  })
  
  return(result)
}

results <- c(1:6)

for (i in 1:length(n_values)) {
  rolls <- test_sample(n_values[i])
  results[i] <- sum(rolls)/num_simulations
}

results

plot(n_values, results, type="b", pch=19, col="blue",
     ylim = c(0, 1), xlab = "N", ylab = "Ratio", main = "Plot of Vector")


