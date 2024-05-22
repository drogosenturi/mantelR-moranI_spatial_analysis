##              BEST LOCAL MANTEL WITH XY COORDS             ##
setwd("~/mantel_lab/nursery_files/")
#setwd("~/soraida_r/mantel_analysis/nursery_files/")
## Create function to load all packages
loadPackages <- function(packages) {
    lapply(c("data.table", "parallel",
             "tidyr", "dplyr", "vegan"),
             require, character.only = TRUE)
}
loadPackages()

# create a df containing all patch coordinates, make headers same
# and remove richness and block columns
df_patches <- fread("PatchRichnessEnd-101.csv")
colnames(df_patches)[1] <- "X"
colnames(df_patches)[2] <- "Y"
colnames(df_patches)[3] <- "patch.ID"
df_patches <- df_patches[,-c(4:5)]
head(df_patches)

# sort the patch list
df_patches <- df_patches[order(df_patches[["patch.ID"]]),]
df_patches <- df_patches[,-3]
head(df_patches)

# make break points
break_points <- seq(0, 30, by = 2)

# local mantel correlogram with vegan
mantel_vegan <- function(i) {
    result <- mantel.correlog(species_dists[[i]],
                              XY = df_patches,
                              break.pts = break_points,
                              cutoff = FALSE, nperm=0)
    return(
        result
    )
    gc()
}
## RUN 1
message("start 1 ", Sys.time())

# load in species_dists
species_dists <- readRDS("~/mantel_files/4nurs_result/sp_dist_nursery_1-40.rds")

# change to only first 15
species_dists <- species_dists[1:15]
gc()

v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/4nurs_result/local_results/local_1-15.rds")
Sys.sleep(10)
message("finished 1 ", Sys.time())

## RUN 2
message("start 2 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/4nurs_result/sp_dist_nursery_1-40.rds")

# load in next 15
species_dists <- species_dists[16:30]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/4nurs_result/local_results/local_16-30.rds")
Sys.sleep(10)
message("finished 2 ", Sys.time())

## RUN 3
message("start 3 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/4nurs_result/sp_dist_nursery_1-40.rds")

# load in next 15
species_dists <- species_dists[31:40]
gc()

# run mantel
v_result <- mclapply(1:10, mantel_vegan, mc.cores = 10)

# save as rds
saveRDS(v_result, "~/mantel_files/4nurs_result/local_results/local_31-40.rds")
Sys.sleep(10)
message("finished 3 ", Sys.time())

## RUN 4
message("start 4 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/4nurs_result/sp_dist_nursery_41-80.rds")

# load in next 15
species_dists <- species_dists[1:15]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/4nurs_result/local_results/local_41-55.rds")
Sys.sleep(10)
message("finished 3 ", Sys.time())

## RUN 5
message("start 5 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/4nurs_result/sp_dist_nursery_41-80.rds")

# load in next 15
species_dists <- species_dists[16:30]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/4nurs_result/local_results/local_56-70.rds")
Sys.sleep(10)
message("finished 4 ", Sys.time())

## RUN 6
message("start 6 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/4nurs_result/sp_dist_nursery_41-80.rds")

# load in next 15
species_dists <- species_dists[31:40]
gc()

# run mantel
v_result <- mclapply(1:10, mantel_vegan, mc.cores = 10)

# save as rds
saveRDS(v_result, "~/mantel_files/4nurs_result/local_results/local_71-80.rds")
Sys.sleep(10)
message("finished 6 ", Sys.time())

## RUN 7
message("start 7 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/4nurs_result/sp_dist_nursery_81-120.rds")

# load in next 15
species_dists <- species_dists[1:15]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/4nurs_result/local_results/local_81-95.rds")
Sys.sleep(10)
message("finished 5 ", Sys.time())

## RUN 8
message("start 8 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/4nurs_result/sp_dist_nursery_81-120.rds")

# load in next 15
species_dists <- species_dists[16:30]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/4nurs_result/local_results/local_96-110.rds")
Sys.sleep(10)
message("finished 6 ", Sys.time())

## RUN 9
message("start 2 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/4nurs_result/sp_dist_nursery_81-120.rds")

# load in next 15
species_dists <- species_dists[31:40]
gc()

# run mantel
v_result <- mclapply(1:10, mantel_vegan, mc.cores = 10)

# save as rds
saveRDS(v_result, "~/mantel_files/4nurs_result/local_results/local_111-120.rds")
Sys.sleep(10)
message("finished 9 ", Sys.time())

## RUN 10
message("start 10 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/4nurs_result/sp_dist_nursery_121-160.rds")

# load in next 15
species_dists <- species_dists[1:15]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/4nurs_result/local_results/local_121-135.rds")
Sys.sleep(10)
message("finished 10 ", Sys.time())

## RUN 11
message("start 11 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/4nurs_result/sp_dist_nursery_121-160.rds")

# load in next 15
species_dists <- species_dists[16:30]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/4nurs_result/local_results/local_136-150.rds")
Sys.sleep(10)
message("finished 11 ", Sys.time())

## RUN 12
message("start 12 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/4nurs_result/sp_dist_nursery_121-160.rds")

# load in next 15
species_dists <- species_dists[31:40]
gc()

# run mantel
v_result <- mclapply(1:10, mantel_vegan, mc.cores = 10)

# save as rds
saveRDS(v_result, "~/mantel_files/4nurs_result/local_results/local_151-160.rds")
Sys.sleep(10)
message("finished 12 ", Sys.time())

## RUN 13
message("start 13 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/4nurs_result/sp_dist_nursery_161-200.rds")

# load in next 15
species_dists <- species_dists[1:15]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/4nurs_result/local_results/local_161-175.rds")
Sys.sleep(10)
message("finished 13 ", Sys.time())

## RUN 14
message("start 14 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/4nurs_result/sp_dist_nursery_161-200.rds")

# load in next 15
species_dists <- species_dists[16:30]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/4nurs_result/local_results/local_176-190.rds")
Sys.sleep(10)
message("finished 14 ", Sys.time())

## RUN 15
message("start 15 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/4nurs_result/sp_dist_nursery_161-200.rds")

# load in next 15
species_dists <- species_dists[31:40]
gc()

# run mantel
v_result <- mclapply(1:10, mantel_vegan, mc.cores = 10)

# save as rds
saveRDS(v_result, "~/mantel_files/4nurs_result/local_results/local_191-200.rds")
Sys.sleep(10)
message("finished 15 ", Sys.time())

## RUN 16
message("start 16 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/4nurs_result/sp_dist_nursery_201-240.rds")

# load in next 15
species_dists <- species_dists[1:15]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/4nurs_result/local_results/local_201-215.rds")
Sys.sleep(10)
message("finished 16 ", Sys.time())

## RUN 17
message("start 17 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/4nurs_result/sp_dist_nursery_201-240.rds")

# load in next 15
species_dists <- species_dists[16:30]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/4nurs_result/local_results/local_216-230.rds")
Sys.sleep(10)
message("finished 17 ", Sys.time())

## RUN 18
message("start 18 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/4nurs_result/sp_dist_nursery_201-240.rds")

# load in next 15
species_dists <- species_dists[31:40]
gc()

# run mantel
v_result <- mclapply(1:10, mantel_vegan, mc.cores = 10)

# save as rds
saveRDS(v_result, "~/mantel_files/4nurs_result/local_results/local_231-240.rds")
Sys.sleep(10)
message("finished 18 ", Sys.time())
q()