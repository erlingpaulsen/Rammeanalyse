function svar = iboks(lsteg,lflens,tsteg,tflens)

% Antar her at lengen til flensene m�les fra ende til ende
% og lengden til stegene m�les fra bunn av toppflens
% til topp av bunnflens
%
% iboks regner ut annetarealmoment til et bokstversnitt
% lsteg: lengde p� stegene [mm]
% tsteg: tykkelse p� stegene [mm]
% lflens: lengde p� flensene [mm]
% tflens: tykkelse p� flensene [mm]
%
% svar: returnerer -1 ved ugyldig input, I ellers

    % Sjekker at inputverdiene er gyldige tverrsnittsm�l
    if (lsteg<=0 || lflens<=0 || tflens<=0 || tsteg<=0 ||...
            tsteg>=0.5*(lflens) || tflens>=(0.5*lsteg+tflens))
        svar = -1;
    
    % Regner ut I til hele den ytre boksen og trekker
    % fra I til den indre boksen (luft)
    else 
        ytrei = (1/12)*((lsteg+2*tflens)^3*lflens);
        indrei = (1/12)*(lsteg^3*(lflens-2*tsteg));
        svar = ytrei-indrei;
    end
end
