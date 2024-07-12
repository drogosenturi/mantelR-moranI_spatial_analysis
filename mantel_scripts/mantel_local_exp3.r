##              Mantel local for experiment 3          ##
setwd("~/mantel_files/exp3/runs/")
#setwd("~/soraida_r/mantel_analysis/nursery_files/")
## Create function to load all packages
loadPackages <- function(packages) {
    lapply(c("data.table", "parallel",
             "tidyr", "dplyr", "vegan"),
             require, character.only = TRUE)
}
loadPackages()

# load in patch dists
patch_dists <- readRDS("~/mantel_files/patch_dists.rds")

# make break points
break_points <- seq(0, 30, by = 2)

# local mantel correlogram with vegan
mantel_vegan <- function(i) {
    result <- mantel.correlog(species_dists[[i]],
                              D.geo = patch_dists,
                              break.pts = break_points,
                              cutoff = FALSE, nperm=100)
    return(
        result
    )
    gc()
}
## RUN 1
message("start 1 ", Sys.time())

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp3/result/sp_dist_exp3_1-60.rds")

# change to only first 15
species_dists <- species_dists[1:15]
gc()

v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/exp3/result/local/local_1-15.rds")
Sys.sleep(10)
message("finished 1 ", Sys.time())

## RUN 2
message("start 2 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp3/result/sp_dist_exp3_1-60.rds")

# load in next 15
species_dists <- species_dists[16:30]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/exp3/result/local/local_16-30.rds")
message("finished 2 ", Sys.time())

## RUN 3
message("start 3 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp3/result/sp_dist_exp3_1-60.rds")

# load in next 15
species_dists <- species_dists[31:45]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/exp3/result/local/local_31-45.rds")
message("finished 3 ", Sys.time())

## RUN 4
message("start 4 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp3/result/sp_dist_exp3_1-60.rds")

# load in next 15
species_dists <- species_dists[46:60]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/exp3/result/local/local_46-60.rds")
message("finished 4 ", Sys.time())
message("all done", Sys.time())
q()
