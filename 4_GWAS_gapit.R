# GWAS分析脚本
rm(list = ls())
library(MASS) # required for ginv
library(multtest)
library(gplots)
library(compiler) #required for cmpfun
library(scatterplot3d)
library(bigmemory)
library(ape)
library(EMMREML)
source("./01_scripts/GAPIT1.txt")
source("./01_scripts/GAPIT2.txt")

ARGS <- commandArgs(T)
print(paste0("GAPIT Working Gene ID:",ARGS[1]))
job <- ARGS[1]

myG <- read.delim(paste0("./06_out_gene/",job,".gene.hmp.txt"),
                  header = F)
myY <- read.table(paste0("./07_out_trait/",job,".trait.txt"),
                  header = T,sep = "\t")
now_dir <- getwd()
dir.create(paste0(now_dir,"/08_out_GWAS/MLM_",job))
setwd(paste0(now_dir,"/08_out_GWAS/MLM_",job))
myGAPIT <- GAPIT(
  Y=myY,
  G=myG,
  PCA.total=3,
  model="MLM",
  Random.model = TRUE
)
dir.create(paste0(now_dir,"/08_out_GWAS/FarmCPU_",job))
setwd(paste0(now_dir,"/08_out_GWAS/FarmCPU_",job))
myGAPIT <- GAPIT(
  Y=myY,
  G=myG,
  PCA.total=3,
  model="FarmCPU",
  Random.model = TRUE
)

setwd(now_dir)
print(paste0(job,"  GWAS finished!"))
