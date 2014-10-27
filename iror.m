function svar = iror(ir, yr)

% iror regner ut annetarealmoment for et rørtverrsnitt
% ir: indre radius [mm]
% yr: ytre radius [mm]
% svar: returnerer -1 ved ugyldig input, I ellers
    
    % Sjekker at inputverdiene er gyldige tverrsnittsmål
    if (yr<=ir || ir<=0)
        svar = -1;
    
    % Regner ut I for tverrsnittet
    else
        svar = (pi/64)*((yr*2)^4 - (ir*2)^4);
    end
end