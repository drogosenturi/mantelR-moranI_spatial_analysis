setwd('~/soraida_r/Dummy2/')
library(vegan)
results <- readRDS('test_result.rds')
print(results[[1]])
plot(results[[1]])

