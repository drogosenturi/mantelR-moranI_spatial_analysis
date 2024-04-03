setwd('~/soraida_r/')
library(vegan) ## you must load vegan to read the results properly!
library(ggplot2)
library(gridExtra) ## to grid the plots
library(parallel)
library(gtools)

# load in results to list 'results'
results <- readRDS('local_results/*') 
print(results[[7]]) # check that it's correct

# make it into a dataframe if you want to manipulate it
df <- as.data.frame(results[[7]][1])
print(df)

# otherwise, you can just extract that first result with $mantel.res
results[[1]]$mantel.res

##                 LOCAL                ##

# read in all files into one object
files <- paste0('~/soraida_r/local_results/',
                    list.files('~/soraida_r/local_results/',
                    recursive = TRUE))
files <- mixedsort(files)
read_in <- function(i) {
    return(
        readRDS(files[i])
    )
}
extracted <- lapply(1:length(files), read_in)

# while loop to extract all 500 results
i <- 1
while(i < 39) {
    new <- append(new, extracted[[i]][1:length(extracted[[i]])])
    i <- i + 1
}
new <- new[-1] #remove first object creation line
saveRDS(new, "full_results.rds")

# extract only the mantel results
mantel_vals <- function(i) {
    return (
        new[[i]]$mantel.res
    )
}
result_only <- lapply(1:length(new), mantel_vals)
saveRDS(result_only, "mantel_results_only.rds")

##              GLOBAL              ##

# read in
files <- paste0('~/soraida_r/global_results/',
                    list.files('~/soraida_r/global_results/',
                    recursive = TRUE))
files <- mixedsort(files)
read_in <- function(i) {
    return(
        readRDS(files[i])
    )
}
extracted <- lapply(1:length(files), read_in)

# while loop to extract all 500 results
i <- 1
while(i < 14) {
    new <- append(new, extracted[[i]][1:length(extracted[[i]])])
    i <- i + 1
}
new <- new[-1] #remove first object creation line
saveRDS(new, "~/soraida_r/global_results/global_500.rds")

# extract only the mantel results
global_vals <- function(i) {
    return (
        new[[i]][c(3,4)]
    )
}
result_only <- lapply(1:length(new), global_vals)
saveRDS(result_only, "global_statistics_only.rds")

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
