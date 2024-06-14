library(tidyverse)
library(gtools)
library(vegan)
library(ape)

# load in 4 nurs no mimic table csv, skip first 6 lines
#df <- read.csv('~/soraida_r/4nurs_nomimic/table.csv', header = TRUE,
#                         skip = 6)
# load in 4nurs
df <- read.csv('~/mantel_files/4nurs_nomimic/table.csv', header = TRUE,
                         skip = 6)
# load in mimicry no nurs
#df <- read.csv('~/mantel_files/nonurs_mimic_runs/table.csv', header = TRUE)
# sort by run number
df <- df[order(df$X.run.number.),]
df <- df[,-6] #remove step number

# add in global moran test values
g_moran <- readRDS('~/moran_files/mimicry/global_results/g_moran_full.rds')
extract <- function(i) {
    result <- g_moran[[i]][1]
    return(
        result
    )
}
# returns list of extracted values
observed <- lapply(1:length(g_moran), extract)
# add unlisted values as column
df$global_moran <- unlist(observed)
#function for p.values
p_values <- lapply(1:length(g_moran), FUN = function(i){
    result1 <- g_moran[[i]][4]
    return(result1)
})
# add column to df
df$moran_p <- unlist(p_values)

# add in global mantel test values
g_mantel <- readRDS('~/mantel_files/nonurs_mimic_result/global_results/g_mantel_full.rds')
# extract statistic
statistic <- lapply(1:length(g_mantel), FUN = function(i){
    result <- g_mantel[[i]]$statistic
    return(result)
})
# extract p value
p_value <- lapply(1:length(g_mantel), FUN = function(i){
    result <- g_mantel[[i]]$signif
    return(result)
})
# add to df
df$global_mantel <- unlist(statistic)
df$mantel_p <- unlist(p_value)

# save to csv
#write.csv(df, file = "~/soraida_r/mantel_analysis/data_organize/4_nomimic_globals.csv")
write.csv(df, file = "~/mantel_lab/data_organize/nonurs_mimic_globals.csv")
