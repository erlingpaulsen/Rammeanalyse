function q0 = q(nelem, elem, nlast, last, elementlengder)

% q regner ut skjaerkreftene fra ytre laster i lokal ende 1 og lokal ende 2
% nelem: Antall elementer
% elem: Matrise med elementinformasjon
% nlast: Antall laster
% last: Matrise med lastinformasjon
% elementlengder: Vektor med elementlengder
%
% Returnerer en (nelem x 2) matrise med skjaerkrefter fra
% ytre laster

    q0 = zeros(nelem,2);

    for i = 1:nlast
        enr = elementnr(last(i,2),last(i,3), elem, nelem);
        
        % For punktlast
        if last(i, 1) == 0
            a = last(i, 6); % Avstand fra lokal ende 1
            vinkel = last(i, 5); % Lastvinkel
            int = last(i, 4); % Lastintensitet
            
            P = int*cosd(vinkel);
            if a ~= 0 && a ~= 1
                q0(enr, 1) = q0(enr, 1) + P -P*(a/elementlengder(enr));
                q0(enr, 2) = q0(enr,2) -P*(a/elementlengder(enr));
            end
            
        % For fordeltlast
        elseif last (i, 1) == 1
            ilok1 = last(i, 4); %intenstiet lokal ende 1
            ilok2 = last(i, 5); %intensitet lokal ende 2
            
            q0(enr, 1) = q0(enr, 1) +...
                (elementlengder(enr)/3)*((ilok2/2) + ilok1);
            q0(enr, 2) = q0(enr, 2) -...
                ((elementlengder(enr)/3)*((ilok1/2) + ilok2));

        end
    end
end
        
        
    