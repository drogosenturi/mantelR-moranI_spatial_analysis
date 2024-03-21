setwd("~/mantel_lab/nursery_files/")
## Create function to load all packages
loadPackages <- function(packages) {
    lapply(c("data.table", "parallel", "future",
             "tidyr", "dplyr", "vegan"),
             require, character.only = TRUE)
}
loadPackages()

# define file path so we can use multiple files at a time later
file_path <- dir(path = ".",
  pattern = paste0("^", "SpeciesOccurrenceEnd", ".*\\.csv$")
)

# create a df containing all patch coordinates, make headers same
# and remove richness and block columns
df_patches <- fread("PatchRichnessEnd-101.csv")
colnames(df_patches)[1] <- "P.xcor"
colnames(df_patches)[2] <- "P.ycor"
colnames(df_patches)[3] <- "patch.ID"
df_patches <- df_patches[,-c(4:5)]
head(df_patches)

# list of DF with each item being full dataframe
load_df <- function(z) {
    fread(file_path[z])
}
df_list <- mclapply(1:10, load_df, mc.cores = 10)

# make list of new dfs with just species id and patchid
# and coordinates
fix_df <- function(z) {
    df_temp <- as.data.frame(df_list[z])
    colnames(df_temp)[1] <- "P.xcor"
    colnames(df_temp)[2] <- "P.ycor"
    colnames(df_temp)[3] <- "patch.ID"
    return(df_temp[c("P.xcor", "P.ycor", "patch.ID", "Species")])
}
dff <- mclapply(1:10, fix_df, mc.cores = 10) # put list into dff

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
dfSO <- mclapply(1:10, to_SO, mc.cores = 10)

# fill in missing coordinates for all df in dfSO
fill_in_coords <- function(i) {
    df_temp <- as.data.frame(dfSO[[i]])
    joined <- full_join(df_temp,df_patches,by=c("P.xcor","P.ycor","patch.ID"))
    joined[is.na(joined)] <- 0
    return(
        joined
    )
}
dffin <- mclapply(1:10, fill_in_coords, mc.cores = 10)
#length(as.data.frame(dffin[[7]])[,1]) # check length

# make list of patch distance matrices
make_pdist <- function(i) {
    df_temp <- as.data.frame(dffin[i])
    return(
        vegdist(cbind(df_temp$P.xcor, df_temp$P.ycor),"euclid")
    )
}
patch_dists <- mclapply(1:10, make_pdist, mc.cores = 10)

# make list of species distance matrices
make_sdist <- function(i) {
    df_temp <- as.data.frame(dffin[i])
    return(
        vegdist(df_temp[-(1:3)]) # method bray
    )
}
species_dists <- mclapply(1:10, make_sdist, mc.cores = 10)

# remove NaN
remove_NaN <- function(i) {
    temp <- species_dists[[i]]
    temp[is.nan(temp)] <- 0
    return(
        temp
    )
}
species_dists <- mclapply(1:10, remove_NaN, mc.cores = 10)
#is.nan(as.dist(species_dists[[1]])) #check

# clean up the garbage
rm(list = c("df_list", "dff", "dffin", "file_path", "df_patches","dfSO"))
gc()

# make break points
break_points <- seq(0, 50, by = 2)

# try out plan
#plan(multisession, workers = 7)

# local mantel correlogram with vegan
mantel_vegan <- function(i) {
    result <- mantel.correlog(as.dist(species_dists[[i]]),
                              D.geo = as.dist(patch_dists[[i]]),
                              break.pts = break_points,
                              cutoff = FALSE, nperm=100)
    return(
        result
    )
}
#system.time(future(v_result <- lapply(1:7, mantel_vegan)))

system.time(v_result <- mclapply(1:7, mantel_vegan, mc.cores = 7))

## save as object for later use
# contains list of all mantel results for x amount of files
saveRDS(v_result, "local_result1-7.rds")

# global mantel analysis
mantel_global <- function(i) {
    result <- mantel(
        species_dists[[i]],
        patch_dists[[i]]
        )
    return(
        result
    )
}
system.time(g_result <- mclapply(1:7, mantel_global, mc.cores = 7))

# save result
saveRDS(g_result, "global_result1-7.rds")