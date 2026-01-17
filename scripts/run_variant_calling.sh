#!/bin/bash
# scripts/run_variant_calling.sh
# Purpose: Generate raw VCF from BAM files using bcftools

# Load config
CONFIG_FILE="../config.yaml"
REF_FA=$(yq e '.reference.fa' $CONFIG_FILE)
BAM_DIR=$(yq e '.bam_dir' $CONFIG_FILE)
OUT_DIR=$(yq e '.results_dir' $CONFIG_FILE)

mkdir -p $OUT_DIR

# List BAM files
BAMS=$(ls $BAM_DIR/*.bam | tr '\n' ' ')

# Run bcftools mpileup and call
bcftools mpileup -f $REF_FA $BAMS | \
bcftools call -mv -Ov -o $OUT_DIR/variants.vcf

echo "Variant calling complete. Output: $OUT_DIR/variants.vcf"
