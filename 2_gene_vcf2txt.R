# VCF文件批量处理-单基因关联分析
# by：Jewin

rm(list = ls())

library(tidyverse)
library(vcfR)
library(do)
library(R.utils)

# 参数获取
ARGS <- commandArgs(T)
print(paste0("Working Gene ID:",ARGS[1]))

### 读取原始数据 =======================================================================
job <- ARGS[1]
gunzip(paste0("02_ordata/",job,".filter.vcf.gz"), remove = F)
df <- read.table(paste0("02_ordata/",job,".filter.vcf"),header = F)
vcf <- read.vcfR(paste0("02_ordata/",job,".filter.vcf.gz"))
chr_ref <- read.table("01_scripts/chr_num2str.txt",header = T)

fix <- vcf@fix
gt <- vcf@gt
meta <- vcf@meta

### 批量替换“|”为“/” ==================================================================
df[df == "0|0"] = "0/0"
df[df == "1|0"] = "1/0"
df[df == "0|1"] = "0/1"
df[df == "1|1"] = "1/1"
colnames(df) <- c(colnames(fix),colnames(gt))

###  替换染色体格式 =====================================================================
for (i in 1:nrow(df)){
  old_chr <- df$CHROM[i]
  for (k in 1:nrow(chr_ref)){
    if (chr_ref$chr_str[k] == old_chr){
      new_chr <- chr_ref$chr_num[k]
      df$CHROM[i] <- new_chr
    }
  }
}

###  SNP位点处理 =====================================================================

snp_reverse <- function(one,more){
  # 输入俩参，一为单二为多，返回存在于多但不与单同之值
  list_snp <- str_split(more,"")
  for (i in 1:str_length(more)){
    snp_now <- list_snp[[1]][i]
    ifelse(one==snp_now,next,return(snp_now))
  }
}

# 对每行的REF和ALT进行处理，将其变成不同值
for (i in 1:nrow(df)){
  ref <- df$REF[i]
  alt <- df$ALT[i]
  # 情况有三，均为单或其一为多
  if (str_length(ref) == 1){
    if (str_length(alt) == 1){
    }else{
      df$ALT[i] <- snp_reverse(ref,alt)
    }
  }else{
    if (str_length(alt) == 1){
      df$REF[i] <- snp_reverse(alt,ref)
    }else{
      print(paste0("ERROR：",df$ID[i]," this snp has more REF、ALT !"))
    }
  }
}

colnames(df)[1] <- "#CHROM"
write.table(df,paste0("03_vcf2txt/","gene_",job,".txt"),
            sep = "\t",row.names = F,col.names = T,quote = F)
print(paste0(job," Step ordata gene vcf to txt finished!"))
