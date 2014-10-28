function [elemstivhet, maxY, Is] = elementstivhet(nelem, elem, elementlengder)

% elementstivhet regner ut stivheten (EI/L) til et element og lengste
% avstand fra arealsenteret
% E: elementets E-modul
% nelem: Antall elementer
% elem: Matrise med elementinformasjon
% elementlengder: Vektor med elementlengder
%
% svar: returnerer -1 ved ugyldig input, elementstivhet og maxY ellers
   
    elemstivhet = zeros(nelem, 1);
    maxY = zeros(nelem, 1);
    Is = zeros(nelem, 1);

    for i = 1 : nelem
        E = elem(i, 3) * 10^9;
        L = elementlengder(i);
        tvtype = elem(i, 4);
        
        % Regner ut I for boksprofil eller rørprofil (-1 hvis ugyldig
        % tverrsnittstype
        if tvtype == 1
            lsteg = elem(i, 5)/(10^3); %Steglengde
            lflens = elem(i, 6)/(10^3); %Flenslengde
            tsteg = elem(i, 7)/(10^3); %Stegtykkelse
            tflens = elem(i, 8)/(10^3); %Flenstykkelse
            
            I = iboks(lsteg, lflens, tsteg, tflens);
            maxY(i) = lsteg + 2*tflens;
        elseif tvtype == 2
            ir = elem(i, 5)/(10^3); %Indre radius
            yr = elem(i, 6)/(10^3); %Ytre radius
            
            I = iror(ir, yr);
            maxY(i) = yr;
        else
            I = -1;
        end
        
        Is(i) = I;
        
        %Legger elementstivheten inn i en vektor (-1 hvis ugyldig input)
        if I == -1 
            elemstivhet(i) = -1; 
        else
            elemstivhet(i) = (E*I)/L;
        end
    end
    
end
        