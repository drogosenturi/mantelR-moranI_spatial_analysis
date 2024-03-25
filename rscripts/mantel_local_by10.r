##              BEST LOCAL MANTEL WITH XY COORDS             ##
message("start 1 ", Sys.time())
setwd("~/mantel_lab/nursery_files/")
#setwd("~/soraida_r/mantel_analysis/nursery_files/")
## Create function to load all packages
loadPackages <- function(packages) {
    lapply(c("data.table", "parallel", "ecodist",
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
species_dists <- readRDS("~/mantel_lab/sp_dist_mimicry_500.rds")

# change to only first 15
species_dists <- species_dists[1:15]
gc()

# make break points
break_points <- seq(0, 30, by = 2)

# local mantel correlogram with vegan
mantel_vegan <- function(i) {
    result <- mantel.correlog(species_dists[[i]],
                              XY = df_patches,
                              break.pts = break_points,
                              cutoff = FALSE, nperm=1)
    return(
        result
    )
}
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_1-15.rds")
message("finished 1 ", Sys.time())

## RUN 2
message("start 2 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[16:30]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_16-30.rds")
message("finished 2 ", Sys.time())

## RUN 3
message("start 3 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[31:45]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_31-45.rds")
message("finished 3 ", Sys.time())

## RUN 4
message("start 4 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[46:60]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_46-60.rds")
message("finished 4 ", Sys.time())

## RUN 5
message("start 5 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[61:75]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_61-75.rds")
message("finished 5 ", Sys.time())

## RUN 6
message("start 6 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[76:90]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_76-90.rds")
message("finished 6 ", Sys.time())

## RUN 7
message("start 7 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[91:105]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_91-105.rds")
message("finished 7 ", Sys.time())

## RUN 8
message("start 8 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[106:120]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_106-120.rds")
message("finished 8 ", Sys.time())

## RUN 9
message("start 3 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[121:135]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_121-135.rds")
message("finished 9 ", Sys.time())

## RUN 10
message("start 10 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[136:150]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_136-150.rds")
message("finished 10 ", Sys.time())

## RUN 11
message("start 11 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[151:165]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_151-165.rds")
message("finished 11 ", Sys.time())

## RUN 12
message("start 12 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[166:180]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_166-180.rds")
message("finished 12 ", Sys.time())

## RUN 13
message("start 13 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[181:195]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_181-195.rds")
message("finished 13 ", Sys.time())

## RUN 14
message("start 14 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[196:210]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_196-210.rds")
message("finished 14 ", Sys.time())

## RUN 15
message("start 15 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[211:225]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_211-225.rds")
message("finished 15 ", Sys.time())

## RUN 16
message("start 16 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[226:240]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_16-30.rds")
message("finished 16 ", Sys.time())

## RUN 17
message("start 17 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[241:255]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_241-255.rds")
message("finished 17 ", Sys.time())

## RUN 18
message("start 18 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[256:270]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_256-270.rds")
message("finished 18 ", Sys.time())

## RUN 19
message("start 19 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[271:285]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_271-285.rds")
message("finished 19 ", Sys.time())

## RUN 20
message("start 20 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[286:300]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_286-300.rds")
message("finished 20 ", Sys.time())

## RUN 21
message("start 21 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[301:315]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_301-315.rds")
message("finished 21 ", Sys.time())

## RUN 22
message("start 22 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[316:330]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_316-330.rds")
message("finished 22 ", Sys.time())

## RUN 23
message("start 23 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[331:345]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_331-345.rds")
message("finished 23 ", Sys.time())

## RUN 24
message("start 24 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[346:360]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_346-360.rds")
message("finished 24 ", Sys.time())

## RUN 24
message("start 25 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[361:375]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_361-375.rds")
message("finished 24 ", Sys.time())

## RUN 25
message("start 25 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[376:390]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_376-390.rds")
message("finished 25 ", Sys.time())

## RUN 26
message("start 26 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[391:405]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_391-405.rds")
message("finished 26 ", Sys.time())

## RUN 27
message("start 27 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[406:420]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_406-420.rds")
message("finished 27 ", Sys.time())

## RUN 28
message("start 28 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[421:435]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_421-435.rds")
message("finished 28 ", Sys.time())

## RUN 29
message("start 29 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[436:450]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_436-450.rds")
message("finished 29 ", Sys.time())

## RUN 30
message("start 30 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[451:465]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_451-465.rds")
message("finished 30 ", Sys.time())

## RUN 31
message("start 31 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[466:480]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_466-480.rds")
message("finished 31 ", Sys.time())

## RUN 32
message("start 32 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[481:495]
gc()

# run mantel
v_result <- mclapply(1:15, mantel_vegan, mc.cores = 15)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_481-495.rds")
message("finished 32 ", Sys.time())

## RUN 33
message("start 33 ", Sys.time())
rm(list = c("v_result", "species_dists"))
gc()

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# load in next 15
species_dists <- species_dists[495:500]
gc()

# run mantel
v_result <- mclapply(1:5, mantel_vegan, mc.cores = 5)

# save as rds
saveRDS(v_result, "~/mantel_lab/local_results/local_495-500.rds")
message("finished 33 ", Sys.time())
q()
