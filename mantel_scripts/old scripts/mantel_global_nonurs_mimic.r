## script for global mantel analysis
setwd("~/mantel_files/")
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
patch_dists <- readRDS("patch_dists.rds")
Sys.sleep(10)

## RUN 1
message("start 1 ", Sys.time())

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_1-40.rds")

# apply function
result <- mclapply(1:40, mantel_global, mc.cores = 15)

# save result
saveRDS(result, "~/mantel_files/global_results/global_1-40.rds")
Sys.sleep(10)
message("finished 1 ", Sys.time())

## RUN 2
message("start 2 ", Sys.time())
rm(list = c('species_dists', 'result'))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_41-80.rds")

# apply function
result <- mclapply(1:40, mantel_global, mc.cores = 15)

# save result
saveRDS(result, "~/mantel_files/global_results/global_41-80.rds")
Sys.sleep(10)
message("finished 2 ", Sys.time())

## RUN 3
message("start 3 ", Sys.time())
rm(list = c('species_dists', 'result'))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_81-120.rds")

# apply function
result <- mclapply(1:40, mantel_global, mc.cores = 15)

# save result
saveRDS(result, "~/mantel_files/global_results/global_81-120.rds")
Sys.sleep(10)
message("finished 3 ", Sys.time())

## RUN 4
message("start 4 ", Sys.time())
rm(list = c('species_dists', 'result'))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_121-160.rds")

# apply function
result <- mclapply(1:40, mantel_global, mc.cores = 15)

# save result
saveRDS(result, "~/mantel_files/global_results/global_121-160.rds")
Sys.sleep(10)
message("finished 4 ", Sys.time())

## RUN 5
message("start 5 ", Sys.time())
rm(list = c('species_dists', 'result'))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_161-200.rds")

# apply function
result <- mclapply(1:40, mantel_global, mc.cores = 15)

# save result
saveRDS(result, "~/mantel_files/global_results/global_161-200.rds")
Sys.sleep(10)
message("finished 5 ", Sys.time())

## RUN 6
message("start 6 ", Sys.time())
rm(list = c('species_dists', 'result'))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_201-240.rds")
Sys.sleep(10)

# apply function
result <- mclapply(1:40, mantel_global, mc.cores = 15)

# save result
saveRDS(result, "~/mantel_files/global_results/global_201-240.rds")
Sys.sleep(10)
message("finished 6 ", Sys.time())

## RUN 7
message("start 7 ", Sys.time())
rm(list = c('species_dists', 'result'))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_241-280.rds")
Sys.sleep(10)

# apply function
result <- mclapply(1:40, mantel_global, mc.cores = 15)

# save result
saveRDS(result, "~/mantel_files/global_results/global_241-280.rds")
Sys.sleep(10)
message("finished 7 ", Sys.time())

## RUN 8
message("start 8 ", Sys.time())
rm(list = c('species_dists', 'result'))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_281-320.rds")

# apply function
result <- mclapply(1:40, mantel_global, mc.cores = 15)

# save result
saveRDS(result, "~/mantel_files/global_results/global_281-320.rds")
Sys.sleep(10)
message("finished 8 ", Sys.time())

## RUN 9
message("start 9 ", Sys.time())
rm(list = c('species_dists', 'result'))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_321-360.rds")

# apply function
result <- mclapply(1:40, mantel_global, mc.cores = 15)

# save result
saveRDS(result, "~/mantel_files/global_results/global_321-360.rds")
Sys.sleep(10)
message("finished 9 ", Sys.time())

## RUN 10
message("start 10 ", Sys.time())
rm(list = c('species_dists', 'result'))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_361-400.rds")

# apply function
result <- mclapply(1:40, mantel_global, mc.cores = 15)

# save result
saveRDS(result, "~/mantel_files/global_results/global_361-400.rds")
Sys.sleep(10)
message("finished 10 ", Sys.time())

## RUN 11
message("start 11 ", Sys.time())
rm(list = c('species_dists', 'result'))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_401-440.rds")

# apply function
result <- mclapply(1:40, mantel_global, mc.cores = 15)

# save result
saveRDS(result, "~/mantel_files/global_results/global_401-440.rds")
Sys.sleep(10)
message("finished 11 ", Sys.time())

## RUN 12
message("start 12 ", Sys.time())
rm(list = c('species_dists', 'result'))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_441-480.rds")

# apply function
result <- mclapply(1:40, mantel_global, mc.cores = 15)

# save result
saveRDS(result, "~/mantel_files/global_results/global_441-480.rds")
Sys.sleep(10)
message("finished 12 ", Sys.time())

## RUN 13
message("start 13 ", Sys.time())
rm(list = c('species_dists', 'result'))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_481-500.rds")

# apply function
result <- mclapply(1:20, mantel_global, mc.cores = 10)

# save result
saveRDS(result, "~/mantel_files/global_results/global_481-500.rds")
Sys.sleep(10)
message("finished 13 ", Sys.time())
