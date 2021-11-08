function [result,final] = maybeedge (im)

gray = rgb2gray(im);
canny5 = edge(gray,'Canny');
canny3 = edge(gray,'Canny',[0.1 0.5],7.0);
canny = imreconstruct(canny3,canny5);
canny = imdilate(canny,strel('disk',2));
canny(1:4,1:end)=0;
canny(end-4:end,1:end)=0;
canny(1:end,1:4)=0;
canny(1:end,end-4:end)=0;
cc = bwconncomp(canny);
%figure, imagesc(imfill(labelmatrix(cc),'holes')), drawnow
stats = regionprops(cc,'Area');

area = size(im);
area = area(1) * area(2);

siz = size(find([stats.Area] > area*0.05));
count = 1;
 while (siz(2) == 0)
     count = count +  1;
    canny = imdilate(canny,strel('disk',2));
    %figure,imshow(canny);
    borde = canny;
    canny(1:4,1:end)=0;
    canny(end-4:end,1:end)=0;
    canny(1:end,1:4)=0;
    canny(1:end,end-4:end)=0;
    canny = imfill(canny,'holes');
    cc = bwconncomp(canny);
    stats = regionprops(cc,'Area');
    siz = size(find([stats.Area] > area*0.6));
 end
 
 %figure, imagesc(imfill(labelmatrix(cc),'holes')), drawnow
 for i = 1:count
    canny = imerode(canny,strel('disk',2));
 end
 
 C = bwareaopen(canny,round(area/3));
 final =  imreconstruct(C,canny);
 final =  im2double(final);
 
 borde = imsubtract (imdilate(final,strel('disk',7)),imerode(final,strel('disk',7)));
 final = imfill(borde,'holes');
 final = imsubtract(borde, final);

 final(final == -1) = 1;
 final(final == 0) = 3;
 final(borde == 1) = 0;

 
  final3 = cat(3,final,final,final);
  result = im;
  result(final3 == 3) = 0;
 
