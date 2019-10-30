#!/bin/bash

FOLDER="weekly-report-"$(date +"%Y-%m-%d")
DATE=$(date +"%Y-%m-%d")

cat << EOF > index.md
---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Weekly Report"
subtitle: "TaskWarrior daily burndown chart"
summary: "TaskWarrior daily burndown chart"
authors: ["icaoberg"]
tags: []
categories: []
date: $DATE
lastmod: $DATE
featured: true
draft: false
projects: ["programming"]
image:
  caption: "Burndown chart"
  focal_point: "Smart"
  preview_only: true
---

### THIS IS AUTOMATED REPORT

\`\`\`
EOF

task burndown.weekly >> index.md
echo "\`\`\`" >> index.md
wget https://cdn.pixabay.com/photo/2018/04/06/11/21/office-3295556_960_720.jpg
mv -v office-3295556_960_720.jpg featured.jpg
mkdir $FOLDER
mv -v index.md $FOLDER
mv -v featured.jpg $FOLDER

if [ -d ./content/post/$FOLDER ]; then
	rm -rfv ./content/post/$FOLDER
fi

mv -v $FOLDER ./content/post/
