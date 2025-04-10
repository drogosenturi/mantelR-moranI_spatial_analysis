## script to make patch_dists and save as RDS
#setwd("~/mantel_lab/exp1/runs/")
setwd("~/soraida_r/raw_runs_7-10/exp6/runs/")

# function to load all packages
loadPackages <- function(packages) {
    lapply(c("data.table", "parallel",
             "tidyr", "dplyr", "vegan"),
             require, character.only = TRUE)
}
loadPackages()

df_patches <- fread("PatchRichnessEnd-1.csv")
colnames(df_patches)[1] <- "P.xcor"
colnames(df_patches)[2] <- "P.ycor"
colnames(df_patches)[3] <- "patch.ID"
df_patches <- df_patches[,-c(4:5)]
head(df_patches)

# sort the patch list
df_patches <- df_patches[order(df_patches[["patch.ID"]]),]
df_patches <- df_patches[,-3]
head(df_patches)

patch_dists <- vegdist(cbind(df_patches$P.xcor, df_patches$P.ycor),"euclid")

#saveRDS(patch_dists, "~/mantel_files/patch_dists.rds")
saveRDS(patch_dists, "~/soraida_r/test/patch_dists.rds")