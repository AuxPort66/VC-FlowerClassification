function res = HSVToName (RGB)

    names = ["Brown","White","Red", "Yellow","Yelleen", "Green","Blue","Purple","Red"];
    samples = [0,0; 0,0; 0,30; 30,50;50,68; 68,150; 150,250 ; 250,335; 335,360;];

hue = RGB(1) * 360;
sat = RGB(2);
val = RGB(3);
closestColor = 0;
if sat > 0.25
        for i = 3:size(names,2)
            if hue >= samples(i,1) && hue <= samples(i,2)
                closestColor = i;
                break;
            end
        end
        if (names(closestColor) == "Green" && sat < 0.36) 
             closestColor = 2;
        end
        if (names(closestColor) == "Yelleen")
            
            if (sat < 0.25 || (sat < 0.43 && val > 0.60))
                closestColor = 1;
            elseif (val > 0.88)
                    closestColor = 4;
            elseif (val > 0.73)
                        if hue > 68
                            closestColor = 6;
                        else
                            closestColor = 4;
                        end
            elseif (val > 0.60)
                            if hue > 60
                                closestColor = 6;
                            else
                                closestColor = 4;
                            end  
            elseif (val > 0.50)
                                if hue > 62
                                    closestColor = 6;
                                else
                                    closestColor = 4;
                                end 
            else
                closestColor = 4;
            end
        end
        if (names(closestColor) == "Yellow" || names(closestColor) == "Red") && (sat < 0.5 || (val < 0.5))
                closestColor = 1;
        end
else
    closestColor = 2;
end

res = names(closestColor);