function [count, areaThresh] = eccentricityFilter( colorThresh, upperLimit, lowerLimit)
count = 0;
areaThresh = colorThresh;
imLabel = bwlabel(areaThresh);
shapeProps = regionprops(imLabel, 'Eccentricity');
count = length(shapeProps);
for nRegion = 1: length(shapeProps)
    idx = imLabel == nRegion;
    area = shapeProps(nRegion).Eccentricity;
    if (area > upperLimit) || (area < lowerLimit)
        count = count - 1;
        areaThresh(idx) = 0;
    end
end

