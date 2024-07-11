setwd('~/soraida_r/')
library(vegan) ## you must load vegan to read the results properly!
library(ggplot2)
library(gridExtra) ## to grid the plots
library(parallel)
library(gtools)

##                 LOCAL MANTEL EXPERIMENT 1               ##

# read in all files into one object
files <- paste0('~/soraida_r/mantel_results/exp1/local/',
                    list.files('~/soraida_r/mantel_results/exp1/local/',
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
saveRDS(new, "/home/sokui/soraida_r/mantel_results/exp1/local/exp1_mantel_local.rds")

##              GLOBAL MANTEL EXPERIMENT 1             ##

# read in
files <- paste0('/home/sokui/soraida_r/mantel_results/exp1/global/',
                    list.files('/home/sokui/soraida_r/mantel_results/exp1/global/',
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
saveRDS(new, "/home/sokui/soraida_r/mantel_results/exp1/global/exp1_global_mantel.rds")

##                 LOCAL MANTEL EXPERIMENT 2               ##

# read in all files into one object
files <- paste0('/home/sokui/soraida_r/mantel_results/exp2/local/',
                    list.files('/home/sokui/soraida_r/mantel_results/exp2/local/',
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
saveRDS(new, "/home/sokui/soraida_r/mantel_results/exp2/local/exp2_local_mantel.rds")

##                 LOCAL MANTEL EXPERIMENT 3               ##

# read in all files into one object
files <- paste0('/home/sokui/soraida_r/mantel_results/exp3/local/',
                    list.files('/home/sokui/soraida_r/mantel_results/exp3/local/',
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
saveRDS(new, "/home/sokui/soraida_r/mantel_results/exp3/local/exp3_local_mantel.rds")

##                 LOCAL MORAN EXPERIMENT 1                ##

# read in all files into one object
files <- paste0('/home/sokui/soraida_r/moran_results/exp1/local/',
                    list.files('/home/sokui/soraida_r/moran_results/exp1/local/',
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
saveRDS(new, "/home/sokui/soraida_r/moran_results/exp1/local/exp1_moran_local.rds")

##              GLOBAL MORAN EXPERIMENT 1              ##

# read in
files <- paste0('/home/sokui/soraida_r/moran_results/exp1/global/',
                    list.files('/home/sokui/soraida_r/moran_results/exp1/global/',
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
saveRDS(new, "/home/sokui/soraida_r/moran_results/exp1/global/exp1_moran_global.rds")

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

# plot single mantel files
setwd('~/mantel_files/50nurs_result/local_results/')
temp <- readRDS('local_1.rds')
plot(temp[[1]])
setwd('~/mantel_files/16nurs100_result/local_results/')
