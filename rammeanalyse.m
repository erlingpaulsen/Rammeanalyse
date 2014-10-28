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
fim = moment(npunkt, punkt, nelem, elem, nlast, last, elementlengder);


% ------Setter opp lastvektor-------
b = lastvektor(fim, npunkt, punkt, nelem, elem, nmom, mom);

% ------Regner ut bøyestivheten (EI/L) til elementene-----
[elementstivhet, maxY, I] = elementstivhet(nelem, elem, elementlengder);

% ------Setter opp systemstivhetsmatrisen-------
K = stivhet(nelem, elem, elementstivhet, npunkt);


% ------Innfoerer randbetingelser-------
[Kn Bn] = bc(npunkt, punkt, K, b);
     

% -----Løser ligningssytemet -------
rot = Kn\Bn;


% -----Finner endemoment for hvert element -------
endemoment = endeM(nelem, elem, elementstivhet, rot, fim);

% -----Finner midtmoment for hvert ekement-----
midtmoment = midtM(nelem, elem, elementlengder, nlast, last, endemoment);

% -----Regner ut max bøyespenning for hvert element-----
bs = boyespenning(I, maxY, endemoment, midtmoment, nelem);

% -----Regner ut skjærkreftene for hvert element-----
skjar = skjarkraft(last, nlast, endemoment, nelem, elem, elementlengder);

% ----Skriver ut hva rotasjonen ble i de forskjellige nodene-------
%disp('Rotasjonane i de ulike punkta:')
%rot

% -----Skriver ut resultatene til et txt-dokument kalt 'resultat.txt'-----
printresultat(npunkt, punkt, nelem, elem, elementlengder, rot, endemoment, midtmoment, bs, skjar);


% -----Skriver ut hva momentene ble for de forskjellige elementene-------
%disp('Elementvis endemoment:')
%endemoment
