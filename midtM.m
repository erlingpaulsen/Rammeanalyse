function midtmoment = midtM(nelem, elem, elementlengder, nlast, last, endemoment)

% midtM regner ut momentet pa midten av et element hvis det er fordelt last,
% eller rett under en punktlast
% nelem: Antall elementer
% elem: Matrise med elementinformasjon
% elementlengder: Vektor med elementlengder
% nlast: Antall laster
% last: Matrise med lastinformasjon
% endemoment: Matrise med elementvis endemomenter
%
% midtmoment: Matrise med midtmoment, lasttype og
%             avstand fra lokal ende 1

    punktlast = 0;
    fordeltlast = 1;
    ingenlast = -1;
    
    midtmoment = zeros(nelem, 3);
    
    for i = 1 : nelem
       lok1 = elem(i, 1);
       lok2 = elem(i, 2);
       m1 = endemoment(i, 1);
       m2 = endemoment(i, 2);
       
       % Setter 'default' til ingen ytre last
       midtmoment(i, 1) = (-m1 + m2) / 2;
       midtmoment(i, 2) = ingenlast;
       
       % Traverserer lastene for a sjekke om elementer har
       % en ytre last, oppdaterer da midtmomenter
       for j = 1 : nlast
           lok1_ = last(j, 2);
           lok2_ = last(j, 3);
           
           if (lok1 == lok1_ && lok2 == lok2_) || (lok1 == lok2_ && lok2 == lok1_)
               
               L = elementlengder(i);
               
               % Bruker superposisjon og regner ut momentet under en punktlast
               if last(j, 1) == punktlast
                   a = last(j, 6);
                   teta = last(j, 5);
                   P = last(j, 4);
                   endembidrag = (-m1 * (L - a) + (m2 * a)) / L;
                   punktbidrag = (-(P * cosd(teta)) * a * (L - a)) / L;
                   midtmoment(i, 1) = endembidrag + punktbidrag;
                   midtmoment(i, 2) = punktlast;
                   midtmoment(i, 3) = a;
               
               % Bruker superposisjon og regner ut momentet pa midten
               elseif last(j, 1) == fordeltlast
                   q1 = last(j, 4);
                   q2 = last(j, 5);
                   endembidrag = (-m1 + m2) / 2;
                   fordeltbidrag = - ((q1 * L^2) / 16) - ((q2 * L^2) / 16);
                   midtmoment(i, 1) = endembidrag + fordeltbidrag;
                   midtmoment(i, 2) = fordeltlast;
                   midtmoment(i, 3) = L/2;
               end
           end
       end
    end
end

