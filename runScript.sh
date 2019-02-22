#!/bin/bash 
#install imagemagik ghostscript

echo "Hello World!"

echo "cropping all pages & its shipping label"

rm -R `date +%d_%b`

ghostscript                               \
  -o cropped.pdf                 \
  -sDEVICE=pdfwrite              \
  -c "[/CropBox [168 478 430 820]" \
  -c " /PAGES pdfmark"           \
  -f input.pdf

mkdir `date +%d_%b`

ghostscript \
  -dBATCH \
  -dNOPAUSE \
  -dSAFER \
  -sDEVICE=jpeg \
  -dJPEGQ=95 \
  -r800x800 \
  -dUseCropBox \
  -sOutputFile="`date +%d_%b`/pdffile-%03d.jpeg" cropped.pdf

montage -border 4 -tile 2x2 -geometry 595x842+11+22 -quality 100 "`date +%d_%b`/pdffile-*.jpeg" "`date +%d_%b`/final.jpg"

rm `date +%d_%b`/pdffile-*.jpeg

convert `date +%d_%b`/*.jpg `date +%d_%b`/final.pdf
