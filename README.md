# SGAT:Single Gene Association analysis Tool # SGAT:Single Gene Association analysis Tool
Single gene association analysis tool
---

> Design by Jewel [wechat official account: Shengxin Analysis Notes]

## How to use:
1. Put all genotype files in folder 02
For example, "TraesCS5A03G0123456. Filter. VCF. Gz
2. Store the phenotype file in folder 05 and name it trait.txt
The first column name is called ID, and each subsequent column represents a phenotype, such as "HT32L".
3. Software automatically identifies gene and phenotype information
4. Run the.. /start.sh command in the current folder.
5. Results will be generated later
6. To initialize and clear the workspace, run ".. /clearn.sh".

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

Version update: V1.3.1
1. Improved fuzzy search algorithm to provide more accurate recognition rate
2. Added the function of result summary and collation to summarize and display the results of GWAS and T test

> Function Introduction: The automated program can perform batch single gene association analysis according to the original documents of genotype and phenotype provided, draw linkage unbalance map according to the results of GWAS, automatically identify the gene list and phenotype list through the algorithm, screen and transform the genotype files, generate ped, MAP, hmp and other formats, and automatically modify the chromosome format. GAPIT is used for GWAS analysis, supporting custom statistical model, and the results are refined and mapped.

Project development background

Single Gene Association Analysis is a genetic and biostatistical method used to study the relationship between genes and specific phenotypes. This method usually studies whether different allele of a gene is related to the rate of change of this phenotype.

In single gene association analysis, different allele frequencies from different populations are usually compared. If an allele appears significantly more frequently in the treatment group than in the control group, the allele can be considered associated with a particular phenotype.

The association may result in functional variants, such as a single nucleotide polymorphism (SNP), It may also result from a linkage disequilibrium, which is the association of a locus with one or more unknown loci.

Single gene association analysis has a wide range of applications, in medicine, agriculture, animal and plant genetics and other fields have been widely used! Traditional manual single-gene association analysis needs to start from the VCF file, modify the genotype file, convert the file format through plink and taseel software, manually modify the variation information, sort out the phenotype and genotype and match each other, and gradually conduct GWAS analysis and map according to the results. The whole process is time-consuming and laborious, and prone to errors.

Therefore, we developed an automated single gene association analysis program, which can complete all steps with only one command, and classify different types of result files. The output is the final result, and the accuracy of the result is more than 99%.

## Core function introduction

- Automatic identification and replacement of variation information
- Chromosome number conversion
- Genotype file conversion
- Phenotype and genotype matching screening
- Perform multi-model GWAS analysis in batches
- Linkage unbalance mapping

## Customized development

- GWAS analysis model selection: The default value is MLM and FarmCPU. Ten modes are supported
- Range length: 500bp upstream and downstream by default. Free customization is supported
Single gene association analysis tool
---

> Design by Jewel [wechat official account: Shengxin Analysis Notes]

## How to use:
1. Put all genotype files in folder 02
For example, "TraesCS5A03G0123456. Filter. VCF. Gz
2. Store the phenotype file in folder 05 and name it trait.txt
The first column name is called ID, and each subsequent column represents a phenotype, such as "HT32L".
3. Software automatically identifies gene and phenotype information
4. Run the.. /start.sh command in the current folder.
5. Results will be generated later
6. To initialize and clear the workspace, run ".. /clearn.sh".

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

Version update: V1.3.1
1. Improved fuzzy search algorithm to provide more accurate recognition rate
2. Added the function of result summary and collation to summarize and display the results of GWAS and T test

> Function Introduction: The automated program can perform batch single gene association analysis according to the original documents of genotype and phenotype provided, draw linkage unbalance map according to the results of GWAS, automatically identify the gene list and phenotype list through the algorithm, screen and transform the genotype files, generate ped, MAP, hmp and other formats, and automatically modify the chromosome format. GAPIT is used for GWAS analysis, supporting custom statistical model, and the results are refined and mapped.

Project development background

Single Gene Association Analysis is a genetic and biostatistical method used to study the relationship between genes and specific phenotypes. This method usually studies whether different allele of a gene is related to the rate of change of this phenotype.

In single gene association analysis, different allele frequencies from different populations are usually compared. If an allele appears significantly more frequently in the treatment group than in the control group, the allele can be considered associated with a particular phenotype.

The association may result in functional variants, such as a single nucleotide polymorphism (SNP), It may also result from a linkage disequilibrium, which is the association of a locus with one or more unknown loci.

Single gene association analysis has a wide range of applications, in medicine, agriculture, animal and plant genetics and other fields have been widely used! Traditional manual single-gene association analysis needs to start from the VCF file, modify the genotype file, convert the file format through plink and taseel software, manually modify the variation information, sort out the phenotype and genotype and match each other, and gradually conduct GWAS analysis and map according to the results. The whole process is time-consuming and laborious, and prone to errors.

Therefore, we developed an automated single gene association analysis program, which can complete all steps with only one command, and classify different types of result files. The output is the final result, and the accuracy of the result is more than 99%.

## Core function introduction

- Automatic identification and replacement of variation information
- Chromosome number conversion
- Genotype file conversion
- Phenotype and genotype matching screening
- Perform multi-model GWAS analysis in batches
- Linkage unbalance mapping

## Customized development

- GWAS analysis model selection: The default value is MLM and FarmCPU. Ten modes are supported
- Range length: 500bp upstream and downstream by default. Free customization is supported
# SGAT:Single Gene Association analysis Tool 
# 单基因关联分析工具
---

> Design by Jewel 【微信公众号：生信分析笔记】

## 使用方法：
1. 将所有的基因型文件放在02文件夹中                   
  例如"TraesCS5A03G0123456.filter.vcf.gz
2. 将表型文件放在05文件夹中，命名为trait.txt          
  第一列名称为ID，后面每一列代表一个表型，例如"HT32L"      
3. 软件自动识别基因与表型信息                       
4. 在当前文件夹下执行". ./start.sh"             
5. 结果将在后续生成                            
6. 初始化与清除工作空间请执行". ./clearn.sh"        

#################################################################

## 版本更新：V1.3.1
 1. 改进了模糊搜索算法，提供更加精准的识别率
 2. 增加了结果汇总整理功能，将GWAS与T检验的结果汇总展示

> 功能简介：该自动化程序能够根据提供的基因型和表型原始文件进行批量单基因关联分析，并根据GWAS的结果绘制连锁不平衡图，通过算法自动识别基因列表和表型列表，并对基因型文件进行筛选转化，生成ped、map、hmp等格式，自动化修改染色体格式，通过GAPIT进行GWAS分析，支持自定义统计模型，并对结果进行精细修饰作图。

## 项目开发背景

单基因关联分析（Single Gene Association Analysis）是一种遗传学和生物统计学方法，用于研究基因与特定表型之间的关系。该方法通常是研究一个基因的不同等位基因（allele）是否与这个表型的变化率有关。

在单基因关联分析中，通常比较来自不同群体的不同等位基因频率。如果某个等位基因在处理组中出现的频率显著高于对照组，则可以认为该等位基因与特定表型相关联。

这种关联可能由于功能变异（functional variants）产生，例如一个单核苷酸多态性（single nucleotide polymorphism, SNP），也可能由于连锁不平衡（linkage disequilibrium）产生，即该基因位点与一个或多个未知位点之间的关联。

单基因关联分析具有广泛应用，在医学、农业、动植物遗传学等领域都得到了广泛的应用！传统方式人工进行单基因关联分析需要从VCF文件开始，修改基因型文件，经过plink和taseel等软件转换文件格式，并手动修改变异信息，整理表型和基因型并互相匹配，逐步进行GWAS分析并根据结果作图，整个过程费时费力，而且极易出错。

因此，开发了自动化单基因关联分析程序，只需一条命令即可完成所有步骤，并分类整理不同类型的结果文件，输出为最终结果，成果准确度99%以上。

## 核心功能介绍

- 变异信息自动识别与替换
- 染色体编号转换
- 基因型文件转换
- 表型与基因型匹配筛选
- 批量进行多模型GWAS分析
- 连锁不平衡作图

## 定制化开发

- GWAS分析模型选择：默认为MLM和FarmCPU，支持10种模式自由选择
- 区间长度选择：默认上下游500bp，支持自由定制修改

