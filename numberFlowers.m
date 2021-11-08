function res = numberFlowers(mask)
    region = regionprops(mask==1);
    res = sum([region.Area] > 2000);
    