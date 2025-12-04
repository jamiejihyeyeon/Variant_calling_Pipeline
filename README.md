# Variant_calling_Pipeline
Variant calling project using C. elegans SRA data from PRJNA987746 (PMID:37572357; Yeon_et al)

# Variant Calling Pipeline  
Variant calling workflow for PRJNA987746 (CC1 RILs WGS).  
This project demonstrates a complete NGS processing pipeline using Linux, SRA Toolkit, BWA, Samtools, and BCFtools.

## ✨ Workflow Overview
1. Download SRA files from ENA → FASTQ  
2. Quality control (FastQC)  
3. Alignment to C. elegans reference genome (ce11)  
4. Sorting, indexing  
5. Marking duplicates  
6. Variant calling using BCFtools  
7. Output VCFs + QC summaries  

## 🧬 Dataset
NCBI BioProject **PRJNA987746**  
Total **6 runs** (SRR25082167–SRR25082172)

## 📁 Directory Structure
