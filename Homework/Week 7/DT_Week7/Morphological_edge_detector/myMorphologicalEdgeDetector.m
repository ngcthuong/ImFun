function imgE = myMorphologicalEdgeDetector(img)
sel = strel('disk', 1);
neighbor = getnhood(sel);
imgExternalGradient = mydilate(img, neighbor)~=img;
imgInternalGradient = myerode(img, neighbor)~=img;
imgE = imgExternalGradient ~= imgInternalGradient;
end

