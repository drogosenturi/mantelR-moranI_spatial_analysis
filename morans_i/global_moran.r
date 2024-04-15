##              GLOBAL MORANS                ##
library(parallel)
library(ape)
library(gtools)
setwd('~/mantel_files/mimicry_runs/')
#setwd('~/soraida_r/mantel_analysis/nursery_files/')

# read in coordinates
coordsdata <- read.csv("PatchRichnessEnd-101.csv", header = TRUE)

# order the data by patchID
coordsdata <- coordsdata[order(coordsdata[["patch.ID"]]),]

# extract only xy
coordxy <- coordsdata[,1:2]
rm(coordsdata) #remove old

# create inverted matrix, with diag at 0
coordmatrix <- as.matrix(dist(coordxy))
rm(coordxy)
coordmatrix.inv <- 1/coordmatrix
rm(coordmatrix)
diag(coordmatrix.inv) <- 0

# create file path for richness of 500 runs
file_path <- dir(path = ".",pattern = paste0("^", "PatchRichnessEnd",
                                             ".*\\.csv$"))
file_path <- mixedsort(file_path, decreasing = TRUE)
head(file_path)

# get rid of the garbage
gc()

global_moran <- function(i) {
    localfiles <- read.csv(file_path[i])
    localfiles <- localfiles[order(localfiles[["patch.ID"]]),]
    localfiles <- as.vector(localfiles[["patch.richness"]])
    result <- Moran.I(localfiles, coordmatrix.inv)
    return(
        result
    )
}
## RUN 1
message("global test start 1: ", Sys.time())
result <- mclapply(1:120, global_moran, mc.cores = 40)
message("local test finish 1: ", Sys.time())

# save as RDS
saveRDS(result, "~/moran_files/global_results/mglobal_results_1-120.rds")
message("file 1 saved", Sys.time())
gc()

## RUN 2
message("global test start 2: ", Sys.time())
result <- mclapply(121:240, global_moran, mc.cores = 40)
message("local test finish 2: ", Sys.time())

# save as RDS
saveRDS(result, "~/moran_files/global_results/mglobal_results_121-240.rds")
message("file 2 saved", Sys.time())
gc()

## RUN 3
message("global test start 3: ", Sys.time())
result <- mclapply(241:360, global_moran, mc.cores = 40)
message("local test finish 3: ", Sys.time())

# save as RDS
saveRDS(result, "~/moran_files/global_results/mglobal_results_241-360.rds")
message("file 3 saved", Sys.time())
gc()

## RUN 4
message("global test start 4: ", Sys.time())
result <- mclapply(361:480, global_moran, mc.cores = 40)
message("local test finish 4: ", Sys.time())

# save as RDS
saveRDS(result, "~/moran_files/global_results/mglobal_results_361-480.rds")
message("file 4 saved", Sys.time())
gc()

## RUN 5
message("global test start 5: ", Sys.time())
result <- mclapply(481:500, global_moran, mc.cores = 20)
message("local test finish 5: ", Sys.time())

# save as RDS
saveRDS(result, "~/moran_files/global_results/mglobal_results_481-500.rds")
message("file 5 saved", Sys.time())
q()