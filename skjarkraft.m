function skjarkraft = skjarkraft(last, nlast, endeM,...
    nelem, elem, elementlengder)

% Regner ut skjærkraften i hver ende i alle
% elementer i konstruksjonen.
% last: matrise med alle laster i konstruksjonen.
% nlast: antall laster i konstruksjonen
% endeM: Matrise med alle endemomentene for alle elementer
% nelem: Antall elementer i konstruksjonen.
% elem: matrise med alle elementer i konstruksjonen.
% elementlengder: Vektor med lengden til alle elementene.
%
% skjarkraft: (nelem x 2) matrise med endeskjærkraften
%             til hvert element.

    skjarkraft = zeros(nelem, 2);
    q0 = q(nelem, elem, nlast, last, elementlengder);
    for i = 1 : nelem;
        skjarkraft(i, 1) = -(endeM(i, 1) + endeM(i, 2))/...
            elementlengder(i) + q0(i, 1);
        skjarkraft(i, 2) = -(endeM(i, 1) + endeM(i, 2))/...
            elementlengder(i) + q0(i, 2);
    end
end