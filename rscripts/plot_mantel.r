setwd('~/soraida_r/mantel_analysis')
library(vegan) ## you must load vegan to read the results properly!
library(ggplot2)
library(gridExtra) ## to grid the plots

# load in results to list 'results'
results <- readRDS('nursery_files/test_result_1-8.rds') 
print(results[[7]]) # check that it's correct

# make it into a dataframe if you want to manipulate it
df <- as.data.frame(results[[7]][1])
print(df)

# otherwise, you can just extract that first result with $mantel.res
results[[1]]$mantel.res

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
