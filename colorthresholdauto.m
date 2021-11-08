function [final,BW] = colorthresholdauto(im,nummax)
    
    [IND,map] = rgb2ind(im,nummax);
    RGB = ind2rgb(IND,map);
    %figure, imagesc(IND), colormap(map),title('Colores normalizados'); 
    R = RGB(:,:,1);
    G = RGB(:,:,2);
    B = RGB(:,:,3);
    Aux = R & G & B;
    for i = 1:size(map)
        color = map(i,:);
        s = HSVToNameforback(rgb2hsv(color));
        if s == "Green" | s == "Brown" | s == "Black"
            R = RGB(:,:,1);
            G = RGB(:,:,2);
            B = RGB(:,:,3);
            Aux = R & G & B;
            Aux(R == color(1) & G == color(2) & B == color(3)) = 0;
            Aux3 = cat(3,Aux,Aux,Aux);
            RGB(Aux3 ~= 1) = 0;
            %figure,imshow(RGB);
        end
    end
    
    %figure,imshow(RGB),title('RGB tras eliminado de colores seleccionados');    
    [final,BW] = procesado(im,Aux);