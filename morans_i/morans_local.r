##              LOCAL MORANS                ##
library(pgirmess)
library(future)
#setwd('~/mantel_files/mimicry_runs/')
setwd('~/soraida_r/mantel_analysis/nursery_files/')

# read in coordinates
coordsdata <- read.csv("PatchRichnessEnd-101.csv", header = TRUE)

# extract only xy
coordxy <- coordsdata[,1:2]
rm(coordsdata) #remove old

# file path for patch richness files
file_path <- dir(path = ".",pattern = paste0("^", "PatchRichnessEnd",
                                             ".*\\.csv$"))

# local moran test
message("local test start: ", Sys.time())
plan("multisession", workers = 10)
Localmoran_result <- foreach(i = 1:10) %do% {
    gc()
    localfiles <- read.csv(file_path[i])
    LocalRichnessdata <- localfiles[[i]]$patch.richness
    pgirmess::correlog(coords = coordxy, z = LocalRichnessdata,
                       method = "Moran", nbclass = 15)
}
plan("sequential")
message("local test finish: ", Sys.time())

# save as RDS
saveRDS(Localmoran_result, "~/moran_files/local_results/mimicry_result.rds")
message("file saved", Sys.time())