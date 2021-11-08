function res = HSVToNameforback (RGB)

    names = ["otros","Brown","Yelleen","Green","LightBlue","otros","Black"];
    samples = [0,0;0,50;51,67;68,150;150,250;251,360;251,360];

hue = RGB(1) * 360;
sat = RGB(2);
val = RGB(3);
closestColor = 1;
if (sat > 0.25 && val > 0.12) || (sat > 0.10 && val < 0.85 && (hue < 25 || hue > 120))
        for i = 2:size(names,2)
            if hue >= samples(i,1) && hue <= samples(i,2)
                closestColor = i;
                break;
            end
        end
          if (names(closestColor) == "Green" && sat < 0.36) 
                closestColor = 1;
           end
          if (names(closestColor) == "Yelleen")
              
              if (sat < 0.25 || (sat < 0.43 && val > 0.60))
                  closestColor = 1;
              elseif (val > 0.88)
                      closestColor = 2;
              elseif (val > 0.73)
                          if hue > 68
                              closestColor = 4;
                          else
                              closestColor = 2;
                          end
              elseif (val > 0.60)
                              if hue > 60
                                  closestColor = 4;
                              else
                                  closestColor = 2;
                              end  
              elseif (val > 0.50)
                                  if hue > 62
                                      closestColor = 4;
                                  else
                                      closestColor = 2;
                                  end 
              else
                  closestColor = 2;
              end
          end
        if names(closestColor) == "Brown" && ((sat > 0.4 && (val > 0.5)) || (hue < 14 && sat > 0.85 && val > 0.40 ) ||(sat < 0.35 && val > 0.70))
                closestColor = 1;
        end
else
    if val > 0.4
        closestColor = 1;
    else
        closestColor = 7;
    end
end

if val < 0.08 || ( val < 0.15 && sat < 0.3)
    closestColor = 7;
end
res = names(closestColor);