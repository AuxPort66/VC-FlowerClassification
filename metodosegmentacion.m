function res = metodosegmentacion(im,metodo)

    switch metodo
        case 0
           [procesada,BW] = colorthresholdauto(im,30);
            X = rgb2lab(im);
            bw = activecontour(X, BW, 100, 'Chan-Vese');
            res = imfill(bw,'holes');
        case 1
            [procesada,res] = colorthreshold(im);
        case 2
            [procesada,res] = colorthresholdauto(im,30);
        case 3
            [procesada,res] = maybeedge(im);
        case 4
            BW = im2bw(im,graythresh(im));
            [procesada,res] = procesado(im,BW); 
        case 5
            BW = im2bw(im,graythresh(im));
            [procesada,BW] = procesado(im,BW); 
            X = rgb2lab(im);
            bw = activecontour(X, BW, 100, 'Chan-Vese');
            res = imfill(bw,'holes');
    end

end