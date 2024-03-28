## script for global mantel analysis
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
    return(
        mantel(species_dists[[i]], patch_dists)
    )
}

# load in patch dists
patch_dists <- readRDS("~/mantel_files/patch_dists.rds")

## RUN 1
message("start 1 ", Sys.time())

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_1-40.rds")

# apply function
result <- mclapply(1:40, mantel_global, mc.cores = 40)

# save result
saveRDS(result, "~/mantel_files/global_results/global_1-40.rds")
Sys.sleep(1)
message("finished 1 ", Sys.time())

## RUN 2
message("start 2 ", Sys.time())

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_41-80.rds")

# apply function
result <- mclapply(1:40, mantel_global, mc.cores = 40)

# save result
saveRDS(result, "~/mantel_files/global_results/global_41-80.rds")
Sys.sleep(1)
message("finished 2 ", Sys.time())
