setwd('~/mantel_files/mimicry_runs/')

coordsdata <- read.csv("PatchRichnessEnd-101.csv", header = TRUE)

# extract only xy
coordsdata <- coordsdata[order(coordsdata$patch.ID),]
coordxy <- coordsdata[,1:2]
coordxy <- coordxy[order(coordxy$pxcor),]
rm(coordsdata) #remove old

file_path <- dir(path = ".",pattern = paste0("^", "PatchRichnessEnd",
                                             ".*\\.csv$"))

length(file_path)

local1 <- read.csv(file_path[[25]])
local1 <- local1[order(local1$patch.ID),]
local1 <- as.vector(local1[[5]])
message('length of first file')
length(local1)
head(local1)
message('length of coordxy')
nrow(coordxy)
head(coordxy)
