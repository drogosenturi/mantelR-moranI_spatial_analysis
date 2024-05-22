setwd("~/mantel_lab")
## Create function to load all packages
loadPackages <- function(packages) {
    lapply(c("data.table",
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
df_list <- lapply(1:2, load_df)

# make list of new dfs with just species id and patchid
# and coordinates
fix_df <- function(z) {
    df_temp <- as.data.frame(df_list[z])
    return(df_temp[c("P.xcor", "P.ycor", "patch.ID", "Species")])
}
dff <- lapply(1:2, fix_df) # put list into dff

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
dfSO <- lapply(1:2, to_SO)

# fill in missing coordinates for all df in dfSO
fill_in_coords <- function(i) {
    df_temp <- as.data.frame(dfSO[[i]])
    joined <- full_join(df_temp,df_patches,by=c("P.xcor","P.ycor","patch.ID"))
    joined[is.na(joined)] <- 0
    return(
        joined
    )
}
dffin <- lapply(1:2, fill_in_coords)
#length(as.data.frame(dffin[[2]])[,1]) # check length

# make list of patch distance matrices
make_pdist <- function(i) {
    df_temp <- as.data.frame(dffin[i])
    return(
        vegdist(cbind(df_temp$P.xcor, df_temp$P.ycor),"euclid")
    )
}
patch_dists <- lapply(1:2, make_pdist)

# make list of species distance matrices
make_sdist <- function(i) {
    df_temp <- as.data.frame(dffin[i])
    return(
        vegdist(df_temp[-(1:3)]) # method bray
    )
}
species_dists <- lapply(1:2, make_sdist)

# remove NaN
remove_NaN <- function(i) {
    temp <- species_dists[[i]]
    temp[is.nan(temp)] <- 0
    return(
        temp
    )
}
species_dists <- lapply(1:2, remove_NaN)
#is.nan(as.dist(species_dists[[1]])) #check

# clean up the garbage
rm(list = c("df_list", "dff", "dffin", "file_path", "df_patches","dfSO"))
gc()

# make break points
break_points <- seq(0, 50, by = 2)

# local mantel correlogram with vegan
mantel_vegan <- function(i) {
    result <- mantel.correlog(species_dists[[i]],
                              D.geo = patch_dists[[i]],
                              break.pts = break_points,
                              cutoff = FALSE, nperm=100)
    return(
        result
    )
}
system.time(v_result <- lapply(1, mantel_vegan))

## save as object for later use
# should contain list of all mantel results for x amount of files
saveRDS(v_result, "test_result1.rds")


# global mantel with ade4
#library(ade4) #package w/ mantel test in it
#mantel <- function(i) {
#    patch_temp <- as.dist(patch_dists[[i]])
#    species_temp <- as.dist(species_dists[[i]])
#    return (
#        df_plot <- mantel.rtest(patch_temp, species_temp,
#                                nrepet = 2)
#    )
#}
#resultx <- lapply(1, mantel)

# plot
#mantel_result <- readRDS("result(x).rds")
#library(ggplot2)
#plot_mantel <- function(i) {
#    png(file = "~/soraida_r/test.png")
#    plot(result[[i]], main = "Mantel's test")
#    dev.off()
#}
