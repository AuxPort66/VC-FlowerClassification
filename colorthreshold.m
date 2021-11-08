function [result1,result2] = colorthreshold(im)
 
    fin = 0;
    nummax = 8;
    while ~fin
        
        [IND,map] = rgb2ind(im,nummax);
        RGB = ind2rgb(IND,map);  
        figure, imagesc(IND), colormap(map);
        prompt = 'numero de colores(default 8)?(0 no modificar)';
        aux = input(prompt);
        if aux == 0
            fin = 1;
        else
            nummax = aux;
        end
        close
        
    end
    i = 0;
while i == 0
    d = impixel(RGB);
    for j = 1:size(d)
        close;
        color = d(j,:);
        R = RGB(:,:,1);
        G = RGB(:,:,2);
        B = RGB(:,:,3);
        Aux = R & G & B;
        Aux(R == color(1) & G == color(2) & B == color(3)) = 0;
        Aux3 = cat(3,Aux,Aux,Aux);
        RGB(Aux3 ~= 1) = 0;
    end
    figure,imshow(RGB),title('RGB tras eliminado de colores seleccionados');    
    prompt = 'terminaste? (0 no 1 si)';
    i = input(prompt);
end
[result1,result2] = procesado(im,Aux);