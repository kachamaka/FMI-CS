exp <- function() {
  problems <- sample(c(rep(0, 80), rep(1, 20)), 100, replace = F)
  variants <- matrix(problems, ncol = 20, byrow = T)
  sums <- colSums(variants)
  all(sums == 1)
}

res <- replicate(100000000, exp())
sum(res)/length(res)
