# 转化hmp.txt文件并整理表型数据
rm(list = ls())
library(tidyverse)

ARGS <- commandArgs(T)
print(paste0("Working Gene ID:",ARGS[1]))
job <- ARGS[1]

chr_ref <- read.table("01_scripts/chr_num2str.txt",header = T)
df <- read_table(paste0("04_hmp/gene_",job,".hmp.txt"),show_col_types = F)
trait <- read_table(paste0("05_trait/","trait.txt"),show_col_types = F)

### 染色体格式转换 ======================================================================
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
        print("Please input again! type inaviably")
      }
    }
  }
}

for (i in 1:nrow(df)){
  df$chrom[i] <- chr_id_translate(df$chrom[i],type = "1_to_1A")
}

# 基因型文件和表型文件的筛选与匹配,只取一致
df2 <- rbind(colnames(df),df)
df_gene <- t(df2)
df_add_gene <- matrix(ncol = ncol(df_gene))
df_add_gene <- df_add_gene[-1,]
df_add_trait <- matrix(ncol = ncol(trait))
df_add_trait <- df_add_trait[-1,]
df_gene <- as.data.frame(df_gene)
### 提取同时存在于基因型和表型的数据 =============================================================
for (i in 1:nrow(df_gene)){
  id_gene <- df_gene$V1[i]
  for (k in 1:nrow(trait)){
    id_trait <- trait$ID[k]
    if (id_gene == id_trait){
      my_gene <- df_gene[i,]
      my_trait <- trait[k,]
      df_add_gene <- rbind(df_add_gene,my_gene)
      df_add_trait <- rbind(df_add_trait,my_trait)
    }else{
      next
    }
  }
}

### 基因型和表型文件整理 ===================================================================
out_gene <- rbind(df_gene[1:11,],df_add_gene)
out_genet <- t(out_gene)
gene_final <- as.data.frame(out_genet)
write.table(gene_final,paste0("./06_out_gene/",job,".gene.hmp.txt"),
            quote = F,sep = "\t",col.names = F,row.names = F)
trait_final <- as.data.frame(df_add_trait)

write.table(trait_final,paste0("./07_out_trait/",job,".trait.txt"),
            quote = F,sep = "\t",col.names = T,row.names = F)
print(paste0(job," hmp and trait formate finished!"))
