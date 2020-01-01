---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Installing R v3.2.3"
subtitle: "Installing R v3.2.3"
summary: "Installing R v3.2.3"
authors: ["icaoberg"]
tags: ["science", "statistics", "r-project"]
categories: ["Programming"]
date: 2016-04-12T05:34:42-05:00
lastmod: 2016-04-12T05:34:42-05:00
featured: true
draft: false
image:
  caption: ""
  focal_point: ""
  preview_only: true
projects: []
---

If you want to install R 3.2.3 in your home directory in the CBD cluster, then you can use the following script. 

Feel free to modify it as needed.

```
#!/bin/bash

## Ivan E. Cao-Berg (icaoberg@scs.cmu.edu)
## Copyright (C) 2016
##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published
## by the Free Software Foundation; either version 2 of the License,
## or (at your option) any later version.
##
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
## General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; if not, write to the Free Software
## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
## 02110-1301, USA.

if [ ! -d ~/bin ]; then
	mkdir ~/bin
fi
cd ~/bin

wget -nc https://cran.rstudio.com/src/base/R-3/R-3.2.3.tar.gz
tar -xvf R-3.2.3.tar.gz
cd R-3.2.3
./configure
make

ln -s ~/bin/R-3.2.3/bin/R ~/bin/R
ln -s ~/bin/R-3.2.3/bin/Rcmd ~/bin/Rcmd
ln -s ~/bin/R-3.2.3/bin/Rd2pdf ~/bin/Rd2pdf
ln -s ~/bin/R-3.2.3/bin/Rprof ~/bin/Rprof
ln -s ~/bin/R-3.2.3/bin/Rscript ~/bin/Rscript
```

You can run these commands in terminal to get the script and submit to the scheduler

```
git clone https://gist.github.com/d3e4812911a691d4deff.git
cd d3e4812911a691d4deff
sbatch -p pool1 -o ./install_R.3.2.3.out ./script.sh
```

If the installation was successful, then you should be able to run R

```
[icaoberg ~]$ ~/bin/R

R version 3.2.3 (2015-12-10) -- "Wooden Christmas-Tree"
Copyright (C) 2015 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

>
```
