function res = translateMask(mask)
    edges = edge(mask);
    ee = strel('cube',7);
    edges = imdilate(edges,ee);
    res = uint8(mask);
    res(res == 0) = 3;
    res(edges) = 0;