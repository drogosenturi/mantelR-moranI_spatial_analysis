##              Species distances for control experiment            ##
message("start ", Sys.time())
setwd("~/mantel_files/50nurs_runs/")
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
df_list <- mclapply(1, load_df, mc.cores = 1)
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
dff <- mclapply(1, fix_df, mc.cores = 1) # put list into dff
rm(df_list)

# tidyverse it up and make species occurrence table
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
dfSO <- mclapply(1, to_SO, mc.cores = 1)
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
dfcoords <- mclapply(1, fill_in_coords, mc.cores = 1)
rm(dfSO)

# sort the final dataframe
sort_dfcoords <- function(i) {
    df_temp <- as.data.frame(dfcoords[[i]])
    df_temp <- df_temp[order(df_temp[["patch.ID"]]), ]
    return(
        df_temp
    )
}
dffin <- mclapply(1, sort_dfcoords, mc.cores = 1)

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
species_dists <- mclapply(1, make_sdist, mc.cores = 1)
#save file
saveRDS(species_dists, "~/mantel_files/50nurs_result/sp_dist_50nurs_1.rds")
rm(species_dists)
q()
