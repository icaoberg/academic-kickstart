---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "bedtools"
subtitle: "Singularity recipe and image"
summary: "Singularity recipe and image for bedtools"
authors: ["icaoberg"]
tags: ["singularity", "bedtools"]
categories: ["Programming"]
date: 2020-01-26T18:00:00-00:00
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

## Downloading the image from SyLabs.io
For simplicity, I have placed a copy of the container in [SyLabs.io](https://cloud.sylabs.io/library/_container/5e2fb360bb587a8c79c3e875).

```
> singularity search bedtools

No users found for 'bedtools'

No collections found for 'bedtools'

Found 1 containers for 'bedtools'
	library://icaoberg/default/bedtools
		Tags: v2.29.2
```

To download this image locally simply run

```
singularity pull library://icaoberg/default/bedtools:v2.29.2
```

### Using the Singularity image
#### Example. Create a master ChromHMM track from the 9 distinct cell types.
You can find the script `example01` [here](https://gist.github.com/icaoberg/2253e0ef34b3fd7dd3f4703d8037e83f). It is based on existing examples, the script is simply calling bedtools in the Singularity container.

Standard output is not neccesarily useful, however you should see something like this.

[![asciicast](https://asciinema.org/a/296318.svg)](https://asciinema.org/a/296318)

## Disclaimer

I am nothing but a humble programmer creating the container for this wonderful app. [bedtools](https://bedtools.readthedocs.io/en/latest/) is developed in the [Quinlan laboratory](http://quinlanlab.org/) at the [University of Utah](https://www.utah.edu/) and benefits from fantastic contributions made by scientists worldwide.
