## script for global mantel analysis for 4 nurseries
setwd("~/mantel_lab/")
#setwd("~/soraida_r/mantel_analysis/nursery_files/")

# load in packages
loadPackages <- function(packages) {
    lapply(c("vegan", "parallel"),
             require, character.only = TRUE)
}
loadPackages()

# define function for global analysis
mantel_global <- function(i) {
    result <- mantel(species_dists[[i]], patch_dists)
    return(
        result
    )
    gc()
}

# load in patch dists
patch_dists <- readRDS("~/mantel_files/patch_dists.rds")
Sys.sleep(10)

## RUN 1
message("start 1 ", Sys.time())

# load in species_dists
species_dists <- readRDS("~/mantel_files/4nurs_result/sp_dist_nursery_1-40.rds")

# apply function
result <- mclapply(1:40, mantel_global, mc.cores = 15)

# save result
saveRDS(result, "~/mantel_files/4nurs_result/global_results/global_1-40.rds")
Sys.sleep(10)
message("finished 1 ", Sys.time())

## RUN 2
message("start 2 ", Sys.time())
rm(list = c('species_dists', 'result'))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/4nurs_result/sp_dist_nursery_41-80.rds")

# apply function
result <- mclapply(1:40, mantel_global, mc.cores = 15)

# save result
saveRDS(result, "~/mantel_files/4nurs_result/global_results/global_41-80.rds")
Sys.sleep(10)
message("finished 2 ", Sys.time())

## RUN 3
message("start 3 ", Sys.time())
rm(list = c('species_dists', 'result'))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/4nurs_result/sp_dist_nursery_81-120.rds")

# apply function
result <- mclapply(1:40, mantel_global, mc.cores = 15)

# save result
saveRDS(result, "~/mantel_files/4nurs_result/global_results/global_81-120.rds")
Sys.sleep(10)
message("finished 3 ", Sys.time())

## RUN 4
message("start 4 ", Sys.time())
rm(list = c('species_dists', 'result'))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/4nurs_result/sp_dist_nursery_121-160.rds")

# apply function
result <- mclapply(1:40, mantel_global, mc.cores = 15)

# save result
saveRDS(result, "~/mantel_files/4nurs_result/global_results/global_121-160.rds")
Sys.sleep(10)
message("finished 4 ", Sys.time())

## RUN 5
message("start 5 ", Sys.time())
rm(list = c('species_dists', 'result'))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/4nurs_result/sp_dist_nursery_161-200.rds")

# apply function
result <- mclapply(1:40, mantel_global, mc.cores = 15)

# save result
saveRDS(result, "~/mantel_files/4nurs_result/global_results/global_161-200.rds")
Sys.sleep(10)
message("finished 5 ", Sys.time())

## RUN 6
message("start 6 ", Sys.time())
rm(list = c('species_dists', 'result'))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/4nurs_result/sp_dist_nursery_201-240.rds")
Sys.sleep(10)

# apply function
result <- mclapply(1:40, mantel_global, mc.cores = 15)

# save result
saveRDS(result, "~/mantel_files/4nurs_result/global_results/global_201-240.rds")
message("finished 6 ", Sys.time())
q()