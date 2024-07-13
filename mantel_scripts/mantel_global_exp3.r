## script for global mantel experiment 3
setwd("~/")
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
species_dists <- readRDS("~/mantel_files/exp3/result/sp_dist_exp3_1-60.rds")

# apply function
result <- mclapply(1:60, mantel_global, mc.cores = 15)

# save result
saveRDS(result, "~/mantel_files/exp3/result/global/global_1-60.rds")
message("finished 1 ", Sys.time())
q()