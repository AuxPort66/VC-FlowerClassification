function res = analitzarImatges(segmentacion,metodo,fentServirErrors,test,dirs,carpeta)
    % Procesa las imágenes determinadas para crear 
    %una tabla con las características de esa imagen en cada descriptor.
    %Segmentacion 0 segmentacion exterior 1 segmentacion propia
    %Metodo metodo de segmentacion. 0 autocoloractive 1 manualcolor 
    % 2 autocolor 3 edge 4 gray 5 grayactive
    %fentServirErrors 0 sin carpeta errors 1 con carpeta errors
    %test 1 activa la lectura de las carpetas default
    %dirs listado de carpetas o nombre de imagen a procesar
    %carpeta 1 es una carpeta

    results(600) = struct('flor','a','ID','a','nombreFlors',0,'colorprimari','t','colorsecundari','t','colorterciario','t','forats',0,'circularity',0,'dirhistTipus','a');
    numberId = 1;

   if ~test
       dirs = ["BotodOr" "Crocus" "Fadrins" "Gerbera" "Hemerocallis" "Narcis" "Buixol" "DentdeLleo" "Fritillaria" "Girasol" "Lliri" "Viola"];
   end
   dirsError = ["Errors"];
    
   if ~carpeta || ~test
    for folder = dirs(:)'
        folderContents = dir(strcat(folder, '/*.jpg'));
        folderCells = {folderContents.name};
        folderNames = string(folderCells);
        for imageloc = folderNames(:)'
            imagename = char(imageloc);
            imagepath = strcat(char(folder), '/', imagename);
            im = imread(imagepath);
            if segmentacion == 0
            maskname = strcat(imagename(1:end-4), '.png');
            maskpath = strcat(char(folder), '/', maskname);
                if exist(maskpath, 'file')
                    mask = imread(maskpath);
                end
            else
                mask = metodosegmentacion(im,metodo);
            end
            
            
            if segmentacion || exist(maskpath, 'file')
                results(numberId).flor = folder;
                results(numberId).ID = imagename(1:end-4);
                results(numberId).nombreFlors = numberFlowers(mask);
                if results(numberId).nombreFlors > 3
                    results(numberId).nombreFlors = 3;
                end
                
                aux = SimplificaColor(im,mask);
                results(numberId).colorprimari = char(aux(1));
                a = size(aux);
                if a(2) > 1
                    results(numberId).colorsecundari = char(aux(2));
                else
                    results(numberId).colorsecundari = 'no'; 
                end
                if a(2) > 2
                    results(numberId).colorterciario = char(aux(3));
                else
                    results(numberId).colorterciario = 'no'; 
                end
               
                results(numberId).forats = forats(mask);
                results(numberId).circularity = circularity(mask);
                results(numberId).dirhistTipus = compareDirHistPeaks(mask); 
                numberId = numberId + 1;
                
            end
        end
    end
   else
            imagename = strcat(dirs, '.jpg');
            im = imread(imagename);
            if segmentacion == 0
            maskname = strcat(dirs, '.png');
                if exist(maskname, 'file')
                        mask = imread(maskname);
                end
            else
               mask = metodosegmentacion(im,metodo);
            end
            
            
            if segmentacion || exist(maskname, 'file')
                results(numberId).ID = imagename(1:end-4);
                results(numberId).flor = "";
                results(numberId).nombreFlors = numberFlowers(mask);
                if results(numberId).nombreFlors > 3
                    results(numberId).nombreFlors = 3;
                end
                
                aux = SimplificaColor(im,mask);
                results(numberId).colorprimari = char(aux(1));
                a = size(aux);
                if a(2) > 1
                    results(numberId).colorsecundari = char(aux(2));
                else
                    results(numberId).colorsecundari = 'no'; 
                end
                
                if a(2) > 2
                    results(numberId).colorterciario = char(aux(3));
                else
                    results(numberId).colorterciario = 'no'; 
                end
                results(numberId).forats = forats(mask);
                results(numberId).circularity = circularity(mask);
                results(numberId).dirhistTipus = compareDirHistPeaks(mask); 
                numberId = numberId + 1;
                
            end
        end
  
 
   
    %%Inclou totes les dades de la carpeta d'errors com a classe Zero
    if fentServirErrors && ~test
        
        for folder = dirsError(:)'
            folderContents = dir(strcat(folder, '/*.jpg'));
            folderCells = {folderContents.name};
            folderNames = string(folderCells);
            for imageloc = folderNames(:)'
                imagename = char(imageloc);
                if segmentacion == 0
                    maskname = strcat(imagename(1:end-4), '.png');
                    maskpath = strcat(char(folder), '/', maskname);
                    if exist(maskpath, 'file')
                        mask = imread(maskpath);
                    end
                else
                    metodo = -1;
                    while metodo == -1;
                        prompt = 'Metodo de segmentación. RECOMENDADO(AUTOMATICOCOLOR CON ACTIVE CONTOUR):0  MANUAL:1  AUTOMATICOCOLOR:2  EDGES:3  GRAYTHRESH:4\n';
                        metodo = input(prompt);
                        if metodo > -1 && metodo < 5
                            mask = metodosegmentacion(im,metodo);
                        else
                           disp("No es una opcion");
                           metodo = -1;
                        end
                    end
                end
            
            imagepath = strcat(char(folder), '/', imagename);
            im = imread(imagepath);
            if segmentacion == 1 || exist(maskpath, 'file')
                    im = imread(imagepath);

                    results(numberId).flor = "Zero";
                    results(numberId).ID = imagename(1:end-4);
                    results(numberId).nombreFlors = numberFlowers(mask);
                    aux = SimplificaColor(im,mask);
                    results(numberId).colorprimari = char(aux(1));
                    a = size(aux);
                    if a(2) > 1
                        results(numberId).colorsecundari = char(aux(2));
                    else
                        results(numberId).colorsecundari = 'no'; 
                    end
                     if a(2) > 2
                    results(numberId).colorterciario = char(aux(3));
                     else
                        results(numberId).colorterciario = 'no'; 
                    end
                    results(numberId).forats = forats(mask);
                    results(numberId).circularity = circularity(mask);
                    results(numberId).dirhistTipus = compareDirHistPeaks(mask); 
                    numberId = numberId + 1;

                end
            end
        end
    end
    
    res = struct2table(results(1:numberId-1));
    if iscell(res.nombreFlors(1))
        res.nombreFlors = cell2mat(res.nombreFlors);
    end
    if iscell(res.forats(1))
        res.forats = cell2mat(res.forats);
    end
    if iscell(res.circularity(1))
        res.circularity = cell2mat(res.circularity);
    end