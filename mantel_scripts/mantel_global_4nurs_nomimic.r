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
species_dists <- readRDS("~/mantel_files/no_mimic_result/sp_dist_nomimic_1-30.rds")

# apply function
result <- mclapply(1:30, mantel_global, mc.cores = 15)

# save result
saveRDS(result, "~/mantel_files/no_mimic_result/global_results/global_1-30.rds")
message("finished 1 ", Sys.time())
q()