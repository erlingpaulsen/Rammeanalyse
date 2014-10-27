function boyespenning = boyespenning(I, maxY, endeM, midtM, nelem)
% Finner maksimal bøyespenning i hvert element, og lagrer svaret i en
% matrise.
% I: Vektor med alle 2.arealmoment lagret i indeksen som tilsvarer
% elementnr.
% maxY: Vektor med max høyde på tverrsnitt lagret i indeks som tilsvarer
% elementnr.
% endeM: matrise med endemoment for hhv ende 1 og 2 lagret i radindeks som
% tilsvarer elementnr.
% midtM: Matrise med midtmoment/moment under punktlast, samt hvilen type
% last momentet kommer fra og avstand fra lokal ende en, lagret ved
% radindeks som tilsvarer elementnr.
% nelem: antall elementer i konstruksjonen.
%
% boyespenning: Matrise med max bøyespenning i elementet tilhørende
% radindeks i kolonne 1. Posisjonen hvor max bøyespenning virker i kolonne
% 2(0: midten av element/under punktlast. 1: lokal ende 1. 2: lokal ende 2.
boyespenning = zeros(nelem, 2);
for i = 1 : nelem;
    mom = [endeM(i, 1), endeM(i,2), midtM(i,1)];
    boyespenning(i, 1) = max(abs(mom)) * maxY(i) / I(i);
    pos = find(max(abs(mom)) == abs(mom));
    boyespenning(i, 2) = pos(1);
end
end