     function res = createMaskNaranja(im,mask)       
        %Dada una im imagen y una mascara binarizada mask devuelve si
        %encuentra un objeto alargado y naranja
     
            mask3 = cat(3,mask,mask,mask);
            result = im;
            result(mask3 ~= 1) = 0;
            [BW,maskedImage] = createMaskNaranja(result);
            maybe = im2bw(maskedImage);
            maybe = imfill(maybe, 'holes');
            siz = size(im);
            BW2 = zeros(siz(1),siz(2));
            if bwarea(maybe)/(siz(1)*siz(2)) * 100 <= 3
               ee = strel('line',3,180);
               BW2 = imopen(maybe,ee);
            end
            hist = histogram(BW2);
            if hist.NumBins == 2
                res = 1;
            else
                res = 0;
            end