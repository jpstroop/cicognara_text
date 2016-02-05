#!/bin/sh
STARTPAGE=1
ENDPAGE=609
SOURCE=CATALOGO_CICOGNARA.pdf
RESOLUTION=600 # set to the resolution the scanner used (the higher, the better)
OUTDIR='data'

for i in `seq $STARTPAGE $ENDPAGE`; do
    tiff=$OUTDIR/page$i.tif
    convert -monochrome -density $RESOLUTION $SOURCE\[$(($i - 1 ))\] $tiff
    echo processing page $i
    # `-psm N` option doesn't seem to work. Use the -c `tessedit_pageseg_mode=n` syntax instead.
    # A list of options is available from --tesseract --print-params
    tesseract $tiff $OUTDIR/page$i -l ita -c tessedit_pageseg_mode=4 hocr
done
