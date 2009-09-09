#!/bin/sh

cd files/diagrams
mkdir -p {svg,thumbnails,png}

for file in dot/*.dot
do
  filename=$(basename $file)
  extension=${filename##*.}
  filename=${filename%.*}

  echo "generating png and svg for $filename"

  cat $file | neato -Tpng > png/$filename.png
  cat $file | neato -Tsvg > svg/$filename.svg
done
echo "generating thumbnails"
mogrify -format png -thumbnail 600x1000 -path thumbnails/ 'png/*.png'
