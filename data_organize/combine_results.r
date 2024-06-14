setwd('~/soraida_r/')
library(vegan) ## you must load vegan to read the results properly!
library(ggplot2)
library(gridExtra) ## to grid the plots
library(parallel)
library(gtools)

##                 LOCAL MANTEL NURSERIES               ##

# read in all files into one object
files <- paste0('~/soraida_r/mantel_results/four_nursery/local/',
                    list.files('~/soraida_r/mantel_results/four_nursery/local/',
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
saveRDS(new, "/home/sokui/soraida_r/mantel_results/four_nursery/local/local_mantel_nursery.rds")

##              GLOBAL MANTEL NURSERIES             ##

# read in
files <- paste0('/home/sokui/soraida_r/mantel_results/four_nursery/global/',
                    list.files('/home/sokui/soraida_r/mantel_results/four_nursery/global/',
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
saveRDS(new, "/home/sokui/soraida_r/mantel_results/four_nursery/global/global_mantel_nursery.rds")

##                 LOCAL MANTEL NO MIMIC               ##

# read in all files into one object
files <- paste0('/home/sokui/soraida_r/mantel_results/no_mimic/local/',
                    list.files('/home/sokui/soraida_r/mantel_results/no_mimic/local/',
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
saveRDS(new, "/home/sokui/soraida_r/mantel_results/no_mimic/local/local_mantel_nomimic.rds")

##                 LOCAL MANTEL NO MIMIC               ##

# read in all files into one object
files <- paste0('/home/sokui/soraida_r/mantel_results/8nurs/local/',
                    list.files('/home/sokui/soraida_r/mantel_results/8nurs/local/',
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
saveRDS(new, "/home/sokui/soraida_r/mantel_results/8nurs/local/local_mantel_8nurs.rds")

##                 LOCAL MORAN                ##

# read in all files into one object
files <- paste0('/home/sokui/soraida_r/moran_results/four_nursery/local/',
                    list.files('/home/sokui/soraida_r/moran_results/four_nursery/local/',
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
saveRDS(new, "/home/sokui/soraida_r/moran_results/four_nursery/local/local_moran_nursery.rds")

##              GLOBAL MORAN              ##

# read in
files <- paste0('/home/sokui/soraida_r/moran_results/four_nursery/global/',
                    list.files('/home/sokui/soraida_r/moran_results/four_nursery/global/',
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
saveRDS(new, "/home/sokui/soraida_r/moran_results/four_nursery/global/global_moran_nursery.rds")

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
