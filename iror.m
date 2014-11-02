function I = iror(ir, yr)

% iror regner ut annetarealmoment for et rortverrsnitt
% ir: indre radius [mm]
% yr: ytre radius [mm]
% svar: annetarealmoment
    
    % Sjekker at inputverdiene er gyldige tverrsnittsmal
    if (yr<=ir || ir<=0)
        error('Ugyldige tverrsnittsmaal for roerprofil.');
    
    % Regner ut I for tverrsnittet
    else
        I = (pi/4)*((yr)^4 - (ir)^4);
    end
end