##              LOCAL MORANS 4 NURSERIES                ##
library(pgirmess)
library(parallel)
library(gtools)
setwd('~/mantel_files/nurs_runs/') # four nursery runs
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
# message("local test start 1: ", Sys.time())
# result <- mclapply(1:120, local_moran, mc.preschedule = FALSE, mc.cores = 40)
# message("local test finish 1: ", Sys.time())

# # save as RDS
# saveRDS(result, "~/moran_files/4nurs/local_results/nursery_results_1-120.rds")
# message("file 1 saved", Sys.time())
# gc()

## RUN 2
message("local test start 2: ", Sys.time())
result <- mclapply(121:240, local_moran, mc.preschedule = FALSE, mc.cores = 40)
message("local test finish 2: ", Sys.time())

# save as RDS
saveRDS(result, "~/moran_files/4nurs/local_results/nursery_results_121-240.rds")
message("file 2 saved", Sys.time())
gc()
q()