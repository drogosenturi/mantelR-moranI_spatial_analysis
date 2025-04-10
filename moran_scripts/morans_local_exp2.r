##              LOCAL MORANS EXPERIMENT 2                ##
library(pgirmess)
library(parallel)
library(gtools)
setwd('~/mantel_files/exp2/runs/') # original mimicry
#setwd('~/soraida_r/mantel_analysis/nursery_files/')

# read in coordinates
coordsdata <- read.csv("PatchRichnessEnd-1.csv", header = TRUE)
# order the data by patchID
coordsdata <- coordsdata[order(coordsdata[["patch.ID"]]),]

# extract only xy
coordxy <- coordsdata[,1:2]
rm(coordsdata) #remove old

# file path for patch richness files
file_path <- dir(path = ".",pattern = paste0("^", "PatchRichnessEnd",
                                             ".*\\.csv$"))
file_path <- mixedsort(file_path, decreasing=TRUE)
head(file_path)

# local moran test
local_moran <- function(i) {
    localfiles <- read.csv(file_path[i])
    localfiles <- localfiles[order(localfiles[["patch.ID"]]),]
    localfiles <- as.vector(localfiles[["patch.richness"]])
    result <- pgirmess::correlog(coords = coordxy, z = localfiles,
                                 nbclass = 68)
    return(
        result
    )
}

## RUN 1
message("local test start 1: ", Sys.time())
result <- mclapply(1:120, local_moran, mc.preschedule = FALSE, mc.cores = 40)
message("local test finish 1: ", Sys.time())

# save as RDS
saveRDS(result, "~/moran_files/exp2/local/local_exp2_1-120.rds")
message("file 1 saved", Sys.time())
gc()

## RUN 2
message("local test start 2: ", Sys.time())
result <- mclapply(121:240, local_moran, mc.preschedule = FALSE, mc.cores = 40)
message("local test finish 2: ", Sys.time())

# save as RDS
saveRDS(result, "~/moran_files/exp2/local/local_exp2_121-240.rds")
message("file 2 saved", Sys.time())
gc()

## RUN 3
message("local test start 3: ", Sys.time())
result <- mclapply(241:360, local_moran, mc.preschedule = FALSE, mc.cores = 40)
message("local test finish 3: ", Sys.time())

# save as RDS
saveRDS(result, "~/moran_files/exp2/local/local_exp2_241-360.rds")
message("file 3 saved", Sys.time())
gc()

## RUN 4
message("local test start 4: ", Sys.time())
result <- mclapply(361:480, local_moran, mc.preschedule = FALSE, mc.cores = 40)
message("local test finish 4: ", Sys.time())

# save as RDS
saveRDS(result, "~/moran_files/exp2/local/local_exp2_361-480.rds")
message("file 4 saved", Sys.time())
gc()

q()