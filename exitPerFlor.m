function res = exitPerFlor(reals, generats)
    %Per dos llistats de noms de flors, reals sent els noms de veritas i
    %generats els obtinguts amb el classificador torna els percentatges
    %d'exit per cada tipus de flor
    flors = ["BotodOr" "Crocus" "Fadrins" "Gerbera" "Hemerocallis" "Narcis" "Buixol" "DentdeLleo" "Fritillaria" "Girasol" "Lliri" "Viola","Zero"];
    res = [0,0,0,0,0,0,0,0,0,0,0,0,0];
    resId = 1;
    for flor = flors(:)'
        res(resId) = sum(and(reals == generats, reals == flor));  
        res(resId) = res(resId) / sum(reals == flor) * 100;
        resId = resId + 1;
    end