##              Species distances for mimicry            ##
message("start ", Sys.time())
setwd("~/mantel_files/mimicry_runs/")
#setwd("~/soraida_r/mantel_analysis/nursery_files/") #home desktop
## Create function to load all packages
loadPackages <- function(packages) {
    lapply(c("data.table", "parallel", "ecodist",
             "tidyr", "dplyr", "vegan", "gtools"),
             require, character.only = TRUE)
}
loadPackages()

# define file path so we can use multiple files at a time later
file_path <- dir(path = ".",
  pattern = paste0("^", "SpeciesOccurrenceEnd", ".*\\.csv$")
)

# sort file path
file_path <- mixedsort(file_path, decreasing=TRUE)

# create a df containing all patch coordinates, make headers same
# and remove richness and block columns
df_patches <- fread("~/mantel_lab/nursery_files/PatchRichnessEnd-101.csv")
#df_patches <- fread("PatchRichnessEnd-101.csv") #for home desktop
colnames(df_patches)[1] <- "P.xcor"
colnames(df_patches)[2] <- "P.ycor"
colnames(df_patches)[3] <- "patch.ID"
df_patches <- df_patches[,-c(4:5)]
head(df_patches)

# sort the patch list
df_patches <- df_patches[order(df_patches[["patch.ID"]]),]
df_patches <- df_patches[,-3]
head(df_patches)

# list of DF with each item being full dataframe
load_df <- function(z) {
    fread(file_path[z])
}
df_list <- mclapply(1:500, load_df, mc.cores = 40)
rm(file_path)

# make list of new dfs with just species id and patchid
# and coordinates
fix_df <- function(z) {
    df_temp <- as.data.frame(df_list[z])
    colnames(df_temp)[1] <- "P.xcor"
    colnames(df_temp)[2] <- "P.ycor"
    colnames(df_temp)[3] <- "patch.ID"
    return(df_temp[c("P.xcor", "P.ycor", "patch.ID", "Species")])
}
dff <- mclapply(1:500, fix_df, mc.cores = 40) # put list into dff
rm(df_list)

# tidyverse it up and make species occurence table
## patch as row labels
## and number of times it occurs in each patch
to_SO <- function(i) {
    df_temp <- as.data.frame((dff[i]))
    return (
        df_temp %>% 
            distinct(P.xcor, P.ycor, patch.ID, Species) %>%
            mutate(val = 1) %>%
            pivot_wider(names_from = Species, values_from = 'val',
                        values_fill = 0)
    )
}
dfSO <- mclapply(1:500, to_SO, mc.cores = 40)
rm(dff)

# fill in missing coordinates for all df in dfSO
fill_in_coords <- function(i) {
    df_temp <- as.data.frame(dfSO[[i]])
    joined <- full_join(df_temp,df_patches,by=c("P.xcor", "P.ycor"))
    joined[is.na(joined)] <- 0
    return(
        joined
    )
}
dfcoords <- mclapply(1:500, fill_in_coords, mc.cores = 40)
rm(dfSO)

# sort the final dataframe
sort_dfcoords <- function(i) {
    df_temp <- as.data.frame(dfcoords[[i]])
    df_temp <- df_temp[order(df_temp[["patch.ID"]]), ]
    return(
        df_temp
    )
}
dffin <- mclapply(1:500, sort_dfcoords, mc.cores = 40)
head(dffin[[1]])
head(dffin[[100]][,3])

# clean up the garbage
gc()

# make list of species distance matrices
make_sdist <- function(i) {
    df_temp <- as.data.frame(dffin[i])
    temp <- vegdist(df_temp[-(1:3)]) # method bray
    temp[is.nan(temp)] <- 0
    return(
        temp
    )
    gc()
}

# make species_dists and load in batches of 40
message("batch 1")
species_dists <- mclapply(1:40, make_sdist, mc.cores = 40)
is.nan(species_dists[[1]])
saveRDS(species_dists, "~/mantel_files/sp_dist_mimicry_1-40.rds")
rm(species_dists)
gc()

message("batch 2")
species_dists <- mclapply(41:80, make_sdist, mc.cores = 40)
saveRDS(species_dists, "~/mantel_files/sp_dist_mimicry_41-80.rds")
rm(species_dists)
gc()

message("batch 3")
species_dists <- mclapply(81:120, make_sdist, mc.cores = 40)
saveRDS(species_dists, "~/mantel_files/sp_dist_mimicry_81-120.rds")
rm(species_dists)
gc()

message("batch 4")
species_dists <- mclapply(121:160, make_sdist, mc.cores = 40)
saveRDS(species_dists, "~/mantel_files/sp_dist_mimicry_121-160.rds")
rm(species_dists)
gc()

message("batch 5")
species_dists <- mclapply(161:200, make_sdist, mc.cores = 40)
saveRDS(species_dists, "~/mantel_files/sp_dist_mimicry_161-200.rds")
rm(species_dists)
gc()

message("batch 6")
species_dists <- mclapply(201:240, make_sdist, mc.cores = 40)
saveRDS(species_dists, "~/mantel_files/sp_dist_mimicry_201-240.rds")
rm(species_dists)
gc()

message("batch 7")
species_dists <- mclapply(241:280, make_sdist, mc.cores = 40)
saveRDS(species_dists, "~/mantel_files/sp_dist_mimicry_241-280.rds")
rm(species_dists)
gc()

message("batch 8")
species_dists <- mclapply(281:320, make_sdist, mc.cores = 40)
saveRDS(species_dists, "~/mantel_files/sp_dist_mimicry_281-320.rds")
rm(species_dists)
gc()

message("batch 9")
species_dists <- mclapply(321:360, make_sdist, mc.cores = 40)
saveRDS(species_dists, "~/mantel_files/sp_dist_mimicry_321-360.rds")
rm(species_dists)
gc()

message("batch 10")
species_dists <- mclapply(361:400, make_sdist, mc.cores = 40)
saveRDS(species_dists, "~/mantel_files/sp_dist_mimicry_361-400.rds")
rm(species_dists)
gc()

message("batch 11")
species_dists <- mclapply(401:440, make_sdist, mc.cores = 40)
saveRDS(species_dists, "~/mantel_files/sp_dist_mimicry_401-440.rds")
rm(species_dists)
gc()

message("batch 12")
species_dists <- mclapply(441:480, make_sdist, mc.cores = 40)
saveRDS(species_dists, "~/mantel_files/sp_dist_mimicry_441-480.rds")
rm(species_dists)
gc()

message("batch 13")
species_dists <- mclapply(481:500, make_sdist, mc.cores = 20)
saveRDS(species_dists, "~/mantel_files/sp_dist_mimicry_481-500.rds")
rm(species_dists)
gc()

# remove NaN
#remove_NaN <- function(i) {
#    temp <- species_dists[[i]]
#    temp[is.nan(temp)] <- 0
#    return(
#        temp
#    )
#}
#species_dists <- mclapply(1:500, remove_NaN, mc.cores = 40)
#is.nan(as.dist(species_dists[[1]])) #check

message("finished ", Sys.time())
q()