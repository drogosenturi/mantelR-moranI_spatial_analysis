##              BEST LOCAL MANTEL WITH XY COORDS             ##
message("start 1 ", Sys.time())
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
colnames(df_patches)[1] <- "P.xcor"
colnames(df_patches)[2] <- "P.ycor"
df_patches <- df_patches[,-c(3:5)]
head(df_patches)

# change df_patches headers to X and Y
colnames(df_patches)[1] <- "X"
colnames(df_patches)[2] <- "Y"
#head(df_patches) # quick check

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_1-40.rds")

# change to only first 15
species_dists <- species_dists[1:20]
gc()

# make break points
break_points <- seq(0, 30, by = 2)

# local mantel correlogram with vegan
mantel_vegan <- function(i) {
    result <- mantel.correlog(species_dists[[i]],
                              XY = df_patches,
                              break.pts = break_points,
                              cutoff = FALSE, nperm=100)
    return(
        result
    )
    gc()
}
v_result <- mclapply(1:20, mantel_vegan, mc.cores = 20)

# save as rds
saveRDS(v_result, "~/mantel_files/local_results/local_1-20.rds")
message("finished 1 ", Sys.time())

## RUN 2
message("start 2 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_1-40.rds")

# load in next 15
species_dists <- species_dists[21:40]
gc()

# run mantel
v_result <- mclapply(1:20, mantel_vegan, mc.cores = 20)

# save as rds
saveRDS(v_result, "~/mantel_files/local_results/local_21-40.rds")
message("finished 2 ", Sys.time())

## RUN 3
message("start 3 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_41-80.rds")

# load in next 15
species_dists <- species_dists[1:20]
gc()

# run mantel
v_result <- mclapply(1:20, mantel_vegan, mc.cores = 20)

# save as rds
saveRDS(v_result, "~/mantel_files/local_results/local_41-60.rds")
message("finished 3 ", Sys.time())

## RUN 4
message("start 4 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_41-80.rds")

# load in next 15
species_dists <- species_dists[21:40]
gc()

# run mantel
v_result <- mclapply(1:20, mantel_vegan, mc.cores = 20)

# save as rds
saveRDS(v_result, "~/mantel_files/local_results/local_61-80.rds")
message("finished 4 ", Sys.time())

## RUN 5
message("start 5 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_81-120.rds")

# load in next 15
species_dists <- species_dists[1:20]
gc()

# run mantel
v_result <- mclapply(1:20, mantel_vegan, mc.cores = 20)

# save as rds
saveRDS(v_result, "~/mantel_files/local_results/local_81-100.rds")
message("finished 5 ", Sys.time())

## RUN 6
message("start 6 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_81-120.rds")

# load in next 15
species_dists <- species_dists[21:40]
gc()

# run mantel
v_result <- mclapply(1:20, mantel_vegan, mc.cores = 20)

# save as rds
saveRDS(v_result, "~/mantel_files/local_results/local_101-120.rds")
message("finished 6 ", Sys.time())

## RUN 7
message("start 7 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_121-160.rds")

# load in next 15
species_dists <- species_dists[1:20]
gc()

# run mantel
v_result <- mclapply(1:20, mantel_vegan, mc.cores = 20)

# save as rds
saveRDS(v_result, "~/mantel_files/local_results/local_121-140.rds")
message("finished 7 ", Sys.time())

## RUN 8
message("start 8 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_121-160.rds")

# load in next 15
species_dists <- species_dists[21:40]
gc()

# run mantel
v_result <- mclapply(1:20, mantel_vegan, mc.cores = 20)

# save as rds
saveRDS(v_result, "~/mantel_files/local_results/local_141-160.rds")
message("finished 8 ", Sys.time())

## RUN 9
message("start 3 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_161-200.rds")

# load in next 15
species_dists <- species_dists[1:20]
gc()

# run mantel
v_result <- mclapply(1:20, mantel_vegan, mc.cores = 20)

# save as rds
saveRDS(v_result, "~/mantel_files/local_results/local_161-180.rds")
message("finished 9 ", Sys.time())

## RUN 10
message("start 10 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_161-200.rds")

# load in next 15
species_dists <- species_dists[21:40]
gc()

# run mantel
v_result <- mclapply(1:20, mantel_vegan, mc.cores = 20)

# save as rds
saveRDS(v_result, "~/mantel_files/local_results/local_181-200.rds")
message("finished 10 ", Sys.time())

## RUN 11
message("start 11 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_201-240.rds")

# load in next 15
species_dists <- species_dists[1:20]
gc()

# run mantel
v_result <- mclapply(1:20, mantel_vegan, mc.cores = 20)

# save as rds
saveRDS(v_result, "~/mantel_files/local_results/local_201-220.rds")
message("finished 11 ", Sys.time())

## RUN 12
message("start 12 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_201-240.rds")

# load in next 15
species_dists <- species_dists[21:40]
gc()

# run mantel
v_result <- mclapply(1:20, mantel_vegan, mc.cores = 20)

# save as rds
saveRDS(v_result, "~/mantel_files/local_results/local_221-240.rds")
message("finished 12 ", Sys.time())

## RUN 13
message("start 13 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_241-280.rds")

# load in next 15
species_dists <- species_dists[1:20]
gc()

# run mantel
v_result <- mclapply(1:20, mantel_vegan, mc.cores = 20)

# save as rds
saveRDS(v_result, "~/mantel_files/local_results/local_241-260.rds")
message("finished 13 ", Sys.time())

## RUN 14
message("start 14 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_241-280.rds")

# load in next 15
species_dists <- species_dists[21:40]
gc()

# run mantel
v_result <- mclapply(1:20, mantel_vegan, mc.cores = 20)

# save as rds
saveRDS(v_result, "~/mantel_files/local_results/local_261-280.rds")
message("finished 14 ", Sys.time())

## RUN 15
message("start 15 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_281-320.rds")

# load in next 15
species_dists <- species_dists[1:20]
gc()

# run mantel
v_result <- mclapply(1:20, mantel_vegan, mc.cores = 20)

# save as rds
saveRDS(v_result, "~/mantel_files/local_results/local_281-300.rds")
message("finished 15 ", Sys.time())

## RUN 16
message("start 16 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_281-320.rds")

# load in next 15
species_dists <- species_dists[21:40]
gc()

# run mantel
v_result <- mclapply(1:20, mantel_vegan, mc.cores = 20)

# save as rds
saveRDS(v_result, "~/mantel_files/local_results/local_301-320.rds")
message("finished 16 ", Sys.time())

## RUN 17
message("start 17 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_321-360.rds")

# load in next 15
species_dists <- species_dists[1:20]
gc()

# run mantel
v_result <- mclapply(1:20, mantel_vegan, mc.cores = 20)

# save as rds
saveRDS(v_result, "~/mantel_files/local_results/local_321-340.rds")
message("finished 17 ", Sys.time())

## RUN 18
message("start 18 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_321-360.rds")

# load in next 15
species_dists <- species_dists[21:40]
gc()

# run mantel
v_result <- mclapply(1:20, mantel_vegan, mc.cores = 20)

# save as rds
saveRDS(v_result, "~/mantel_files/local_results/local_341-360.rds")
message("finished 18 ", Sys.time())

## RUN 19
message("start 19 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_361-400.rds")

# load in next 15
species_dists <- species_dists[1:20]
gc()

# run mantel
v_result <- mclapply(1:20, mantel_vegan, mc.cores = 20)

# save as rds
saveRDS(v_result, "~/mantel_files/local_results/local_361-380.rds")
message("finished 19 ", Sys.time())

## RUN 20
message("start 20 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_361-400.rds")

# load in next 15
species_dists <- species_dists[21:40]
gc()

# run mantel
v_result <- mclapply(1:20, mantel_vegan, mc.cores = 20)

# save as rds
saveRDS(v_result, "~/mantel_files/local_results/local_381-400.rds")
message("finished 20 ", Sys.time())

## RUN 21
message("start 21 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_401-440.rds")

# load in next 15
species_dists <- species_dists[1:20]
gc()

# run mantel
v_result <- mclapply(1:20, mantel_vegan, mc.cores = 20)

# save as rds
saveRDS(v_result, "~/mantel_files/local_results/local_401-420.rds")
message("finished 21 ", Sys.time())

## RUN 22
message("start 22 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_401-440.rds")

# load in next 15
species_dists <- species_dists[21:40]
gc()

# run mantel
v_result <- mclapply(1:20, mantel_vegan, mc.cores = 20)

# save as rds
saveRDS(v_result, "~/mantel_files/local_results/local_421-440.rds")
message("finished 22 ", Sys.time())

## RUN 23
message("start 23 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_441-480.rds")

# load in next 15
species_dists <- species_dists[1:20]
gc()

# run mantel
v_result <- mclapply(1:20, mantel_vegan, mc.cores = 20)

# save as rds
saveRDS(v_result, "~/mantel_files/local_results/local_441-460.rds")
message("finished 23 ", Sys.time())

## RUN 24
message("start 24 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_441-480.rds")

# load in next 15
species_dists <- species_dists[21:40]
gc()

# run mantel
v_result <- mclapply(1:20, mantel_vegan, mc.cores = 20)

# save as rds
saveRDS(v_result, "~/mantel_files/local_results/local_461-480.rds")
message("finished 24 ", Sys.time())

## RUN 25
message("start 25 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/sp_dist_mimicry_481-500.rds")

# load in next 15
species_dists <- species_dists[1:20]
gc()

# run mantel
v_result <- mclapply(1:20, mantel_vegan, mc.cores = 20)

# save as rds
saveRDS(v_result, "~/mantel_files/local_results/local_481-500.rds")
message("finished 24 ", Sys.time())
q()