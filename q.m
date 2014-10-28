function svar = q(nelem, elem, nlast, last, elementlengder)

% q regner ut skjaerkreftene fra ytre laster
% i lokal ende 1 og lokal ende 2
% nelem: Antall elementer
% elem: Matrise med elementinformasjon
% nlast: Antall laster
% last: Matrise med lastinformasjon
% elementlengder: Vektor med elementlengder
%
% Returnerer en (nelem x 2) matrise med skjaerkrefter fra
% ytre laster

    svar= zeros(nelem,2);

    for i = 1:nlast
        enr = elementnr(last(i,2),last(i,3), elem, nelem);

        if last(i, 1) == 0
            
            % For punktlast
            P = last(i, 4)*cosd(last(i, 5));
            svar(enr, 1) = svar(enr, 1) +...
                P -P*(last(i, 6)/elementlengder(enr));
            svar(enr, 2) = svar(enr,2) +...
                -P*(last(i, 6)/elementlengder(enr));

        elseif last (i, 1) == 1
            
            % For fordeltlast
            ilok1 = last(i, 4); %intenstiet lokal ende 1
            ilok2 = last(i, 5); %intensitet lokal ende 2
            svar(enr, 1) = svar(enr, 1) +...
                (elementlengder(enr)/3)*((ilok2/2) + ilok1);
            svar(enr, 2) = svar(enr, 2) -...
                ((elementlengder(enr)/3)*((ilok1/2) + ilok2));

        end
    end
end
        
        
    