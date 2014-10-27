function K = stivhet(nelem, elem, elementstivhet, npunkt)

% stivhet beregner systemstivhetsmatrisa
% nelem: Antall elementer
% elem: Matrise med elementinformasjon
% lokalk: Elementstivhetsmatrisa
%
% K: Systemstivhetsmatrisa

    lokalk = [4 2; 2 4];
    K = zeros(npunkt);
    
    for i = 1:nelem
        % Fyller opp systemstivhetsmatrisa K ved hjelp av
        % elementstivhetsmatrisa og elementstivheten
        lok1 = elem(i, 1);
        lok2 = elem(i, 2);
        stivhet = elementstivhet(i);
        
        K(lok1, lok1) = K(lok1, lok1) + lokalk(1, 1)*stivhet;
        K(lok1, lok2) = K(lok1, lok2) + lokalk(1, 2)*stivhet;
        K(lok2, lok1) = K(lok2, lok1) + lokalk(2, 1)*stivhet;
        K(lok2, lok2) = K(lok2, lok2) + lokalk(2, 2)*stivhet;
    end

end

