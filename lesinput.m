function [npunkt, punkt, autodim, nelem, elem, nlast, last, nmom, mom] = lesinput()

%   %i = heltall (integer)  %f : desimaltall (flyt-tall)

%Apner inputfila
filid = fopen('inputfig3.txt','r');

%Leser antall knutepunkter
npunkt = fscanf(filid,'%i',[1 1]);

% Leser inn XY-koordinater til knutepunktene
% Nodenummer tilsvarer radnummer i punkt
% Kolonne 1: X-koordinat
% Kolonne 2: Y-koordinat
% Kolonne 3: Grensebetingelse
%           (fast innspent = 1, fri rotasjon = 0)
punkt = fscanf(filid,'%f %f %i',[3 npunkt])';

% Leser inn verdi for autodimensjonering
% 0: Leser inn manuelt innskrevne tverrsnittsmal
% 1: Velger autodimensjonering
autodim = fscanf(filid, '%i', [1 1]);

% Leser antall elementer
nelem = fscanf(filid,'%i',[1 1]);

% Leser konnektivitet: Sammenheng elementender og 
% knutepunktnummer. Samt EI og tverrsnittsmal for elementene
% Elementnummer tilsvarer radnummer i elem
% Kolonne 1: Knutepunktnummer for lokal ende 1
% Kolonne 2: Knutepunktnummer for lokal ende 2
% Kolonne 3: E-modul [GPa]
% Kolonne 4: Tverrsnittstype 
%           (boksprofil = 1, rorprofil = 2)
% Kolonne 5: Indre radius hvis rorprofil [mm], 
%            steglengde [mm] hvis boksprofil
% Kolonne 6: Ytre radius hvis rorprofil [mm], 
%            flenslengde [mm] hvis boksprofil
% Kolonne 7: Stegtykkelse [mm],
%           (0 hvis rorprofil)
% Kolonne 8: Flenstykkelse [mm],
%           (0 hvis rorprofil)
elem = fscanf(filid,'%i %i %f %i %f %f %f %f',[8 nelem])';

% Leser antall laster 
nlast = fscanf(filid,'%i',[1 1]);

% Leser lastdata
last = fscanf(filid,'%i %i %i %f %f %f',[6 nlast])';
last = splitlast(last, nlast, elem, punkt, npunkt);
nlast = length(last(:, 1));
% Kolonne 1: Type last (0 er punktlast, 1 er fordelt last)
% Kolonne 2: Lokal ende 1
% Kolonne 3: Lokal ende 2
% Kolonne 4: Intensitet ende 1 [N/m] hvis fordelt last,
%            Intensitet [N] hvis punktlast
%           (Positiv retning ned eller mot hoyre dersom lokal
%            ende 1 er hhv til venstre eller ned for lokal
%           ende 2)
% Kolonne 5: Intensitet ende 2 [N/m] hvis fordelt last,
%           Vinkel i grader hvis punktlast
%          (vinkelrett pa bjelke => 0 vinkel, 
%           positivt mot klokken)
% Kolonne 6: Avstand fra ende 1 [m]

% Leser inn antall ytre momenter
nmom = fscanf(filid, '%i', [1 1]);

% Leser inn momentdata
mom = fscanf(filid, '%i %f', [2 nmom])';
% Kolonne 1: Knutepunkt
% Kolonne 2: Intensitet [N*m] (positivt med klokken)

% Lukker inputfila
fclose(filid);

end
