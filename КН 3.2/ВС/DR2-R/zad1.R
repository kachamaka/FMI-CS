sample_sizes <- c(30, 50, 100, 200, 500)
size <- length(sample_sizes)
num_tests <- 10000

independent_sample_test <- function(x, y) {
  result <- t.test(x, y)
  return(result$p.value > 0.05)
}

paired_sample_test <- function(x, y) {
  result <- t.test(x, y, paired = TRUE)
  return(result$p.value > 0.05)
}

test_independent <- function(n) {
  result <- replicate(10000, {
    x <- rnorm(n, mean = 7, sd = 1)
    e <- rnorm(n, mean = 0.2, sd = 1)
    y <- x + e 
    independent_sample_test(x, y)
  })
  
  return(result)
}

test_paired <- function(n) {
  result <- replicate(10000, {
    x <- rnorm(n, mean = 7, sd = 1)
    e <- rnorm(n, mean = 0.2, sd = 1)
    y <- x + e 
    paired_sample_test(x, y)
  })
  
  return(result)
}

results_independent <- rep(0, times = size)
results_paired <- rep(0, times = size)

for (i in 1:size) {
  independent <- test_independent(sample_sizes[i])
  paired <- test_paired(sample_sizes[i])
  
  results_independent[i] <- (sum(independent)/length(independent))
  results_paired[i] <- (sum(paired)/length(paired))
}
results_independent
results_paired

plot(sample_sizes, results_independent, type="b", pch=19, col="blue",
     ylim = c(0, 1), xlab = "N", ylab = "Ratio", main = "Plot of Two Vectors")
lines(sample_sizes, results_paired, col = "red", type = "b", pch = 19)
legend("topright", legend = c("Independent", "Paired"), col = c("blue", "red"), lty = 1, pch = 19)
