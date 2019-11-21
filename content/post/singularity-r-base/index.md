---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "r-base + some useful R packages"
subtitle: "Singularity recipe and image"
summary: "Singularity recipe and image for GDC client"
authors: ["icaoberg"]
tags: ["singularity", "projects"]
categories: ["Programming"]
date: 2019-11-14T11:30:49-05:00
lastmod: 2019-11-14T11:30:49-05:00
featured: true
draft: true
image:
  caption: "Singularity"
  focal_point: "Smart"
  preview_only: true
projects: ["CMU"]
---

# Project
This particular project is straightforward. A grad student would like to create a container with R that has specific R libraries installed.

# Basic image recipe
By using Docker as my bootstrap engine I can download an image that comes witht R installed so I don't have to do it. See the script below.

{{< highlight bash >}}
Bootstrap: docker
From: rstudio/r-base:3.6.1-opensuse42

IncludeCmd: yes

%help
    R-base v3.6.1 on OpenSuse42

%environment
    export LC_ALL=C

%apphelp R
    For more information visit https://www.rdocumentation.org/

%apprun R
    R "$@"

%apphelp Rscript
    For more information visit https://www.rdocumentation.org/

%apprun Rscript
    Rscript "$@"
{{< / highlight >}}

# Custom Singularity recipe
However the script above will create a Singularity container that exposes R and Rscript but does not have the libraries the student wants. To solve this, you can add the lines to install the libraries within the container. See the script below

{{< highlight bash >}}
Bootstrap: docker
From: rstudio/r-base:3.6.1-opensuse42

IncludeCmd: yes

%post
    R --slave -e 'if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager", repos = "http://cran.us.r-project.org")'
    R --slave -e 'BiocManager::install("DropletUtils")'
    R --slave -e 'BiocManager::install("scds")'
    R --slave -e 'BiocManager::install("scran")'
    R --slave -e 'BiocManager::install("scater")'
    R --slave -e 'BiocManager::install("EnsDb.Hsapiens.v86")'
    R --slave -e 'BiocManager::install("EnsDb.Mmusculus.v79")'
    R --slave -e 'BiocManager::install("AUCell")'
    R --slave -e 'install.packages("tidyverse")'
    R --slave -e 'install.packages("feather")'
    R --slave -e 'install.packages("umap")'
    R --slave -e 'install.packages("NMF")'
    R --slave -e 'install.packages("devtools")'
    R --slave -e 'install_github("jokergoo/ComplexHeatmap")'
    R --slave -e 'install_github("ikwak2/DrImpute")'

%help
    R-base v3.6.1 on OpenSuse42

%environment
    export LC_ALL=C

%apphelp R
    For more information visit https://www.rdocumentation.org/

%apprun R
    R "$@"

%apphelp Rscript
    For more information visit https://www.rdocumentation.org/

%apprun Rscript
    Rscript "$@"
{{< / highlight >}}


However the script above will fail as well. Why? Some of these packages have dependencies outside the scope of R.
