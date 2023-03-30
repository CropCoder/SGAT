rm(list = ls())
library(tidyverse)

ARGS <- commandArgs(T)
print(paste0("Results Working Gene ID:",ARGS[1]))
job <- ARGS[1]
dir_MLM <- paste0("MLM_",job)
phe <- ARGS[2]
file_name <- paste0("/GAPIT.MLM.",phe,".GWAS.Results.csv")
# job <- "GAPIT.Association.GWAS_Results.MLM.X19NYH.csv"
df <- read.csv(paste0("./08_out_GWAS/",dir_MLM,file_name),header = T)

###  替换染色体展示方式，1A_to_1 ===========================================================
chr_ref <- read.table("01_scripts/chr_num2str.txt",header = T)
chr_id_translate <- function(data,type){
  # 输入俩参，一为原始数据，二为类型
  if (type == "1_to_chr1A"){
    # 数字转字符型
    old_id <- as.character(data)
    for (k in 1:nrow(chr_ref)){
      if (as.character(chr_ref$chr_num[k]) == old_id){
        return(chr_ref$chr_str[k])
      }
    }
  }else{
    if (type == "chr1A_to_1"){
      # 字符转数字型
      old_id <- as.character(data)
      for (k in 1:nrow(chr_ref)){
        if (as.character(chr_ref$chr_str[k]) == old_id){
          return(chr_ref$chr_num[k])
        }
      }
    }else{
      if (type == "1_to_1A"){
        old_id <- as.character(data)
        for (k in 1:nrow(chr_ref)){
          if (as.character(chr_ref$chr_num[k]) == old_id){
            new <- paste0(chr_ref$atom7[k],chr_ref$atom3[k],sep="")
            return(new)
          }
        }
      }else{
        if (type == "1A_to_1"){
          old_id <- as.character(data)
          for (k in 1:nrow(chr_ref)){
            temp <- paste0(chr_ref$atom7[k],chr_ref$atom3[k],sep="")
            if (as.character(temp) == old_id){
              return(chr_ref$chr_num[k])
            }
          }
        }else{
        print("Please input again! type inaviably")
        }
      }
    }
  }
}
    
for (i in 1:nrow(df)){
  df$Chromosome[i] <- chr_id_translate(df$Chromosome[i],"1A_to_1")
}


s_1 <- min(df$Position)
s_2 <- max(df$Position)
s_1 <- s_1 - 500
s_2 <- s_2 + 500
region <- paste0(df$Chromosome[1],":",s_1,":",s_2)
write.table(region,paste0("./09_out_MLM/",job,phe,".region.txt"),quote = F,col.names = F,row.names = F)

###  生成新文件，染色体-位置-P值 =============================================================
df_new <- df[,2:4]
file_new <- paste0("./09_out_MLM/",job,"_MLM.",phe,".GWAS.Results.csv",sep="")
write_csv(df_new,file_new,col_names=F)
### FarmCPU结果 ====================================================================
dir_FarmCPU <- paste0("FarmCPU_",job)
file_name <- paste0("/GAPIT.FarmCPU.",phe,".GWAS.Results.csv")
# job <- "GAPIT.Association.GWAS_Results.MLM.X19NYH.csv"
df <- read.csv(paste0("./08_out_GWAS/",dir_FarmCPU,file_name),header = T)

###  替换染色体展示方式，1A_to_1 ===========================================================
chr_ref <- read.table("01_scripts/chr_num2str.txt",header = T)
chr_id_translate <- function(data,type){
  # 输入俩参，一为原始数据，二为类型
  if (type == "1_to_chr1A"){
    # 数字转字符型
    old_id <- as.character(data)
    for (k in 1:nrow(chr_ref)){
      if (as.character(chr_ref$chr_num[k]) == old_id){
        return(chr_ref$chr_str[k])
      }
    }
  }else{
    if (type == "chr1A_to_1"){
      # 字符转数字型
      old_id <- as.character(data)
      for (k in 1:nrow(chr_ref)){
        if (as.character(chr_ref$chr_str[k]) == old_id){
          return(chr_ref$chr_num[k])
        }
      }
    }else{
      if (type == "1_to_1A"){
        old_id <- as.character(data)
        for (k in 1:nrow(chr_ref)){
          if (as.character(chr_ref$chr_num[k]) == old_id){
            new <- paste0(chr_ref$atom7[k],chr_ref$atom3[k],sep="")
            return(new)
          }
        }
      }else{
        if (type == "1A_to_1"){
          old_id <- as.character(data)
          for (k in 1:nrow(chr_ref)){
            temp <- paste0(chr_ref$atom7[k],chr_ref$atom3[k],sep="")
            if (as.character(temp) == old_id){
              return(chr_ref$chr_num[k])
            }
          }
        }else{
          print("Please input again! type inaviably")
        }
      }
    }
  }
}

for (i in 1:nrow(df)){
  df$Chromosome[i] <- chr_id_translate(df$Chromosome[i],"1A_to_1")
}

s_1 <- min(df$Position)
s_2 <- max(df$Position)
s_1 <- s_1 - 500
s_2 <- s_2 + 500
region <- paste0(df$Chromosome[1],":",s_1,":",s_2)
write.table(region,paste0("./10_out_FarmCPU/",job,phe,".region.txt"),quote = F,col.names = F,row.names = F)

###  生成新文件，染色体-位置-P值 =============================================================
df_new <- df[,2:4]
file_new <- paste0("./10_out_FarmCPU/",job,"_FarmCPU.",phe,".GWAS.Results.csv",sep="")
write_csv(df_new,file_new,col_names=F)
print(paste0(job,"GWAS results finished!"))

