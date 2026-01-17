# Variant Analysis of *Caenorhabditis elegans* N2 and ECA712

## Overview

This repository contains a reproducible bioinformatics pipeline for identifying and annotating genomic variants between the *Caenorhabditis elegans* wild-type strain **N2** and the mutant strain **ECA712**.

The workflow includes variant calling from aligned reads (BAM input), functional annotation using **snpEff**, and downstream post-processing to classify strain-specific and shared variants.

The pipeline follows best practices for reproducibility, modularity, and transparency, and is suitable for both academic and industry bioinformatics environments.

---

## Reference Genome and Annotation

- **Genome build:** WBcel235  
- **Reference FASTA:** Ensembl release 115 (`dna.toplevel.fa`)  
- **Gene annotation:** Ensembl GTF (release 115)  
- **CDS and protein sequences:** Ensembl CDS and peptide FASTA files  

All annotation resources are derived from Ensembl and integrated into a locally built snpEff database.

---

## Pipeline Summary

### 1. Variant Calling

Variants are called jointly from BAM files using `bcftools mpileup` and `bcftools call`, with **N2 treated as the reference/control strain**.

### 2. Variant Annotation

Variants are annotated using **snpEff v5.4** with a locally built WBcel235 database that includes:

- Gene models (GTF)
- Coding sequences (CDS)
- Protein sequences

Functional impact categories (**HIGH**, **MODERATE**, **LOW**, **MODIFIER**) are assigned according to snpEff definitions.

### 3. Post-processing and Classification

Annotated variants are parsed using Python and classified into:

- **ECA_only:** Variant present only in ECA712  
- **Shared:** Variant present in both N2 and ECA712  
- **N2_only:** Variant present only in N2  

Final results are exported as a CSV file for downstream analysis and visualization.

---

## Repository Structure
```
  variant-analysis/
  ├── environment.yaml          # Conda environment definition
  ├── config.yaml               # Pipeline configuration
  ├── README.md                 # Project documentation
  ├── data/
  │   ├── bam/                  # BAM and index files
  │   └── reference/            # Reference genome and annotations
  ├── snpEff/                   # Local snpEff installation and database
  ├── scripts/
  │   ├── run_variant_calling.sh
  │   ├── run_snpeff.sh
  │    └── postprocess_variants.py
  └── results/
      ├── variants.vcf
      ├── variants_annotated.vcf
      └── variants_annotated_type.csv
```


## Environment Setup

This pipeline was developed and tested in a Linux environment (WSL2) using Conda for reproducible dependency management.

### 1. Create the Conda environment

```bash
conda env create -f environment.yaml
conda activate variant_calling
```
The environment.yaml file specifies all required software versions, including:
- bcftools
- samtools
- java (for snpEff)
- python (with pandas, cyvcf2, numpy)

### 2. Verify installation

```bash
bcftools --version
samtools --version
java -version
python --version
```

All commands should execute without errors.

---
## Running the Pipeline

All parameters and file paths are defined in `config.yaml`.  
The workflow consists of variant calling, functional annotation, and post-processing.

### 1. Variant Calling (BAM → VCF)

Generate raw variants from aligned BAM files using bcftools:

```bash
bash scripts/run_variant_calling.sh
```
This step:

- Uses the reference genome specified in config.yaml
- Calls variants jointly across all samples
- Produces an unannotated VCF file

### 2. Variant Annotation with snpEff
Annotate variants to predict functional and protein-level effects:

```bash
bash scripts/run_snpeff.sh
```
This step:

- Uses a locally built snpEff database (WBcel235)
- Annotates variants with gene, transcript, and impact information
- Produces an annotated VCF file

### 3. Post-processing and Classification 
Convert the annotated VCF to tabular format and classify variants by sample genotype:

```bash
python scripts/postprocess_variants.py
```

This step:

- Extracts key annotation fields (gene, effect, impact)
- Classifies variants as sample-specific or shared
- Outputs a final CSV file for downstream analysis



## Output Files 

All results are written to the results/ directory.

### Variants

| File                          | Description                                                  |
| ----------------------------- | ------------------------------------------------------------ |
| `variants.vcf`                | Raw variant calls from bcftools                              |
| `variants_annotated.vcf`      | Functionally annotated variants (snpEff)                     |
| `variants_annotated_type.csv` | Tabular summary with gene, impact, and strain classification |

### snpEFf Reports

| File                  | Description                      |
| --------------------- | -------------------------------- |
| `snpEff_summary.html` | snpEff annotation summary report |
| `snpEff_genes.txt`    | Per-gene variant statistics      |


These outputs can be directly used for: 
- Candidate gene identification
- Functional impact filtering (e.g. HIGH / MODERATE)
- Comparative variant analysis between strains





