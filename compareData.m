%Donat un model i una taula contenint les dades analitzades d'un grup de
%flors, et torna el percentatje d'encerts del model
function res = compareData(model, Test)
    yfit = model.predictFcn(Test);
    ynames = Test.flor;
    results = yfit == ynames;
    res = sum(results) / size(Test,1);