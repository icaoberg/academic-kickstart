---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "GNU GCC"
subtitle: "Singularity recipe and image"
summary: "Singularity recipe and image for GNU GCC"
authors: ["icaoberg"]
tags: ["singularity"]
categories: ["Programming"]
date: 2020-04-03T22:00:00-00:00
featured: true
draft: false
projects: ["CMU"]

image:
  caption: "GNU"
  focal_point: "Smart"
  preview_only: false
---

[The GNU Compiler Collection](https://gcc.gnu.org/) is a compiler system produced by the GNU Project supporting various programming languages. GCC is a key component of the GNU toolchain and the standard compiler for most projects related to GNU and Linux, including the Linux kernel. 

## Source code
You can find the recipe to build the container [here](https://github.com/icaoberg/singularity-gcc).

To facilitate building the container, you will find two **simple** scripts in the repository

* `rbuild.sh`. Builds the image remotely and then pulls it down locally. You will need access to [SyLabs.io Remote Builder](https://cloud.sylabs.io/builder) to do this. Getting access to the Remote Builder is beyond the scope of this post.
* `build.sh`. Builds the image locally. You will need root privileges to build the container locally.

### Building the image locally

The script `build.sh` looks like

```
#!/bin/bash

IMAGE=singularity-debian-dusty-gcc-v8.3.0.sif
DEFINITION=Singularity

if [ -f $IMAGE ]; then
	rm -fv $IMAGE
fi

sudo singularity build $IMAGE $DEFINITION
```

To build the image locally simply run

```
bash ./build.sh
```

### Building the image remotely

The script `rbuild.sh` looks like

```
#!/bin/bash

IMAGE=singularity-debian-dusty-gcc-v8.3.0.sif
DEFINITION=Singularity

if [ -f $IMAGE ]; then
	rm -fv $IMAGE
fi

singularity build --remote $IMAGE
```

If you notice, there isn't much difference between this script and the previous script.

To build the image remotely simply run

```
bash ./rbuild.sh
```

## Example 1. Building samtools from source
**THIS EXAMPLE ASSUMES SINGULARITY IS INSTALLED AND IS AVAILABLE TO YOUR USER**

Building [samtools](https://github.com/samtools/) from source code is a three step process.

First, we need to download the source code for samtools. For version 1.10, type in termninal

```
wget -nc https://github.com/samtools/samtools/releases/download/1.10/samtools-1.10.tar.bz2
bunzip2 samtools-1.10.tar.bz2 && tar -xf samtools-1.10.tar && rm -f samtools-1.10.tar
```

Second, you need to download the image I created from SyLabs (alternatively you can build the image yourself). To download the image type

```
singularity pull --arch amd64 library://icaoberg/default/gcc:v8.3.0
```

After running these commands, you should see these files/folders

```
[gcc-example]$ ls -lt
total 149809
-rwxr-xr-x 1 icaoberg icaoberg 153572283 Apr  4 03:39 gcc_v8.3.0.sif
drwxrwxr-x 9 icaoberg icaoberg        80 Dec  6 11:46 samtools-1.10
```

Third, we need to shell into the Singularity image and then compile from source. To shell into the image, type in terminal

```
singularity shell gcc_v8.3.0.sif
```

Now that we are inside the container, let's change directory to samtools and compile the tool. Type in terminal,

```
cd samtools-1.10
./configure
make
```

After running these commands, you should see the binary now

```
Singularity> ls -lt samtools

-rwxr-xr-x 1 icaoberg icaoberg 6656944 Apr  4 04:21 samtools
```

Remember, the you need to run the binary within the container

```
Singularity> ./samtools --help

Program: samtools (Tools for alignments in the SAM format)
Version: 1.10 (using htslib 1.10)

Usage:   samtools <command> [options]

Commands:
  -- Indexing
     dict           create a sequence dictionary file
     faidx          index/extract FASTA
     fqidx          index/extract FASTQ
     index          index alignment

  -- Editing
     calmd          recalculate MD/NM tags and '=' bases
     fixmate        fix mate information
     reheader       replace BAM header
     targetcut      cut fosmid regions (for fosmid pool only)
     addreplacerg   adds or replaces RG tags
     markdup        mark duplicates

  -- File operations
     collate        shuffle and group alignments by name
     cat            concatenate BAMs
     merge          merge sorted alignments
     mpileup        multi-way pileup
     sort           sort alignment file
     split          splits a file by read group
     quickcheck     quickly check if SAM/BAM/CRAM file appears intact
     fastq          converts a BAM to a FASTQ
     fasta          converts a BAM to a FASTA

  -- Statistics
     bedcov         read depth per BED region
     coverage       alignment depth and percent coverage
     depth          compute the depth
     flagstat       simple stats
     idxstats       BAM index stats
     phase          phase heterozygotes
     stats          generate stats (former bamcheck)

  -- Viewing
     flags          explain BAM flags
     tview          text alignment viewer
     view           SAM<->BAM<->CRAM conversion
     depad          convert padded BAM to unpadded BAM
```

## Example 2. Compiling and running a simple app

Consider this file

```
#include <stdio.h>
int main()
{
   /* printf function displays the content that is
    * passed between the double quotes.
    */
   printf("Hello World");
   return 0;
}
```

The exists in a file called `hello.c`.

To compile this file type in terminal,

```
singularity run --app gcc singularity-debian-dusty-gcc-v8.3.0.sif hello.c
```

This command will create the file

```
✗ ls -lt a.out

-rwxr-xr-x 1 icaoberg icaoberg 16608 Apr  4 05:10 a.out
```

To run

```
./a.out

Hello World
``
