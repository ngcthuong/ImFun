function [BW, localThreshUsedInterp, localThreshInterp] = ...
    localAdaptiveOtsu(I, winSize, stepSize, var_thresh)

Nrow = size(I,1);
Ncol = size(I,2);

% global Otsu's threshold is used to determine 
% foreground/background for uniform areas.
globalOtsuLevel = 256*graythresh(I);

% thresholds for local overlapping tiles
NTileRows = floor(Nrow / stepSize);
NTileCols = floor(Ncol / stepSize);
localThresh = globalOtsuLevel * ones(NTileRows, NTileCols);
localThreshUsed = zeros(NTileRows, NTileCols);
BW = zeros(Nrow, Ncol);
for tileRow = 1:NTileRows
    if tileRow < NTileRows
        inputRowStart = (tileRow-1)*stepSize + 1;
        inputRowEnd = inputRowStart + winSize - 1;
    else
        inputRowStart = (tileRow-1)*stepSize + 1;
        inputRowEnd = inputRowStart + stepSize - 1;
    end
    inputRowRange = inputRowStart:inputRowEnd;
    outputRowStart = (tileRow-1)*stepSize + 1;
    outputRowEnd = outputRowStart + stepSize - 1;
    outputRowRange = outputRowStart:outputRowEnd;

    for tileCol = 1:NTileCols
        if tileCol < NTileCols
            inputColStart = (tileCol-1)*stepSize + 1;
            inputColEnd = inputColStart + winSize - 1;
        else
            inputColStart = (tileCol-1)*stepSize + 1;
            inputColEnd = inputColStart + stepSize - 1;
        end
        inputColRange = inputColStart:inputColEnd;
        outputColStart = (tileCol-1)*stepSize + 1;
        outputColEnd = outputColStart + stepSize - 1;
        outputColRange = outputColStart:outputColEnd;

        inputPatch = I(inputRowRange, inputColRange);
        if var(double(inputPatch(:))) > var_thresh
            localThresh(tileRow, tileCol) = 256*graythresh(inputPatch);
            localThreshUsed(tileRow, tileCol) = 1;
        else
            BW(outputRowRange, outputColRange) = mean2(inputPatch) > globalOtsuLevel;
        end

    end % tileCol
end % tileRow

localThreshInterp = imresize(localThresh, [Nrow Ncol], 'bilinear');
localThreshUsedInterp = imresize(localThreshUsed, [Nrow Ncol], 'nearest');
BWLocal = I > localThreshInterp;
idxLocal = find(localThreshUsedInterp == 1);
BW(idxLocal) = BWLocal(idxLocal);