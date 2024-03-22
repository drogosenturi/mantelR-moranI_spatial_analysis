setwd('~/soraida_r/mantel_analysis')
library(vegan)
library(ggplot2)
library(gridExtra)
results <- readRDS('nursery_files/test_result_1-8.rds')
print(results[[7]])
## plot multiple into pdf
plots <- function(i) {
    output <- plot(results[[i]])
    return(
        output
    )
}
pdf("plots/test_plots_1-8.pdf", onefile = TRUE)
lapply(1:8, plots)
dev.off()

plot(results[[1]])
jpeg("test_plot.jpg")
results[[5]] |> plot()
dev.off()
