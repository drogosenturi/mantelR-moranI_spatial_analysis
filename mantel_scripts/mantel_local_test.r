##              Mantel local for experiment 1             ##
#setwd("~/mantel_files/exp1/runs/")
setwd("~/soraida_r/test/")
## Create function to load all packages
loadPackages <- function(packages) {
    lapply(c("data.table", "parallel",
             "tidyr", "dplyr", "vegan"),
             require, character.only = TRUE)
}
loadPackages()

# create a df containing all patch coordinates, make headers same
# and remove richness and block columns
df_patches <- fread("~/soraida_r/raw_runs_7-10/exp1/runs/PatchRichnessEnd-1.csv")
colnames(df_patches)[1] <- "X"
colnames(df_patches)[2] <- "Y"
colnames(df_patches)[3] <- "patch.ID"
df_patches <- df_patches[,-c(4:5)]
head(df_patches)

# sort the patch list
df_patches <- df_patches[order(df_patches[["patch.ID"]]),]
df_patches <- df_patches[,-3]
head(df_patches)

# make break points
break_points <- seq(0, 30, by = 2)

# local mantel correlogram with vegan
mantel_vegan <- function(i, x) {
    species_dists <- readRDS(sdist_list[[x]])
    result <- mantel.correlog(species_dists[[i]],
                              patch_dists,
                              break.pts = break_points,
                              cutoff = FALSE, nperm=1)
    num <- i
    saveRDS(result, file = paste("local_mantel_exp1_", i, ".rds", sep=""))
}

# make file list
sdist_list <- c("~/soraida_r/test/sp_dist_1.rds","~/soraida_r/test/sp_dist_2.rds")
#read in matrix
library(DBI)
species_dists_1 <- readRDS(sdist_list[1])

# change to df
library(reshape2)
sp_df <- melt(as.matrix(species_dists_1[[1]]), varnames = c("row","col"))
# connect to remote
mydb <- dbConnect(RSQLite::SQLite(), "")
# load into remote, must be df
dbWriteTable(mydb, "species_dists", sp_df)
rm(species_dists_1)
gc()
species_dist_matrix <- acast(sp_df, row~col~value)
#remove old to free up mem
rm(species_dists_1)
rm(sp_df)
gc()

patch_dists <- readRDS("~/soraida_r/test/patch_dists.rds")
mclapply(1:5, mantel_vegan, x = 1, mc.cores=2)

# trying partial mantel instead
sdist_list <- c("~/soraida_r/test/sp_dist_1.rds","~/soraida_r/test/sp_dist_2.rds")
sdist <- readRDS(sdist_list[1][[1]])
sdist <- sdist[[1]]
patch_dists <- readRDS("~/soraida_r/test/patch_dists.rds")
mantel.partial()


## trying to do mantel correlation raw
sdist_list <- c("~/soraida_r/test/sp_dist_1.rds","~/soraida_r/test/sp_dist_2.rds")
sdist <- readRDS(sdist_list[1])
patch_dists <- readRDS("~/soraida_r/test/patch_dists.rds")
#without df
result <- cor(sdist[[1]], patch_dists)

#with df
mantel.df <- data.frame(sdist = as.matrix(sdist[[1]]),
                        pdist = as.matrix(patch_dists))
rm(patch_dists)
rm(sdist)
gc()
# do mantel corr
with(mantel.df, cor(sdist, pdist))
q()