function res = circularity(mask)
    regions = regionprops(mask==1,'area','perimeter');
    regTable = struct2table(regions);
    sortedTable = sortrows(regTable, 'Area', 'descend');
    regions = table2struct(sortedTable);
    
    
    res = 0;
    if size(regions) > 0
        res = regions(1).Perimeter^2 / (4 * pi * regions(1).Area);
    end
    