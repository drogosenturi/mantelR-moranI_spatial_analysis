##              Mantel local for experiment 2          ##
setwd("~/mantel_lab/exp2/runs/")
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
df_patches <- fread("PatchRichnessEnd-1.csv")
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
                              cutoff = FALSE, nperm=100)
    return(
        result
    )
    gc()
}
## RUN 1
message("start 1 ", Sys.time())

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_1-40.rds")

# change to only first 15
species_dists <- species_dists[1:15]
gc()

v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_1-15.rds")
Sys.sleep(10)
message("finished 1 ", Sys.time())

## RUN 2
message("start 2 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_1-40.rds")

# load in next 15
species_dists <- species_dists[16:30]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_16-30.rds")
Sys.sleep(10)
message("finished 2 ", Sys.time())

## RUN 3
message("start 3 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_1-40.rds")

# load in next 15
species_dists <- species_dists[31:40]
gc()

# run mantel
v_result <- mclapply(1:10, mantel_vegan, mc.cores = 10)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_31-40.rds")
Sys.sleep(10)
message("finished 3 ", Sys.time())

## RUN 4
message("start 4 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_41-80.rds")

# load in next 15
species_dists <- species_dists[1:15]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_41-55.rds")
Sys.sleep(10)
message("finished 3 ", Sys.time())

## RUN 5
message("start 5 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_41-80.rds")

# load in next 15
species_dists <- species_dists[16:30]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_56-70.rds")
Sys.sleep(10)
message("finished 4 ", Sys.time())

## RUN 6
message("start 6 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_41-80.rds")

# load in next 15
species_dists <- species_dists[31:40]
gc()

# run mantel
v_result <- mclapply(1:10, mantel_vegan, mc.cores = 10)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_71-80.rds")
Sys.sleep(10)
message("finished 6 ", Sys.time())

## RUN 7
message("start 7 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_81-120.rds")

# load in next 15
species_dists <- species_dists[1:15]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_81-95.rds")
Sys.sleep(10)
message("finished 5 ", Sys.time())

## RUN 8
message("start 8 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_81-120.rds")

# load in next 15
species_dists <- species_dists[16:30]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_96-110.rds")
Sys.sleep(10)
message("finished 6 ", Sys.time())

## RUN 9
message("start 2 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_81-120.rds")

# load in next 15
species_dists <- species_dists[31:40]
gc()

# run mantel
v_result <- mclapply(1:10, mantel_vegan, mc.cores = 10)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_111-120.rds")
Sys.sleep(10)
message("finished 9 ", Sys.time())

## RUN 10
message("start 10 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_121-160.rds")

# load in next 15
species_dists <- species_dists[1:15]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_121-135.rds")
Sys.sleep(10)
message("finished 10 ", Sys.time())

## RUN 11
message("start 11 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_121-160.rds")

# load in next 15
species_dists <- species_dists[16:30]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_136-150.rds")
Sys.sleep(10)
message("finished 11 ", Sys.time())

## RUN 12
message("start 12 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_121-160.rds")

# load in next 15
species_dists <- species_dists[31:40]
gc()

# run mantel
v_result <- mclapply(1:10, mantel_vegan, mc.cores = 10)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_151-160.rds")
Sys.sleep(10)
message("finished 12 ", Sys.time())

## RUN 13
message("start 13 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_161-200.rds")

# load in next 15
species_dists <- species_dists[1:15]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_161-175.rds")
Sys.sleep(10)
message("finished 13 ", Sys.time())

## RUN 14
message("start 14 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_161-200.rds")

# load in next 15
species_dists <- species_dists[16:30]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_176-190.rds")
Sys.sleep(10)
message("finished 14 ", Sys.time())

## RUN 15
message("start 15 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_161-200.rds")

# load in next 15
species_dists <- species_dists[31:40]
gc()

# run mantel
v_result <- mclapply(1:10, mantel_vegan, mc.cores = 10)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_191-200.rds")
Sys.sleep(10)
message("finished 15 ", Sys.time())

## RUN 16
message("start 16 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_201-240.rds")

# load in next 15
species_dists <- species_dists[1:15]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_201-215.rds")
Sys.sleep(10)
message("finished 16 ", Sys.time())

## RUN 17
message("start 17 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_201-240.rds")

# load in next 15
species_dists <- species_dists[16:30]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_216-230.rds")
Sys.sleep(10)
message("finished 17 ", Sys.time())

## RUN 18
message("start 18 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_201-240.rds")

# load in next 15
species_dists <- species_dists[31:40]
gc()

# run mantel
v_result <- mclapply(1:10, mantel_vegan, mc.cores = 10)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_231-240.rds")
Sys.sleep(10)
message("finished 18 ", Sys.time())

## RUN 19
message("start 19 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_241-280.rds")

# load in next 15
species_dists <- species_dists[1:15]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_241-255.rds")
Sys.sleep(10)
message("finished 19 ", Sys.time())

## RUN 20
message("start 20 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_241-280.rds")

# load in next 15
species_dists <- species_dists[16:30]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_256-270.rds")
Sys.sleep(10)
message("finished 20 ", Sys.time())

## RUN 21
message("start 21 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_241-280.rds")

# load in next 15
species_dists <- species_dists[31:40]
gc()

# run mantel
v_result <- mclapply(1:10, mantel_vegan, mc.cores = 10)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_271-280.rds")
Sys.sleep(10)
message("finished 21 ", Sys.time())

## RUN 22
message("start 22 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_281-320.rds")

# load in next 15
species_dists <- species_dists[1:15]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_281-295.rds")
Sys.sleep(10)
message("finished 22 ", Sys.time())

## RUN 23
message("start 23 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_281-320.rds")

# load in next 15
species_dists <- species_dists[16:30]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_296-310.rds")
Sys.sleep(10)
message("finished 23 ", Sys.time())

## RUN 24
message("start 24 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_281-320.rds")

# load in next 15
species_dists <- species_dists[31:40]
gc()

# run mantel
v_result <- mclapply(1:10, mantel_vegan, mc.cores = 10)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_311-320.rds")
Sys.sleep(10)
message("finished 24 ", Sys.time())

## RUN 25
message("start 25 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_321-360.rds")

# load in next 15
species_dists <- species_dists[1:15]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_321-335.rds")
Sys.sleep(10)
message("finished 25 ", Sys.time())

## RUN 26
message("start 26 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_321-360.rds")

# load in next 15
species_dists <- species_dists[16:30]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_336-350.rds")
Sys.sleep(10)
message("finished 26 ", Sys.time())

## RUN 27
message("start 27 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_321-360.rds")

# load in next 15
species_dists <- species_dists[31:40]
gc()

# run mantel
v_result <- mclapply(1:10, mantel_vegan, mc.cores = 10)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_351-360.rds")
Sys.sleep(10)
message("finished 27 ", Sys.time())

## RUN 28
message("start 28 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_361-400.rds")

# load in next 15
species_dists <- species_dists[1:15]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_361-375.rds")
Sys.sleep(10)
message("finished 28 ", Sys.time())

## RUN 29
message("start 29 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_361-400.rds")

# load in next 15
species_dists <- species_dists[16:30]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_376-390.rds")
Sys.sleep(10)
message("finished 20 ", Sys.time())

## RUN 30
message("start 30 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_361-400.rds")

# load in next 15
species_dists <- species_dists[31:40]
gc()

# run mantel
v_result <- mclapply(1:10, mantel_vegan, mc.cores = 10)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_391-400.rds")
Sys.sleep(10)
message("finished 30 ", Sys.time())

## RUN 31
message("start 31 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_401-440.rds")

# load in next 15
species_dists <- species_dists[1:15]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_401-415.rds")
Sys.sleep(10)
message("finished 31 ", Sys.time())

## RUN 32
message("start 32 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_401-440.rds")

# load in next 15
species_dists <- species_dists[16:30]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_416-430.rds")
Sys.sleep(10)
message("finished 32 ", Sys.time())

## RUN 33
message("start 33 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_401-440.rds")

# load in next 15
species_dists <- species_dists[31:40]
gc()

# run mantel
v_result <- mclapply(1:10, mantel_vegan, mc.cores = 10)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_431-440.rds")
Sys.sleep(10)
message("finished 33 ", Sys.time())

## RUN 34
message("start 34 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_441-480.rds")

# load in next 15
species_dists <- species_dists[1:15]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_441-455.rds")
Sys.sleep(10)
message("finished 34 ", Sys.time())

## RUN 35
message("start 35 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_441-480.rds")

# load in next 15
species_dists <- species_dists[16:30]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_456-470.rds")
Sys.sleep(10)
message("finished 35 ", Sys.time())

## RUN 36
message("start 36 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/mantel_files/exp2/result/sp_dist_exp2_441-480.rds")

# load in next 15
species_dists <- species_dists[31:40]
gc()

# run mantel
v_result <- mclapply(1:10, mantel_vegan, mc.cores = 10)

# save as rds
saveRDS(v_result, "~/mantel_files/exp2/result/local/local_471-480.rds")
Sys.sleep(10)
message("finished 36 ", Sys.time())

## RUN 37
message("start 37 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

message("finished", Sys.time())
q()
