function [elemstivhet, maxY, Is] = elementstivhet(nelem, elem, elementlengder)

% elementstivhet regner ut stivheten (EI/L) til et element, lengste avstand fra
% arealsenteret og annet arealmoment for tverrsnittet
% E: elementets E-modul
% nelem: Antall elementer
% elem: Matrise med elementinformasjon
% elementlengder: Vektor med elementlengder
%
% svar: returnerer input, elementstivhet og maxY
   
    elemstivhet = zeros(nelem, 1);
    maxY = zeros(nelem, 1);
    Is = zeros(nelem, 1);

    for i = 1 : nelem
        E = elem(i, 3) * 10^9;
        L = elementlengder(i);
        tvtype = elem(i, 4);
        
        % Regner ut I for boksprofil eller rorprofil
        % (-1 hvis ugyldig tverrsnittstype)
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
            error('Ugyldig tverrsnittstype. Maa vaere 1 eller 2.');
        end
        
        Is(i) = I;
        elemstivhet(i) = (E*I)/L;
    end
    
end
        