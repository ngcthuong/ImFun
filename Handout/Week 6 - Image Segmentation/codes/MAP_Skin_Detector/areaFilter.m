function areaThresh = areaFilter( colorThresh, upperLimit, lowerLimit)
areaThresh = colorThresh;
imLabel = bwlabel(areaThresh);
shapeProps = regionprops(imLabel, 'Area');
for nRegion = 1: length(shapeProps)
    idx = imLabel == nRegion;
    area = shapeProps(nRegion).Area;
    if (area > upperLimit) || (area < lowerLimit)
        areaThresh(idx) = 0;
    end
end

