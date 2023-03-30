#! /usr/bin/bash
# 功能：对之前步骤产生了GWAS结果和图片进行汇总打包
conda activate work
cd .. #回到主目录
cat ./01_scripts/0_README.md
list_gene=`head -10 ./01_scripts/list_gene.txt`
for geneid in ${list_gene[@]}
do
echo ${geneid}############################################
Rscript ./01_scripts/6_GWAS_Ttest_Result.R ${geneid}
cp ./12_out_LDB_final/${geneid}*.png ./temp/
cp ./16_out_GWAS_and_T/${geneid}*.xlsx ./temp/
done
