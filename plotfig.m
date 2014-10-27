function  plotfig( npunkt, punkt, elem, nelem )
    m = zeros(nelem, 4);
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
    
    x = [m(:,1) m(:,3)];
    y = [m(:,2) m(:,4)];
    plot(x',y', 'k', 'LineWidth', 2)
    hold on
    for j = 1:npunkt
        if (punkt(j,3)==0)
            plot(punkt(j,1),punkt(j,2), 'o', 'Color', 'k')
        else
            plot(punkt(j,1),punkt(j,2), 'x', 'Color', 'k')
        end
        text(punkt(j,1)+1, punkt(j,2)+2, num2str(j), 'Color', 'b');
    end
    
    for k = 1:nelem
        if ((m(k,1)+m(k,3))/2 == m(k,1))
            text(((m(k,1)+m(k,3))/2)-3, ((m(k,2)+m(k,4))/2), num2str(k), 'Color', 'r');
        else
            text(((m(k,1)+m(k,3))/2), ((m(k,2)+m(k,4))/2)-2, num2str(k), 'Color', 'r');
        end
    end
    
    xlim([(min(punkt(:,1))-10) (max(punkt(:,1))+10)]);
    ylim([(min(punkt(:,2))-10) (max(punkt(:,2))+25)]);
    title('Nummerering av knutepunkt og elementer');
    text(((max(punkt(:,1))-20)), ((max(punkt(:,2))+21)), 'Blå: knutepunktnr.');
    text(((max(punkt(:,1))-20)), ((max(punkt(:,2))+17)), 'Røde: elementnr.');
    text(((max(punkt(:,1))-20)), ((max(punkt(:,2))+13)), 'x: fastholdt mot rotasjon');
    text(((max(punkt(:,1))-20)), ((max(punkt(:,2))+9)), 'o: fri rotasjon');
    grid off;

end

