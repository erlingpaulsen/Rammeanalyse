function  plotfig(npunkt, punkt, elem, nelem)

    m = zeros(nelem, 4);
    %Denne funksjonen var ikke en del av selve oppgaven, men den gir et
    %simpelt plot av hvordan konstruksjonen ser ut, er greit for å få
    %visualisert konstruksjonen og det blir enklere når den skal tegnes.
    
    %Begynner med å legge alle punkter inn i en matrise slik at de enkelt
    %kan plottes.
    for i = 1:nelem
        startx = punkt(elem(i, 1), 1);
        starty = punkt(elem(i, 1), 2);
        endx = punkt(elem(i, 2), 1);
        endy = punkt(elem(i, 2), 2);
        m(i, 1) = startx;
        m(i, 2) = starty;
        m(i, 3) = endx;
        m(i, 4) = endy;
    end
    
    %Lagrer alle minimum- og maximumverdier, slik at det enkelt kan lages
    %et koordinatsystem
    xmin = min(punkt(:,1));
    xmax = max(punkt(:,1));
    ymin = min(punkt(:,2));
    ymax = max(punkt(:,2));
    dx = xmax - xmin;
    dy = ymax - ymin;
    
    x = [m(:,1) m(:,3)];
    y = [m(:,2) m(:,4)];
    
    %Plotter en linje mellom punkter det går et element.
    plot(x',y', 'k', 'LineWidth', 2)
    hold on
    
    %Her legges det til en 'o' for punkt med fri rotasjon og en 'x' for
    %punkter som er fastholdt for rotasjon.
    for j = 1:npunkt
        if (punkt(j,3)==0)
            plot(punkt(j,1),punkt(j,2), 'o', 'Color', 'k')
        else
            plot(punkt(j,1),punkt(j,2), 'x', 'Color', 'k')
        end
        text(punkt(j,1)+(dx/20), punkt(j,2)+(dy/11), num2str(j), 'Color', 'b'); %+ceil(dx/15)
    end
    
    for k = 1:nelem
        if ((m(k,1)+m(k,3))/2 == m(k,1))
            text(((m(k,1)+m(k,3))/2)-(dx/13), ((m(k,2)+m(k,4))/2), num2str(k), 'Color', 'r');
        else
            text(((m(k,1)+m(k,3))/2), ((m(k,2)+m(k,4))/2)-(dy/15), num2str(k), 'Color', 'r');
        end
    end
    
    %Her lages dimensjonene av plottet, må bruke relative verdier slik at
    %koden fungerer selv for små eller ekstremt store konstruksjoner.
    xlim([xmin-((dx/4)) xmax+((dx/4))]);
    ylim([ymin-((dy/4)) ymax+((dy/2)+1)]);
    
    %Litt forklarende tekst på plottet til slutt
    title('Nummerering av knutepunkt og elementer');
    text(xmin, ymax+((dy/2.5)), 'Blå: knutepunktnr.');
    text(xmax-((dx/2)), ymax+((dy/2.5)), 'x: fastholdt mot rotasjon');
    text(xmin, ymax+((dy/3.5)), 'Røde: elementnr.');
    text(xmax-((dx/2)), ymax+((dy/3.5)), 'o: fri rotasjon');
    grid off;

end

