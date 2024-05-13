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

##                 LOCAL MANTEL                ##

# read in all files into one object
files <- paste0('~/soraida_r/mantel_results/local/',
                    list.files('~/soraida_r/mantel_results/local/',
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
saveRDS(new, "~/soraida_r/mantel_results/local/l_mantel_full.rds")

# extract only the mantel results
l_mantel_vals <- function(i) {
    return (
        new[[i]]$mantel.res
    )
}
result_only <- lapply(1:length(new), l_mantel_vals)
saveRDS(result_only, "~/soraida_r/mantel_results/local/l_mantel_results.rds")

##              GLOBAL MANTEL              ##

# read in
files <- paste0('~/soraida_r/mantel_results/global/',
                    list.files('~/soraida_r/mantel_results/global/',
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
saveRDS(new, "~/soraida_r/mantel_results/global/g_mantel_full.rds")

# extract only the mantel results
g_mantel_vals <- function(i) {
    return (
        new[[i]][c(3,4)]
    )
}
result_only <- lapply(1:length(new), g_mantel_vals)
saveRDS(result_only, "~/soraida_r/mantel_results/global/g_mantel_results.rds")

##                 LOCAL MORAN                ##

# read in all files into one object
files <- paste0('~/soraida_r/moran_results/local/',
                    list.files('~/soraida_r/moran_results/local/',
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
while(i < (length(extracted) + 1)) {
    new <- append(new, extracted[[i]][1:length(extracted[[i]])])
    i <- i + 1
}
new <- new[-1] #remove first object creation line
saveRDS(new, "~/soraida_r/moran_results/local/l_moran_full.rds")

# extract useful information
l_mantel_vals <- function(i) {
    return (
        new[[i]]$mantel.res
    )
}
result_only <- lapply(1:length(new), l_mantel_vals)
saveRDS(result_only, "~/soraida_r/moran_results/local/l_moran_results.rds")

##              GLOBAL MANTEL              ##

# read in
files <- paste0('~/soraida_r/moran_results/global/',
                    list.files('~/soraida_r/moran_results/global/',
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
while(i < (length(extracted) + 1)) {
    new <- append(new, extracted[[i]][1:length(extracted[[i]])])
    i <- i + 1
}
new <- new[-1] #remove first object creation line
saveRDS(new, "~/soraida_r/moran_results/global/g_moran_full.rds")

# extract only the mantel results
g_mantel_vals <- function(i) {
    return (
        new[[i]][c(3,4)]
    )
}
result_only <- lapply(1:length(new), g_mantel_vals)
saveRDS(result_only, "~/soraida_r/moran_results/global/g_moran_results.rds")

#############################################################################

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
