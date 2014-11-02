% Sletter alle variabler
clear all


% -----Leser input-data-----
[npunkt, punkt, autodim, nelem, elem, nlast, last, nmom, mom] = lesinput();


if autodim == 1
    rammeanalyse_autodim(npunkt, punkt, nelem, elem, nlast, last, nmom, mom);
    return;
end


% -----Regner lengder til elementene-----
elementlengder = lengder(punkt,elem,nelem);


% ------Fastinnspenningsmomentene------
fim = moment(nelem, elem, nlast, last, elementlengder);


% ------Setter opp lastvektor-------
b = lastvektor(fim, npunkt, nelem, elem, nmom, mom);

% ------Regner ut boyestivheten (EI/L) til elementene-----
[elementstivhet, maxY, I] = elementstivhet(nelem, elem, elementlengder);

% ------Setter opp systemstivhetsmatrisen-------
K = stivhet(nelem, elem, elementstivhet, npunkt);


% ------Innforer randbetingelser-------
[Kn, Bn] = bc(npunkt, punkt, K, b);
     

% -----Loser ligningssytemet -------
rot = Kn\Bn;

% -----Finner endemoment for hvert element -------
endemoment = endeM(nelem, elem, elementstivhet, rot, fim);

% -----Finner midtmoment for hvert ekement-----
midtmoment = midtM(nelem, elem, elementlengder, nlast, last, endemoment);

% -----Regner ut max boyespenning for hvert element-----
bs = boyespenning(I, maxY, endemoment, midtmoment, nelem);

% -----Regner ut skjarkreftene for hvert element-----
skjar = skjarkraft(last, nlast, endemoment, nelem, elem, elementlengder);

% -----Skriver ut resultatene til 'resultat.txt'-----
printresultat(npunkt, punkt, nelem, elem, elementlengder,...
    rot, endemoment, midtmoment, bs, skjar);