function type = compareDirHistPeaks (mask)
    histograms = [0.2162    0.0401    0.2025    0.0395    0.2163    0.0410    0.2033    0.0410; %normals
                  0.1670    0.1152    0.1549    0.0631    0.1649    0.1143    0.1535    0.0671; %crocus
                  0.0849    0.2082    0.1176    0.0882    0.0858    0.2085    0.1201    0.0866; %Fadrins
                  0.0810    0.1661    0.0855    0.1571    0.0928    0.1566    0.1011    0.1597]; %Fritillaria
    
    imageHist = getDirHistPeaks(mask);
    minDif = 99.99;
    closestHist = 1;
    for i = 1:4
        tempDif = sum(abs(histograms(i,:)' - imageHist(:)));
        if tempDif < minDif
            closestHist = i;
            minDif = tempDif;
        end
    end
    if closestHist == 1
        type = "Normal";
    elseif closestHist == 2
        type = "Crocus";
    elseif closestHist == 3
        type = "Fadrins";
    elseif closestHist == 4
        type = "Frit";
    end

        
    