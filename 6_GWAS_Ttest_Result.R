# 功能介绍：对GWAS结果和T检验的结果进行对比合并

rm(list = ls())
library(tidyverse)
library(writexl)
library(xlsx)

ARGS <- commandArgs(T)
print(paste0("GWAS_T_test_result_Working Gene ID:",ARGS[1]))
job <- ARGS[1] # 第一个参数基因ID

list_phe <- read.table("./01_scripts/list_phe.txt",header = F)
data_t <- read.table(paste0("./15_T_pvalue/",job,".pvalue.txt"),header = T)

# MLM模型
model <- "MLM"
phe <- list_phe[[1]][1]
data_G <- read.csv(paste0("./08_out_GWAS/",model,"_",job,"/GAPIT.",model,".",phe,".GWAS.Results.csv"))
colnames(data_t)[2] <- "SNP"
# 筛选t测验和GWAS的结果
out <- data_G[,1:3] %>% arrange(Position)
out$T_eff <- NA
out$T_count <- NA
for (i in 1:nrow(out)){
      snp_o <- out$SNP[i]
      for (k in 1:nrow(data_t)){
            snp_t <- data_t$SNP[k]
            if (snp_o == snp_t){
                  out$T_eff[i] <- data_t$Gene.eff[k]
                  out$T_count[i] <- data_t$Genotye_count[k]
                  break
            }
      }
}

# 表型数据整理
out <- out %>% arrange(SNP)
my_col <- ncol(out) #已有列数，用于判断新列
for (i in list_phe$V1){
      my_col <- my_col+1
      phe <- i
      data_G <- read.csv(paste0("./08_out_GWAS/",model,"_",job,"/GAPIT.",model,".",phe,".GWAS.Results.csv"))
      data_G <- data_G %>% arrange(SNP)
      out[as.numeric(my_col)] <- data_G[4]
      colnames(out)[as.numeric(my_col)] <- paste0("MLM_",phe)
      my_col <- my_col+1
      out[as.numeric(my_col)] <- -log10(data_G[4])
      colnames(out)[as.numeric(my_col)] <- phe
}

# Farm_CPU模型
model <- "FarmCPU"
my_col <- ncol(out) #已有列数，用于判断新列
for (i in list_phe$V1){
      my_col <- my_col+1
      phe <- i
      data_G <- read.csv(paste0("./08_out_GWAS/",model,"_",job,"/GAPIT.",model,".",phe,".GWAS.Results.csv"))
      data_G <- data_G %>% arrange(SNP)
      out[as.numeric(my_col)] <- data_G[4]
      colnames(out)[as.numeric(my_col)] <- paste0("CPU_",phe)
      my_col <- my_col+1
      out[as.numeric(my_col)] <- -log10(data_G[4])
      colnames(out)[as.numeric(my_col)] <- phe
}
write.xlsx(out,paste0("./16_out_GWAS_and_T/",job,"_all.xlsx"),row.names = F)
