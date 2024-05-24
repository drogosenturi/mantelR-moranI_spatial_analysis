##              LOCAL MORANS 4 NURSERIES NO MIMICRY               ##
library(pgirmess)
library(parallel)
library(gtools)
setwd('~/mantel_files/no_mimic_runs/') # four nursery wihout mimicry runs
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
result <- mclapply(1:30, local_moran, mc.preschedule = FALSE, mc.cores = 30)
message("local test finish 1: ", Sys.time())

# save as RDS
saveRDS(result, "~/moran_files/no_mimicry/local_results/nomimic_results_1-30.rds")
message("file 1 saved", Sys.time())
gc()
q()