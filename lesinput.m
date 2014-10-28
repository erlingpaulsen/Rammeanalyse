function [npunkt, punkt, nelem, elem, nlast, last, nmom, mom]=lesinput()


%   %i = heltall (integer)  %f : desimaltall (flyt-tall)


%Åpner inputfila
filid = fopen('inputfig3.txt','r');


%Leser antall knutepunkter
npunkt = fscanf(filid,'%i',[1 1]);


% Leser inn XY-koordinater til knutepunktene
% Nodenummer tilsvarer radnummer i "Node-variabel"
% x-koordinat lagres i kolonne 1, y-koordinat i kolonne 2
% Grensebetingelse lagres i kolonne 3, fast innspent=1 og fri rotasjon=0
punkt = fscanf(filid,'%f %f %i',[3 npunkt])';


%Leser antall elementer
nelem = fscanf(filid,'%i',[1 1]);


%Leser konnektivitet: sammenheng elementender og knutepunktnummer. Og EI for elementene
% Elementnummer tilsvarer radnummer i "Elem-variabel"
% Knutepunktnummer for lokal ende 1 lagres i kolonne 1
% Knutepunktnummer for lokal ende 2 lagres i kolonne 2
% E-modul for materiale lagres i kolonne 3 [GPa]
% Tverrsnittstype lagres i kolonne 4, boksprofil=1 og rørprofil=2
% Indre radius hvis rørprofil [mm] , steglengde hvis boksprofil lagres i kolonne 5
% Ytre radius hvis rørprofil [mm] , flenslengde hvis boksprofil lagres i kolonne 6
% Stegtykkelse [mm] (0 hvis rørprofil) lagres i kolonne 7
% Flenstykkelse [mm] (0 hvis rørprofil) lagres i kolonne 8
elem = fscanf(filid,'%i %i %f %i %f %f %f %f',[8 nelem])';


%Leser antall laster 
nlast = fscanf(filid,'%i',[1 1]);


%Leser lastdata
last = fscanf(filid,'%i %i %i %f %f %f',[6 nlast])';
last = splitlast(last, nlast, elem, punkt, npunkt);
nlast = length(last(:, 1));
%Kolonne 1: Type last (0 er punktlast, 1 er fordelt last)
%Kolonne 2: Lokal ende 1
%Kolonne 3: Lokal ende 2
%Kolonne 4: Intensitet ende 1 [N/m] / Intensitet [N](Positiv retning ned eller 
%           mot høyre dersom lokal ende 1 er hhv til venstre eller ned for lokal ende 2)
%Kolonne 5: Type 1: Intensitet ende 2 [N/m], Type 2: Vinkel i grader
%           (vinkelrett på bjelke ==> 0 vinkel, positivt mot klokken)
%Kolonne 6: Avstand fra ende 1 [m]

%Leser inn antall ytre momenter
nmom = fscanf(filid, '%i', [1 1]);

%Leser inn momentdata
mom = fscanf(filid, '%i %f', [2 nmom])';
%Kolonne 1: Knutepunkt
%Kolonne 2: Intensitet [N*m] (positivt med klokken)



%Lukker inputfila
fclose(filid);




end
