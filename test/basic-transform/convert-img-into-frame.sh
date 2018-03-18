#!/bin/bash

destinationGraphicWidth=1920
destinationGraphicHeight=1080

sourceGraphicWidth=90
sourceGraphicHeight=90

topLeftSrcPoint="0,0"
topRightSrcPoint="${sourceGraphicWidth},0"
bottomLeftSrcPoint="0,${sourceGraphicHeight}"
bottomRightSrcPoint="${sourceGraphicWidth},${sourceGraphicHeight}"

topLeftDestPoint="100,100"
topRightDestPoint="800,10"
bottomLeftDestPoint="100,800"
bottomRightDestPoint="800,790"

convert -extent 1920x1080 \
-channel rgba \
-virtual-pixel background \
-background none \
checks.png -distort Perspective \
"${topLeftSrcPoint} ${topLeftDestPoint} \
${topRightSrcPoint} ${topRightDestPoint} \
${bottomLeftSrcPoint} ${bottomLeftDestPoint} \
${bottomRightSrcPoint} ${bottomRightDestPoint}" \
test_out.png
