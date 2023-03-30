#! /usr/bin/bash
cd ..
rm -rf ./01_scripts/list_gene.txt
rm -rf ./01_scripts/list_phe.txt
rm -rf ./02_ordata/*.vcf
rm -rf ./02_ordata/*.region.txt
rm -rf ./03_vcf2txt/*
rm -rf ./04_hmp/*
rm -rf ./06_out_gene/*
rm -rf ./07_out_trait/*
rm -rf ./08_out_GWAS/*
rm -rf ./09_out_MLM/*
rm -rf ./10_out_FarmCPU/*
rm -rf ./11_out_LDB_raw/*
rm -rf ./12_out_LDB_final/*
rm -rf ./13_final_out/*

cd ./01_scripts/
echo "delate all output data!  clean finished!"

