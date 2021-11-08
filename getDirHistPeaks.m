function res = getDirHistPeaks(mask)
    %Degut a que el histograma de direccions acostuma a donar 8 peaks locals
    %aquesta funcio els extreu i els retorna de manera ordenada
    resolution = 200;
    hist = directionalHistogram(mask,resolution);
    [pks, locs] = findpeaks(hist);
    s = size(pks);
    if  s(1) > 7
        [pksOrder, equiPks] = sort(pks);
        locsOrder = sort(locs(equiPks(end-7:end)));
        histPeaks = hist(locsOrder);
        histPeaks = histPeaks - min(histPeaks);
        res = histPeaks / sum(histPeaks);
    else
       res = 0; 
    end
    