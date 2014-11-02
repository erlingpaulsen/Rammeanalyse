function I = iboks(lsteg,lflens,tsteg,tflens)

% Antar her at lengen til flensene males fra ende til ende og lengden til
% stegene maales fra bunn av toppflens til topp av bunnflens
%
% iboks regner ut annetarealmoment til et bokstversnitt
% lsteg: lengde pa stegene [mm]
% tsteg: tykkelse pa stegene [mm]
% lflens: lengde pa flensene [mm]
% tflens: tykkelse pa flensene [mm]
%
% svar: annetarealmoment

    % Sjekker at inputverdiene er gyldige tverrsnittsmal
    if (lsteg<=0 || lflens<=0 || tflens<=0 || tsteg<=0 ||...
            tsteg>=0.5*(lflens) || tflens>=(0.5*lsteg+tflens))
        error('Ugyldige tverrsnittsmaal for boksprofil.');
    
    % Regner ut I til hele den ytre boksen og
    % trekker fra I til den indre boksen (luft)
    else 
        ytrei = (1/12)*((lsteg+2*tflens)^3*lflens);
        indrei = (1/12)*(lsteg^3*(lflens-2*tsteg));
        I = ytrei-indrei;
    end
end
