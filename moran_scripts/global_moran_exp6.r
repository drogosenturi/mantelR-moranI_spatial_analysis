##              GLOBAL MORANS EXPERIMENT 6                ##
library(parallel)
library(ape)
library(gtools)
setwd('~/mantel_files/exp6/runs/')
#setwd('~/soraida_r/mantel_analysis/nursery_files/')

# read in coordinates
coordsdata <- read.csv("PatchRichnessEnd-1.csv", header = TRUE)

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
result <- mclapply(1:30, global_moran, mc.preschedule = FALSE, mc.cores = 30)
message("local test finish 1: ", Sys.time())

# save as RDS
saveRDS(result, "~/moran_files/exp6/global/global_exp6_1-30.rds")
message("file 1 saved", Sys.time())
gc()
q()