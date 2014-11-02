function svar = iror(ir, yr)

% iror regner ut annetarealmoment for et rortverrsnitt
% ir: indre radius [mm]
% yr: ytre radius [mm]
% svar: returnerer -1 ved ugyldig input, I ellers
    
    % Sjekker at inputverdiene er gyldige tverrsnittsmal
    if (yr<=ir || ir<=0)
        svar = -1;
    
    % Regner ut I for tverrsnittet
    else
        svar = (pi/4)*((yr)^4 - (ir)^4);
    end
end