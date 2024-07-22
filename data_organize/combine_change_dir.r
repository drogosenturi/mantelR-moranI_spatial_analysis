setwd('~/soraida_r/')
library(vegan) ## you must load vegan to read the results properly!
library(ggplot2)
library(gridExtra) ## to grid the plots
library(parallel)
library(gtools)

##                 LOCAL MANTEL EXPERIMENT 1               ##

# read in all files into one object
files <- paste0('~/soraida_r/mantel_results/exp6/local/',
                    list.files('~/soraida_r/mantel_results/exp6/local/',
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
saveRDS(new, "/home/sokui/soraida_r/mantel_results/exp6/local/exp6_mantel_local.rds")
rm(list = c("new", "files", "i", "extracted"))

##              GLOBAL MANTEL EXPERIMENT 1             ##

# read in
files <- paste0('/home/sokui/soraida_r/mantel_results/exp6/global/',
                    list.files('/home/sokui/soraida_r/mantel_results/exp6/global/',
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
saveRDS(new, "/home/sokui/soraida_r/mantel_results/exp6/global/exp6_global_mantel.rds")
rm(list = c("new", "files", "i", "extracted"))

##                 LOCAL MORAN EXPERIMENT 1                ##

# read in all files into one object
files <- paste0('/home/sokui/soraida_r/moran_results/exp6/local/',
                    list.files('/home/sokui/soraida_r/moran_results/exp6/local/',
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
saveRDS(new, "/home/sokui/soraida_r/moran_results/exp6/local/exp6_moran_local.rds")
rm(list = c("new", "files", "i", "extracted"))

##              GLOBAL MORAN EXPERIMENT 1              ##

# read in
files <- paste0('/home/sokui/soraida_r/moran_results/exp6/global/',
                    list.files('/home/sokui/soraida_r/moran_results/exp6/global/',
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
saveRDS(new, "/home/sokui/soraida_r/moran_results/exp6/global/exp6_moran_global.rds")