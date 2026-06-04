# Analysis of Unannotated Expressed Regions in Transcriptomic Data from *Mycobacterium abscessus*

## Overview

This repository contains the scripts, supplementary materials, figures, and analysis outputs used to investigate unannotated expressed regions and non-coding RNAs (ncRNAs) in RNA-seq data from *Mycobacterium abscessus*. The project implements a reproducible transcriptomic analysis workflow, from raw sequencing data processing through differential expression analysis and ncRNA discovery.

The pipeline combines quality control, read alignment, transcript quantification, novel ncRNA identification using BaerHunter, and differential expression analysis using DESeq2.

### Key Features

- RNA-seq quality assessment and preprocessing
- Read trimming and filtering
- Genome alignment and mapping statistics
- Novel ncRNA identification using BaerHunter
- Transcript abundance quantification
- Differential expression analysis using DESeq2
- Publication-ready visualisations and figures
- Reproducible analysis workflow

---

## Project Structure

```text
├── data/                 # Input and processed data
├── scripts/              # Analysis scripts
├── figures/              # Generated figures and plots
├── results/              # Differential expression and ncRNA results
├── supplementary/        # Supplementary tables and metadata
└── README.md
```

---

## Analysis Workflow

The transcriptomic analysis pipeline consists of the following stages:

1. Quality control of raw sequencing reads using FastQC
2. Adapter removal and quality trimming using Fastp
3. Alignment of reads to the reference genome using BWA
4. BAM file processing and manipulation using Samtools
5. Identification of novel non-coding RNAs using BaerHunter
6. Quantification of transcript abundance
7. Differential expression analysis using DESeq2
8. Data visualisation and figure generation

---

## Software Requirements

The analysis was performed using:

### Core Software

- Python ≥ 3.6
- R ≥ 4.0.0
- FastQC
- Fastp
- BWA
- Samtools
- BaerHunter

### R Packages

- DESeq2
- ggplot2
- pheatmap
- Bioconductor packages

For exact package versions, see:

```text
sessionInfo.txt
```

---

## Installation

Clone the repository:

```bash
git clone https://github.com/lprzem01/Noncoding-RNAs-in-Mycobacterium-abscessus.git
cd Noncoding-RNAs-in-Mycobacterium-abscessus
```

Install the required software and dependencies listed above before running the workflow.

---

## Usage

### Step 1: Quality Control

Assess raw sequencing read quality using FastQC.

### Step 2: Read Trimming

Remove adapters and low-quality bases using Fastp.

### Step 3: Alignment

Align trimmed reads to the *Mycobacterium abscessus* reference genome using BWA.

### Step 4: ncRNA Discovery

Identify putative non-coding RNAs using BaerHunter.

### Step 5: Differential Expression Analysis

Perform transcript quantification and differential expression analysis using DESeq2.

### Step 6: Visualisation

Generate publication-ready figures, heatmaps, and summary plots.

---

## Outputs

The repository includes:

- Differential expression results
- Predicted ncRNA candidates
- Quality control reports
- Mapping statistics
- Visualisation figures
- Supplementary tables and metadata

---

## Research Focus

This project investigates previously unannotated expressed regions within the *Mycobacterium abscessus* transcriptome and explores their potential role as non-coding RNAs. The workflow provides a reproducible framework for identifying and characterising novel regulatory elements from RNA-seq data.

