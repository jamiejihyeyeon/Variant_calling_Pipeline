#!/usr/bin/env python3
# scripts/postprocess_variants.py
# Purpose: Parse annotated VCF, extract key info, classify variants

import yaml
import pandas as pd
from cyvcf2 import VCF

# Load config
with open("../config.yaml") as f:
    config = yaml.safe_load(f)

vcf_file = f"{config['results_dir']}/variants_annotated.vcf"
csv_out = f"{config['results_dir']}/variants_annotated_type.csv"

# Read VCF
vcf = VCF(vcf_file)
records = []

for var in vcf:
    ann_field = var.INFO.get("ANN")
    if ann_field:
        ann = ann_field.split(",")[0].split("|")
        records.append({
            "CHROM": var.CHROM,
            "POS": var.POS,
            "REF": var.REF,
            "ALT": var.ALT[0],
            "Allele": ann[0],
            "Effect": ann[1],
            "Impact": ann[2],
            "Gene": ann[3],
            "Gene_ID": ann[4],
            "N2_GT": var.genotypes[0][:2],
            "ECA712_GT": var.genotypes[1][:2]
        })

df = pd.DataFrame(records)

# Classify variants
df['Variant_Type'] = df.apply(
    lambda row: 'ECA_only' if row['N2_GT'] == [0,0] and row['ECA712_GT'] != [0,0]
    else 'Shared' if row['N2_GT'] != [0,0] and row['ECA712_GT'] != [0,0]
    else 'Other', axis=1
)

df.to_csv(csv_out, index=False)
print(f"Post-processing complete. Output: {csv_out}")
