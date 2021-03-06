#!/bin/bash

if [[ $# -lt 1 ]]; then
    echo "Error: You need to provide a valid image path"
    echo "\n\nUsage: $0 {inputfile} [outfile]\n\n"
    exit 1;
fi

destinationGraphicWidth=${destinationGraphicWidth:=1920}
destinationGraphicHeight=${destinationGraphicHeight:=1080}

sourceGraphicWidth=`identify $1 | cut -f 3 -d " " | sed s/x.*//`
sourceGraphicHeight=`identify $1 | cut -f 3 -d " " | sed s/.*x//`

topLeftSrcPoint="0,0"
topRightSrcPoint="${sourceGraphicWidth},0"
bottomLeftSrcPoint="0,${sourceGraphicHeight}"
bottomRightSrcPoint="${sourceGraphicWidth},${sourceGraphicHeight}"

topLeftDestPoint=${topLeftDestPoint:=$topLeftSrcPoint}
topRightDestPoint=${topRightDestPoint:=$topRightSrcPoint}
bottomLeftDestPoint=${bottomLeftDestPoint:=$bottomLeftSrcPoint}
bottomRightDestPoint=${bottomRightDestPoint:=$bottomRightSrcPoint}

OUTFILE=${2:="out.png"}

convert -extent "${destinationGraphicWidth}x${destinationGraphicHeight}" \
-channel rgba \
-virtual-pixel background \
-background none \
$1 -distort Perspective \
"${topLeftSrcPoint} ${topLeftDestPoint} \
${topRightSrcPoint} ${topRightDestPoint} \
${bottomLeftSrcPoint} ${bottomLeftDestPoint} \
${bottomRightSrcPoint} ${bottomRightDestPoint}" \
$OUTFILE
