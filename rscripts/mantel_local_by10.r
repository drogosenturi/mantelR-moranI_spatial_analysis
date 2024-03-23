##              BEST LOCAL MANTEL WITH XY COORDS             ##
message("start ", Sys.time())
setwd("~/mantel_lab/nursery_files/")
#setwd("~/soraida_r/mantel_analysis/nursery_files/")
## Create function to load all packages
loadPackages <- function(packages) {
    lapply(c("data.table", "parallel", "ecodist",
             "tidyr", "dplyr", "vegan"),
             require, character.only = TRUE)
}
loadPackages()

# create a df containing all patch coordinates, make headers same
# and remove richness and block columns
df_patches <- fread("PatchRichnessEnd-101.csv")
colnames(df_patches)[1] <- "P.xcor"
colnames(df_patches)[2] <- "P.ycor"
df_patches <- df_patches[,-c(3:5)]
head(df_patches)

# change df_patches headers to X and Y
colnames(df_patches)[1] <- "X"
colnames(df_patches)[2] <- "Y"
#head(df_patches) # quick check

# load in species_dists
species_dists <- readRDS("~/sp_dist_mimicry_500.rds")

# change to only first 10
species_dists <- species_dists[1:10]

# make break points
break_points <- seq(0, 30, by = 2)

# local mantel correlogram with vegan
mantel_vegan <- function(i) {
    result <- mantel.correlog(species_dists[[i]],
                              XY = df_patches,
                              break.pts = break_points,
                              cutoff = FALSE, nperm=1)
    return(
        result
    )
}
v_result <- mclapply(1:2, mantel_vegan, mc.cores = 2)

## save as object for later use
# contains list of all mantel results for x amount of files
saveRDS(v_result, "~/soraida_r/mantel_analysis/local_results/timeout_test.rds")
message("finished ", Sys.time())
q()
