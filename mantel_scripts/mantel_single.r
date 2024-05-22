setwd("~/soraida_r/Dummy2")
## Create function to load all packages
loadPackages <- function(packages) lapply(c("ecodist","parallel",
  "foreach", "data.table", "bigmemory"), require, character.only = TRUE)
loadPackages()
library(tidyr)
library(dplyr)

# define file path so we can use multiple files at a time later
file_path <- dir(path = ".",
  pattern = paste0("^", "SpeciesOccurrenceEnd", ".*\\.csv$")
)
# create a df of species occurence by patch
df <- fread(file_path[2])
# create a df containing all patch coordinates, make headers same
# and remove richness and block columns
df_patches <- fread("PatchRichnessEnd-101.csv")
colnames(df_patches)[1] <- "xcor"
colnames(df_patches)[2] <- "ycor"
colnames(df_patches)[3] <- "patchID"
df_patches <- df_patches[,-c(4:5)]
head(df_patches)

# make new df with just species id and patchid, change to patchID
new_df <- df[,1:3]
new_df$species <- df[,5]
colnames(new_df)[1] <- "xcor"
colnames(new_df)[2] <- "ycor"
colnames(new_df)[3] <- "patchID"
#new_df

# tidyverse it up and make species occurence table
## patch as row labels
## and number of times it occurs in each patch
new_df %>%
    distinct(xcor, ycor, patchID, species) %>%
    mutate(val = 1) %>%
    pivot_wider(names_from = species, values_from = 'val',
                values_fill = 0) -> speciesOccurence

# convert back to df and remove old DFs
df_SO <- as.data.frame(speciesOccurence)

# join df_SO to df_patches to fill in missing patch coordinates
joined <- full_join(df_SO,df_patches,by=c("xcor","ycor","patchID"))
# change missing values to 0
joined[is.na(joined)] <- 0
#joined[9963,] # test

# clean up
rm(list = c('speciesOccurence', 'df', 'new_df'))

# make the two distance matrices for mantel
patch_dists <- dist(cbind(df_SO$xcor, df_SO$ycor))
species_dists <- dist(df_SO[-(1:3)])
#as.matrix(patch_dists)[1:5,1:5] # test
#as.matrix(species_dists)[1:5,1:5] # test

# clean garbage
rm(df_SO)
gc()

library(ade4) #package w/ mantel test in it
r <- mantel.rtest(patch_dists, species_dists, nrepet = 2)
png(file = "~/soraida_r/test.png")
plot(r)
dev.off()
#Monte-Carlo test
#Call: mantelnoneuclid(m1 = m1, m2 = m2, nrepet = nrepet)
#
#Observation: -0.004672399 
#
#Based on 1000 replicates
#Simulated p-value: 0.8431568 
#Alternative hypothesis: greater 
#
#      Std.Obs   Expectation      Variance 
#-1.017252e+00  3.380781e-05  2.140353e-05 
#Warning message:
#In is.euclid(m2) : Zero distance(s)
## runtime was 2hrs