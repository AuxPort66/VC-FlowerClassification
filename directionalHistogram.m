function res = directionalHistogram(im,reso)
    edge = bwperim(im==1);
    sob=fspecial('sobel');
    Soby=sob/4;
    Sobx=Soby';
    grady=imfilter(double(edge),Soby,'conv');
    gradx=imfilter(double(edge),Sobx,'conv');
    
    arg=atan2(grady,gradx);
    angle=uint8((arg+pi)/2/pi*reso);
    
    mod=sqrt(gradx.^2+grady.^2);
    mask=mod<0.0001;
    
    angle(mask)=255;
    
    h=imhist(angle(2:end-1,2:end-1));
    res=h(1:end-1);
    