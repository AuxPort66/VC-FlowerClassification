function res1 = SimplificaColor(im,mask)

area = histcounts(mask);
s = size(area);
if s(2) > 1
    area = area(2);
else
    res1  = ["no"];
    return;
end

mask3 = cat(3,mask,mask,mask);
result = im;
result(mask3 ~= 1) = 0;


nummax = 30;
[IND,map] = rgb2ind(result,nummax);
%figure, imagesc(IND), colormap(map);
hist = histcounts(IND);
M = containers.Map;
aux = size(map);
for i = 2:aux(1)
    string = HSVToName (rgb2hsv(map(i,:)));
   if isKey(M,string) && sum(255*map(i,:)) > 0
       M(string) = M(string) + hist(i);
   elseif sum(255*map(i,:)) > 0
       M(string) = hist(i);
   end
end

val = cell2mat(values(M));
key = keys(M);

[num, index] = max(val);
list = [key(index)];
key(index) = [];
val(index) = [];

[num,index] = max(val);
if(val(index) > area*0.05)
list = [list,key(index)];
end
 key(index) = [];
 val(index) = [];
 
 [num,index] = max(val);
 if(val(index) > area*0.02)
  list = [list,key(index)];
 end
res1 = list; 
