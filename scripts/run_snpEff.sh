#!/bin/bash
# scripts/run_snpeff.sh
# Purpose: Annotate VCF using snpEff

CONFIG_FILE="../config.yaml"
SNPEFF_DIR=$(yq e '.snpeff_dir' $CONFIG_FILE)
GENOME=$(yq e '.snpeff_genome' $CONFIG_FILE)
VCF_IN=$(yq e '.results_dir' $CONFIG_FILE)/variants.vcf
VCF_OUT=$(yq e '.results_dir' $CONFIG_FILE)/variants_annotated.vcf

java -Xmx4g -jar $SNPEFF_DIR/snpEff.jar -v $GENOME $VCF_IN > $VCF_OUT

echo "Annotation complete. Output: $VCF_OUT"
