#!/bin/bash

hugo && rsync -ruv public/ /var/www/html/ && rsync -ruv public/ /home/icaoberg/data/code/icaoberg.github.io/
