function boyespenning = boyespenning(I, maxY, endeM, midtM, nelem)

% Finner maksimal boyespenning i hvert element, og lagrer svaret i en matrise.
% I: Vektor med annet arealmoment for alle elementer
% maxY: Vektor med max hoyde p� tverrsnitt for alle elementer
% endeM: matrise med endemoment for hhv ende 1 og 2 for hvert element
% midtM: Matrise med midtmoment/moment under punktlast,
% samt hvilen type last momentet kommer fra og avstand fra 
% lokal ende 1, lagret ved radindeks som tilsvarer elementnr.
% nelem: antall elementer i konstruksjonen.
%
% boyespenning: Matrise med max boyespenning i elementet tilhorende
% radindeks i kolonne 1. Posisjonen hvor max boyespenning virker i kolonne 2
% 0: midten av element/under punktlast
% 1: lokal ende 1.
% 2: lokal ende 2

    boyespenning = zeros(nelem, 2);
    for i = 1 : nelem;
        mom = [endeM(i, 1), endeM(i,2), midtM(i,1)];
        boyespenning(i, 1) = max(abs(mom)) * maxY(i) / I(i);
        pos = find(max(abs(mom)) == abs(mom));
        boyespenning(i, 2) = pos(1);
    end
end