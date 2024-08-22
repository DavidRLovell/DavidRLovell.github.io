#!/bin/bash -xv

rm -rf ./render
mkdir  ./render
cp     ./Assessment01.ipynb ./render

cd ./render

timeout 2m jupyter nbconvert --execute --allow-errors --to html Assessment01