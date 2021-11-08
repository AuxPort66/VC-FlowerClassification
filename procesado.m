function [result1,filter] = procesado(im,BW) 
    
    n = histcounts(BW);
    s = size(n);
    areas = 50000;
    if s(2) > 1
        areas = n(2);
    end
    
    %Elimina iterativamente las zonas mas pequeñas al area, que va
    %disminuyendo hasta que exista alguna area grande
    acaba = 0;
    per = 0.5;
    while acaba == 0 && per >= 0
    C = bwareaopen(BW,round(areas*per));
    n = histcounts(C);
    s = size(n);
    if s(2) > 1 && n(2) > 9000
        acaba = 1;
    end
    per = per - 0.10;
    end
    ero = imerode(C,strel('octagon', 9));
    reconstructed =  imreconstruct(ero,BW);
    

    filter = reconstructed;

    ce = imdilate(filter,strel('disk',3));
    filter = imadd(filter,ce);

   
    filter = imfill(filter,'holes');

    
    filter3 = cat(3,filter,filter,filter);
    result1 = im;
    result1(filter3 == 0) = 0;
    
    
