##              BEST LOCAL MANTEL WITH XY COORDS             ##
message("start ", Sys.time())
#setwd("~/mantel_lab/")
setwd("~/soraida_r/mantel_analysis/")
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
df_patches <- fread("PatchRichnessEnd-1000.csv")
colnames(df_patches)[2] <- "P.xcor"
colnames(df_patches)[3] <- "P.ycor"
df_patches <- df_patches[,-c(1,4:7)]
head(df_patches)

# list of DF with each item being full dataframe
load_df <- function(z) {
    fread(file_path[z])
}
df_list <- mclapply(1:3, load_df, mc.cores = 3)

# make list of new dfs with just species id and patchid
# and coordinates
fix_df <- function(z) {
    df_temp <- as.data.frame(df_list[z])
    colnames(df_temp)[1] <- "P.xcor"
    colnames(df_temp)[2] <- "P.ycor"
    colnames(df_temp)[3] <- "patch.ID"
    return(df_temp[c("P.xcor", "P.ycor", "patch.ID", "Species")])
}
dff <- mclapply(1:3, fix_df, mc.cores = 3) # put list into dff

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
dfSO <- mclapply(1:3, to_SO, mc.cores = 3)

# fill in missing coordinates for all df in dfSO
fill_in_coords <- function(i) {
    df_temp <- as.data.frame(dfSO[[i]])
    joined <- full_join(df_temp,df_patches,by=c("P.xcor", "P.ycor"))
    joined[is.na(joined)] <- 0
    return(
        joined
    )
}
dffin <- mclapply(1:3, fill_in_coords, mc.cores = 3)
#length(as.data.frame(dffin[[3]])[,1]) # check length
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
species_dists <- mclapply(1:3, make_sdist, mc.cores = 3)

# remove NaN
remove_NaN <- function(i) {
    temp <- species_dists[[i]]
    temp[is.nan(temp)] <- 0
    return(
        temp
    )
}
species_dists <- mclapply(1:3, remove_NaN, mc.cores = 3)
#is.nan(as.dist(species_dists[[1]])) #check

# clean up the garbage
rm(list = c("df_list", "dff", "dffin", "file_path","dfSO"))
gc()

# make break points
break_points <- seq(0, 30, by = 2)

# local mantel correlogram with vegan
mantel_vegan <- function(i) {
    result <- mantel.correlog(species_dists[[i]],
                              XY = df_patches,
                              break.pts = break_points,
                              cutoff = FALSE, nperm=10)
    return(
        result
    )
}
v_result <- mclapply(1:3, mantel_vegan, mc.cores = 3)

## save as object for later use
# contains list of all mantel results for x amount of files
saveRDS(v_result, "~/mantel_lab/timeout_test.rds")

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

message("finished ", Sys.time())
q()
