#!/bin/bash
if [ "$#" -lt 1 ]; then
 echo "usage: $0 SVGFILE"
else
  extension="${1##*.}"
  filename="${1%.*}"
  inkscape --without-gui --file="$1" --export-pdf="$filename.pdf" --export-latex
fi