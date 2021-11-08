function res = forats(im)
    mark = im;
    mark(8:end-7, 8:end-7)=0;
    %Marca tot el fons el qual te contacte amb els costats de la imatge
    rec = imreconstruct(mark,im);
    ee = strel('disk',1);
    rec2 = 1-imdilate(rec,ee);
    
    %Fem la intersecció de rec2 i tots els pixels de fons de la imatge per
    %a trobar potencials forats
    holes = and((rec2), (im == 3));
    
    
    %Selecciona només els forats amb més de 20 pixels
    bigholes = bwareaopen(holes,20);
    
    %Busca la area dins de la flor en si
    %Fem imdilate per a fer mes generosa la busqueda de que es considera
    %estar a dins la flor, per evitar falsos negatius
    ee = strel('disk',20);
    flor=im==1;
    flor=imdilate(flor,ee);
    flor=imfill(flor,'holes');
    
    foratsveritat = imreconstruct(flor,bigholes);
    
    %figure,imshow(flor,[]);
    %figure,imshow(foratsveritat,[]);
    
    res = length(regionprops(foratsveritat));
    if res > 2
        res = 2;
    end
    
    
    
    