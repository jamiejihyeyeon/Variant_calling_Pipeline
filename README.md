# Variant Calling and Annotation Pipeline (C. elegans)

This repository contains a reproducible pipeline for:
- Variant calling from BAM files
- Functional annotation using a custom SnpEff database
- Comparative genotype analysis between strains

## Biological context
Variants are called relative to the WBcel235 reference genome and compared
between the laboratory strain N2 and the wildstrain ECA712.

## Pipeline overview
1. Variant calling with bcftools
2. Functional annotation with SnpEff
3. Post-processing and classification of strain-specific variants

## Outputs
- Annotated VCF file
- CSV summarizing gene-level impacts and strain-specific variants

## Requirements
- bcftools >= 1.19
- Java >= 11
- Python >= 3.10
- pandas, cyvcf2

## How to run
```bash
bash scripts/01_variant_calling.sh
bash scripts/02_snpeff_annotation.sh
python scripts/03_postprocess_variants.py
