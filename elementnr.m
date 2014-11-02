function element = elementnr (a, b, elem, nelem)

% elementnr beregner elementnummeret basert
% på lokal ende 1 og 2
% a: Lokal ende 1
% b: Lokal ende 2
% elem: Matrise med elementinformasjon
% nelem: Antall elementer
%
% element: Returnerer tilhorende element

    for i = 1 : nelem;
        if ((a == elem(i,1) && b == elem(i,2))||(a == elem(i,2) && b == elem(i,1)));
            element = i;
            return;
        end
    end
    
    error('Det eksisterer ikke et element mellom knutepunkt %i og %i.', a, b);
    
end

