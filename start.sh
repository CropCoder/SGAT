#! /usr/bin/bash
# 使用说明：将待处理基因的vcf.gz文件(例如TraesCS5A03G0826500.filiter.vcf.gz)放在02_ordata
#          表型文件(名称trait.txt)放在05_trait
#          第一个参数填基因ID
conda activate work
. ./clearn.sh
cd .. #回到主目录

# 0.检查配置文件
Rscript ./01_scripts/1_check.R
cat ./01_scripts/0_README.md
sleep 5
#这里修改基因ID信息
list_gene=`cat ./01_scripts/list_gene.txt`

#这里修改表型信息
list_phe=`cat ./01_scripts/list_phe.txt`
for geneid in ${list_gene[@]}
do
echo ${geneid}############################################


# 1.转换vcf文件
Rscript ./01_scripts/2_gene_vcf2txt.R ${geneid}

# 2.plink：转换vcf整理后的txt文件为map和ped格式
pk_1="./03_vcf2txt/gene_${geneid}.txt"
pk_2="./03_vcf2txt/gene_${geneid}"

/home/software/plink --vcf ${pk_1} --recode --out ${pk_2}

# 3.tassel:将ped和map文件转为hmp.txt并移动至04文件夹
ta_1="./03_vcf2txt/gene_${geneid}.ped"
ta_2="./03_vcf2txt/gene_${geneid}.map"
ta_3="./03_vcf2txt/gene_${geneid}"
/home/software/tassel-5-standalone/run_pipeline.pl -fork1 -plink -ped ${ta_1} -map ${ta_2} -export ${ta_3} -exportType Hapmap -runfork1

cp ./03_vcf2txt/*hmp.txt ./04_hmp/


# 4.转换hmp和trait文件，进行匹配筛选
Rscript ./01_scripts/3_hmp_trait_formate.R ${geneid}

# 5.GWAS分析
Rscript ./01_scripts/4_GWAS_gapit.R ${geneid}

# 6.粗略绘图
L_1="./03_vcf2txt/gene_${geneid}.txt"

# FarmCPU模型
for phe in ${list_phe[@]}
do
Rscript ./01_scripts/5_GWAS_results_translate.R ${geneid} ${phe}
p_1="./11_out_LDB_raw/gene_${geneid}_FarmCPU_${phe}_LDBlockShow.out"
p_2="./10_out_FarmCPU/${geneid}_FarmCPU.${phe}.GWAS.Results.csv"
p_3=$(head -n 1 ./10_out_FarmCPU/${geneid}${phe}.region.txt)
/home/software/LDBlockShow-1.40/bin/LDBlockShow -InVCF ${L_1} -OutPut ${p_1} -InGWAS ${p_2} -Region ${p_3} -OutPng -OutPdf -SeleVar 4 -TopSite
p_4="./12_out_LDB_final/${geneid}_FarmCPU_${phe}_LDBlockShow.out.svg"
/home/software/LDBlockShow-1.40/bin/ShowLDSVG -InPreFix ${p_1} -OutPut ${p_4} -InGWAS ${p_2} -Cutline 7 -crBegin 150,215,249 -crMiddle 042,170,239 -crEnd 247,077,077 -OutPng -OutPdf -TopSite
echo "finished! ${p_4}"
done

# MLM模型
for phe in ${list_phe[@]}
do
Rscript ./01_scripts/5_GWAS_results_translate.R ${geneid} ${phe}
p_1="./11_out_LDB_raw/gene_${geneid}_MLM_${phe}_LDBlockShow.out"
p_2="./09_out_MLM/${geneid}_MLM.${phe}.GWAS.Results.csv"
p_3=$(head -n 1 ./09_out_MLM/${geneid}${phe}.region.txt)
/home/software/LDBlockShow-1.40/bin/LDBlockShow -InVCF ${L_1} -OutPut ${p_1} -InGWAS ${p_2} -Region ${p_3} -OutPng -OutPdf -SeleVar 4 -TopSite
p_4="./12_out_LDB_final/${geneid}_MLM_${phe}_LDBlockShow.out.svg"
/home/software/LDBlockShow-1.40/bin/ShowLDSVG -InPreFix ${p_1} -OutPut ${p_4} -InGWAS ${p_2} -Cutline 7 -crBegin 150,215,249 -crMiddle 042,170,239 -crEnd 247,077,077 -OutPng -OutPdf -TopSite
echo "finished! ${p_4}"
done

cp ./08_out_GWAS/MLM_${geneid}/*.GWAS.Results.csv ./result/
cp ./08_out_GWAS/FarmCPU_${geneid}/*.GWAS.Results.csv ./result/
cp ./12_out_LDB_final/${geneid}*.svg ./result/
cp ./12_out_LDB_final/${geneid}*.png ./result/
cp ./12_out_LDB_final/${geneid}*.pdf ./result/

cd result/
zip -m ../14_final_zip/${geneid}_result.zip ./*
cd ..
echo "${geneid}:all finished! OK"
done

cd 01_scripts/






