function res = main
    segmentacion = -1;
    test = 1;
    while segmentacion == -1;
        prompt = 'Segmentacion: Exterior:0 Propia:1\n';
        segmentacion = input(prompt);
        if segmentacion < 0 || segmentacion > 1
            disp("No es una opcion");
            segmentacion = -1;
        end
    end
    metodo = -1;
    if segmentacion
        display("AVISO: Nuestros trainers solo estan entrenados en autcolor con active y en graythresh con active, si escoges otro metodo dara peor resultado");
        while metodo == -1;
            prompt = 'Metodo de segmentaci�n. AUTOMATICOCOLOR CON ACTIVE CONTOUR(es lento, cuidado):0  MANUAL:1  AUTOMATICOCOLOR:2  EDGES:3  GRAYTHRESH:4 GRAYTHRESH CON ACTIVE CONTOUR:5 \n';
            metodo = input(prompt);
            if metodo < -1 || metodo > 6
                disp("No es una opcion");
                metodo = -1;
            end
        end
    end
                
                
    falsos = -1;
    while falsos == -1;
        prompt = 'Clase zero: No:0 Si:1\n';
        falsos = input(prompt);
        if falsos < 0 || falsos > 1
            disp("No es una opcion");
            falsos = -1;
        end
    end
                
                
    carpeta = -1;
    while carpeta == -1;
        prompt = 'Carpeta:0 Imagen:1';
        carpeta = input(prompt);
        if carpeta < 0 || carpeta > 1
            disp("No es una opcion");
            carpeta = -1;
        end
    end

    display("Recuerda a�adir el path si no estas en la misma carpeta o situarte en ella");
    if ~carpeta
        prompt = 'Indica los nombres de las carpetas ["Nombre1","Nombre2",...]\n';
        foldername = input(prompt);
    else
        prompt = 'Indica el nombre de la imagen sin la extension "NombreImagen"\n';
        foldername = input(prompt);
    end
        
    caracteristicas = analitzarImatges(segmentacion,metodo,falsos,test,foldername,carpeta);

    if segmentacion
        if metodo == 5
            trainer = load('trainedsegbwactive.mat');
        else
            trainer = load('trainedseg.mat');
        end
    else
        if falsos
            trainer = load('trainedzero.mat');
        else
            trainer = load('trained.mat');
        end
    end
    res = trainer.predictFcn(caracteristicas);