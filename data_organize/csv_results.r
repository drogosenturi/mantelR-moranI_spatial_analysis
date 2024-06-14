library(tidyverse)
library(gtools)
library(vegan)
library(ape)

# load in 4 nurs no mimic table csv, skip first 6 lines
four_nomimic <- read.csv('~/soraida_r/4nurs_nomimic/table.csv', header = TRUE,
                         skip = 6)
# sort by run number
four_nomimic <- four_nomimic[order(four_nomimic$X.run.number.),]
four_nomimic <- four_nomimic[,-6] #remove step number

# add in global moran test values
g_moran <- readRDS('~/soraida_r/moran_results/no_mimic/global/global_moran_nomimic.rds')
extract <- function(i) {
    result <- g_moran[[i]]$observed
    result1 <- g_moran[[i]]$p.value
    return(
        result
    )
}
# returns list of extracted values
observed <- lapply(1:length(g_moran), extract)
# add unlisted values as column
four_nomimic$global_moran <- unlist(observed)
#function for p.values
p_values <- lapply(1:length(g_moran), FUN = function(i){
    result1 <- g_moran[[i]]$p.value
    return(result1)
})
# add column to df
four_nomimic$moran_p <- unlist(p_values)

# add in global mantel test values
