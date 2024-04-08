##              LOCAL MORANS                ##
library(pgirmess)
library(parallel)
setwd('~/mantel_files/mimicry_runs/')
#setwd('~/soraida_r/mantel_analysis/nursery_files/')

# read in coordinates
coordsdata <- read.csv("PatchRichnessEnd-101.csv", header = TRUE)
# order the data by patchID
coordsdata <- coordsdata[order(coordsdata$patch.ID),]

# extract only xy
coordxy <- coordsdata[,1:2]
rm(coordsdata) #remove old

# file path for patch richness files
file_path <- dir(path = ".",pattern = paste0("^", "PatchRichnessEnd",
                                             ".*\\.csv$"))
length(file_path)

# local moran test
local_moran <- function(i) {
    localfiles <- read.csv(file_path[i])
    localfiles <- localfiles[order(localfiles$patch.ID),]
    LocalRichnessdata <- as.vector(localfiles[[5]])
    result <- pgirmess::correlog(coords = coordxy, z = LocalRichnessdata,
                                 nbclass = 15)
    return(
        result
    )
}
message("local test start: ", Sys.time())
result <- mclapply(c(193,206,207,211,213,215,216,217,218,219,221,222,225), local_moran, mc.preschedule=FALSE, mc.cores = 15)
message("local test finish: ", Sys.time())

# save as RDS
saveRDS(result, "~/moran_files/local_results/mimicry_results_193-225.rds")
message("file saved", Sys.time())
