# Package index

## Targets

Build a simple {targets} project

- [`populate_targets_proj()`](https://mglev1n.github.io/levinmisc/reference/populate_targets_proj.md)
  : Create a minimal targets template in the current project
- [`use_crew_lsf()`](https://mglev1n.github.io/levinmisc/reference/use_crew_lsf.md)
  **\[experimental\]** : Use crew lsf to execute a targets pipeline
  using the LSF HPC scheduler

## Genomics

Genomics utility functions and wrappers around other
tools/programs/packages to perform GWAS meta-analysis, fine-mapping,
colocalization, and more.

### Annotation

Functions that are useful for annotating GWAS summary statistics

- [`annotate_rsids()`](https://mglev1n.github.io/levinmisc/reference/annotate_rsids.md)
  : Annotate a dataframe containing genomic coordinates with rsids

### GWAS

Functions that are useful for performing GWAS/GWAS meta-analysis

- [`metal_config()`](https://mglev1n.github.io/levinmisc/reference/metal_config.md)
  : Create a configuration file for METAL
- [`metal_run()`](https://mglev1n.github.io/levinmisc/reference/metal_run.md)
  : Use METAL to run a GWAS meta-analysis
- [`mr_mega()`](https://mglev1n.github.io/levinmisc/reference/mr_mega.md)
  : Perform multi-ancestry GWAS meta-analysis using MR-MEGA

### Linkage disequilibrium

Functions that are useful for linkage disequilibrium

- [`plink_extract_ld()`](https://mglev1n.github.io/levinmisc/reference/plink_extract_ld.md)
  : Extract an LD matrix from a reference panel using plink 1.9

### Colocalization

Functions that are useful for performing colocalization. Colocalization
is a technique for evaluating the evidence supporting the presence of
shared causal variant(s) at a given locus across two or more traits.
Several methods of colocalization have been described, which generally
leverage GWAS summary statistics across multiple traits. The methods use
either proportional or enumeration approaches, which make different
assumptions and test different hypotheses.

- [`coloc_run()`](https://mglev1n.github.io/levinmisc/reference/coloc_run.md)
  : Run Bayesian enumeration colocalization using Coloc
- [`hyprcoloc_df()`](https://mglev1n.github.io/levinmisc/reference/hyprcoloc_df.md)
  : Run multi-trait colocalization using HyPrColoc

### Finemapping

Functions that are useful for finemapping. Finemapping is an approach
for identifying the putative causal variant(s) at a locus identified in
a GWAS. Like colocalization, finemapping methods make different
assumptions about the configuration of causal variant(s) at the locus.

- [`calc_credset()`](https://mglev1n.github.io/levinmisc/reference/calc_credset.md)
  : Perform Bayesian finemapping using the Approximate Bayes Factor
  approach

### Heritability

Functions that are useful for estimating heritability. Several tools for
performing heritability estimation using GWAS summary statistics have
been developed, including LDSC and LDAK. The
[ldscr](https://mglev1n.github.io/ldscr/) package provides a native R
implemtation of LDSC.

- [`ldak_h2()`](https://mglev1n.github.io/levinmisc/reference/ldak_h2.md)
  : Calculate heritability using LDAK

### TWAS/Gene-based testing

Functions that are useful for identifying trait-associated genes from
GWAS.

- [`s_multixcan()`](https://mglev1n.github.io/levinmisc/reference/s_multixcan.md)
  : Integrate PrediXcan data across tissues
- [`s_predixcan()`](https://mglev1n.github.io/levinmisc/reference/s_predixcan.md)
  : Run a TWAS using S-PrediXcan
- [`magmar()`](https://mglev1n.github.io/levinmisc/reference/magmar.md)
  : Run MAGMA gene-based analysis

## Miscellaneous

Miscellaneous functions useful for manipulating/presenting data.

- [`render_datatable()`](https://mglev1n.github.io/levinmisc/reference/render_datatable.md)
  : Render DataTable to HTML
- [`gg_manhattan_df()`](https://mglev1n.github.io/levinmisc/reference/gg_manhattan_df.md)
  : Create a Manhattan Plot
- [`gg_qq_df()`](https://mglev1n.github.io/levinmisc/reference/gg_qq_df.md)
  : Create a QQ plot
- [`annotate_rsids()`](https://mglev1n.github.io/levinmisc/reference/annotate_rsids.md)
  : Annotate a dataframe containing genomic coordinates with rsids
- [`calc_credset()`](https://mglev1n.github.io/levinmisc/reference/calc_credset.md)
  : Perform Bayesian finemapping using the Approximate Bayes Factor
  approach
- [`coloc_run()`](https://mglev1n.github.io/levinmisc/reference/coloc_run.md)
  : Run Bayesian enumeration colocalization using Coloc
- [`hyprcoloc_df()`](https://mglev1n.github.io/levinmisc/reference/hyprcoloc_df.md)
  : Run multi-trait colocalization using HyPrColoc
- [`magmar()`](https://mglev1n.github.io/levinmisc/reference/magmar.md)
  : Run MAGMA gene-based analysis
- [`metal_config()`](https://mglev1n.github.io/levinmisc/reference/metal_config.md)
  : Create a configuration file for METAL
- [`metal_run()`](https://mglev1n.github.io/levinmisc/reference/metal_run.md)
  : Use METAL to run a GWAS meta-analysis
- [`mr_mega()`](https://mglev1n.github.io/levinmisc/reference/mr_mega.md)
  : Perform multi-ancestry GWAS meta-analysis using MR-MEGA
