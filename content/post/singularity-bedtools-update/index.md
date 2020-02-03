---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "bedtools"
subtitle: "Singularity recipe and image"
summary: "Singularity recipe and image for bedtools"
authors: ["icaoberg"]
tags: ["singularity", "bedtools"]
categories: ["Programming"]
date: 2020-02-03T18:00:00-00:00
featured: true
draft: false
projects: ["CMU"]

image:
  caption: "bedtools"
  focal_point: "Left"
  preview_only: true
---

## About bedtools

![Logo](logo.png)

Collectively, the [bedtools](https://bedtools.readthedocs.io/en/latest/) utilities are a swiss-army knife of tools for a wide-range of genomics analysis tasks. The most widely-used tools enable genome arithmetic: that is, set theory on the genome. For example, bedtools allows one to intersect, merge, count, complement, and shuffle genomic intervals from multiple files in widely-used genomic file formats such as BAM, BED, GFF/GTF, VCF. While each individual tool is designed to do a relatively simple task (e.g., intersect two interval files), quite sophisticated analyses can be conducted by combining multiple bedtools operations on the UNIX command line.

## Okay... hear me out
Ok, so I added two simple examples to the repo to make sure users can test the Singularity image. However I need to either learn how to use the test section of the recipe of find a useful way to run tests. Kind of challenging if I want to keep it simple.

### example02.sh

The shell script below is pretty simple

```
# icaoberg - this example is fork that uses a bedtools in a Singularity container
CONTAINER=../../singularity-bedtools.simg

echo "chr1	10	50	10" > a.bed
echo "chr1	20	40	20" > b.bed
echo "chr1	30	33	30" > c.bed

# Find the sub-intervals shared and unique to each file.
if [ -f $CONTAINER ]; then
	singularity run --app bedtools $CONTAINER multiinter -i a.bed b.bed c.bed | column -t
fi

# Intersect the sub-intervals with the original intervals to collect the scores
if [ -f $CONTAINER ]; then
	singularity run --app bedtools $CONTAINER multiinter -i a.bed b.bed c.bed \
    | singularity run --app bedtools $CONTAINER intersect -a - -b a.bed b.bed c.bed -wa -wb \
    | column -t
fi

# Grooupby the sub-intervals with the mean score from each of the original files.
if [ -f $CONTAINER ]; then
        singularity run --app bedtools $CONTAINER multiinter -i a.bed b.bed c.bed \
    | singularity run --app bedtools $CONTAINER intersect -a - -b a.bed b.bed c.bed -wa -wb \
    | singularity run --app bedtools $CONTAINER groupby -g 1-5 -c 13 -o mean \
    | column -t
fi

rm -f *.bed
```

The real question is, will this scale?
