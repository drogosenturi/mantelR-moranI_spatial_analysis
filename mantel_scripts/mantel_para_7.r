##              LOCAL MANTEL WITH XY COORDS AND SOCK CLUSTER             ##
# uses more memory :(
#setwd("~/mantel_lab/nursery_files/")
setwd("~/soraida_r/mantel_analysis/nursery_files/")
## Create function to load all packages
loadPackages <- function(packages) {
    lapply(c("data.table", "parallel", "ecodist",
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
df_patches <- df_patches[,-c(3:5)]
head(df_patches)

# list of DF with each item being full dataframe
load_df <- function(z) {
    fread(file_path[z])
}
df_list <- mclapply(1:2, load_df, mc.cores = 2)

# make list of new dfs with just species id and patchid
# and coordinates
fix_df <- function(z) {
    df_temp <- as.data.frame(df_list[z])
    colnames(df_temp)[1] <- "P.xcor"
    colnames(df_temp)[2] <- "P.ycor"
    colnames(df_temp)[3] <- "patch.ID"
    return(df_temp[c("P.xcor", "P.ycor", "patch.ID", "Species")])
}
dff <- mclapply(1:2, fix_df, mc.cores = 2) # put list into dff

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
dfSO <- mclapply(1:2, to_SO, mc.cores = 2)

# fill in missing coordinates for all df in dfSO
fill_in_coords <- function(i) {
    df_temp <- as.data.frame(dfSO[[i]])
    joined <- full_join(df_temp,df_patches,by=c("P.xcor", "P.ycor"))
    joined[is.na(joined)] <- 0
    return(
        joined
    )
}
dffin <- mclapply(1:2, fill_in_coords, mc.cores = 2)
#length(as.data.frame(dffin[[7]])[,1]) # check length
# change df_patches headers to X and Y
colnames(df_patches)[1] <- "X"
colnames(df_patches)[2] <- "Y"
#head(df_patches) # quick check

# make list of species distance matrices
make_sdist <- function(i) {
    df_temp <- as.data.frame(dffin[i])
    return(
        vegdist(df_temp[-(1:3)]) # method bray
    )
}
species_dists <- mclapply(1:2, make_sdist, mc.cores = 2)

# remove NaN
remove_NaN <- function(i) {
    temp <- species_dists[[i]]
    temp[is.nan(temp)] <- 0
    return(
        temp
    )
}
species_dists <- mclapply(1:2, remove_NaN, mc.cores = 2)
#is.nan(as.dist(species_dists[[1]])) #check

# clean up the garbage
rm(list = c("df_list", "dff", "dffin", "file_path","dfSO"))
gc()

# make break points
break_points <- seq(0, 30, by = 2)

# local mantel correlogram with vegan
mantel_vegan <- function(i) {
    require(vegan)
    result <- mantel.correlog(species_dists[[i]],
                              XY = df_patches,
                              break.pts = break_points,
                              cutoff = FALSE, nperm=100)
    return(
        result
    )
}
# try a cluster instead of mclapply
system.time({
    cl <- makeCluster(2)
    clusterExport(cl, c("species_dists", "df_patches", "break_points"))
    v_result <- parLapply(cl, 1:2, mantel_vegan)
})
stopCluster(cl)

## save as object for later use
# contains list of all mantel results for x amount of files
saveRDS(v_result, "~/soraida_r/mantel_analysis/local_results/local_test_XY.rds")

# global mantel analysis
#mantel_global <- function(i) {
#    result <- mantel(
#        species_dists[[i]],
#        patch_dists[[i]]
#        )
#    return(
#        result
#    )
#}
#system.time(g_result <- mclapply(1:7, mantel_global, mc.cores = 7))

# save result
#saveRDS(g_result, "global_result1-7.rds")
