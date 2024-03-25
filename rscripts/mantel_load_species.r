##              BEST LOCAL MANTEL WITH XY COORDS             ##
message("start ", Sys.time())
setwd("~/mantel_files/mimicry_runs/")
#setwd("~/soraida_r/mantel_analysis/nursery_files/")
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
df_patches <- fread("~/mantel_lab/nursery_files/PatchRichnessEnd-101.csv")
colnames(df_patches)[1] <- "P.xcor"
colnames(df_patches)[2] <- "P.ycor"
df_patches <- df_patches[,-c(3:5)]
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
dffin <- mclapply(1:500, fill_in_coords, mc.cores = 40)
#length(as.data.frame(dffin[[7]])[,1]) # check length
rm(dfSO)

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
species_dists <- mclapply(1:500, make_sdist, mc.cores = 40)

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

# save files
saveRDS(species_dists, "~/mantel_files/sp_dist_mimicry_500.rds")

message("finished ", Sys.time())
q()
