install.packages("Seurat")
devtools::install_github('satijalab/seurat-data')

library(Seurat)
library(SeuratData)
library(ggplot2)
library(dplyr)

# Install sample Visium data from a mouse brain
SeuratData::InstallData("stxBrain") # ~ 100 MB download - may take a few minutes

# Learn more about the dataset
?stxBrain

# Load data for one of the slices (posterior sagittal view)
brain <- SeuratData::LoadData("stxBrain", type = "posterior1")

# We notice this is a complex object ...
str(brain)

# A matrix of gene expression/feature counts is common to many assays
# Seurat extracts this for us easily
# genes (row) x spots (columns)
brain_ge <- GetAssayData(brain)
head(brain_ge)
dim(brain_ge)

# Look at total transcripts per spot
# Note: the "+" is familiar to ggplot users!
plot1 <- SpatialFeaturePlot(brain, features = "nCount_Spatial")

# Normalize to account for differences in overall gene expression / cell count
# Note: we normally avoid overwriting objects but in this case, Seurat adds
# information to the current object
brain <- SCTransform(brain, assay = "Spatial", verbose = FALSE)

# Expression of genes of interest
SpatialFeaturePlot(brain, features = c("Gm5083", "Hpca"))

# You can use Tidyverse pipes to chain together steps in a Seurat workflow
brain <- RunPCA(brain, assay = "SCT", verbose = FALSE) %>% 
  FindNeighbors(reduction = "pca", dims = 1:30) %>% 
  FindClusters(verbose = FALSE) %>% 
  RunUMAP(reduction = "pca", dims = 1:30)

# Plot cluster analysis of spots and map onto tissue
DimPlot(brain, reduction = "umap")
SpatialDimPlot(brain)

