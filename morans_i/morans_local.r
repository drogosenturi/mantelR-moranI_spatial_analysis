##              LOCAL MORANS                ##
library(pgirmess)
library(dplyr)
library(parallel)
setwd('~/mantel_files/mimicry_runs/')
#setwd('~/soraida_r/mantel_analysis/nursery_files/')

# read in coordinates
coordsdata <- read.csv("PatchRichnessEnd-101.csv", header = TRUE)

# extract only xy
coordxy <- coordsdata[,1:2]
rm(coordsdata) #remove old

# file path for patch richness files
file_path <- dir(path = ".",pattern = paste0("^", "PatchRichnessEnd",
                                             ".*\\.csv$"))

# local moran test
local_moran <- function(i) {
    localfiles <- read.csv(file_path[i])
    LocalRichnessdata <- localfiles[[i]][5]
    result <- pgirmess::correlog(coords = coordxy, z = LocalRichnessdata,
                       method = "Moran", nbclass = 15)
    return(
        result
    )
    gc()
}
message("local test start: ", Sys.time())
result <- mclapply(1:20, local_moran, mc.cores = 20)
message("local test finish: ", Sys.time())

# save as RDS
saveRDS(result, "~/moran_files/local_results/mimicry_result_test.rds")
message("file saved", Sys.time())
