# Mantel R and Moran's I for large datasets
Mantel R is used to calculate correlations between two dissimilarity matrices. Moran's I is
a measure of spatial autocorrelation.

## The experiment
Here, we use species presence/absence data from an ABM simulating how
plant nurseries and social mimicry affect what people plant in their yards.

## Methods
### Mantel R
We use several functions to import, sort, and calculate dissimilarity matrices from 
CSVs containing species presence/absence data. Using the 'vegan' package to calculate
Mantel R correlograms and global values and 'parallel' to employ parallel computing, this script can be
used to calculate Mantel R correlograms and global values for large datasets while being as memory-efficient
as possible.

### Moran's I
Similar to above, we use functions to import, sort, and calculate Moran's I local and global
values for yards from large CSV files contianing species richness data of 1000 yards.

## Help
If you are conducting spatial analysis using large, site-based ecological datasets, these scripts may be useful for you!
Please reach out with any questions on how to apply this to your dataset or with any questions about the script
