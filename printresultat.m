function printresultat(npunkt, punkt, nelem, elem, elementlengder, rot, endemoment, midtmoment, boyespenning, skjar)

    filid = fopen('resultat.txt', 'w');
    
    plotfig(npunkt, punkt, elem, nelem);
    
    fprintf(filid, '--Resultat av rammeanalyse--\n\n');
    fprintf(filid, 'Informasjon om konstruksjonen:\n');
    fprintf(filid, '    -Antall knutepunkt: %i\n', npunkt);
    fprintf(filid, '    -Antall elementer: %i\n\n', nelem);
    fprintf(filid, 'Informasjon om hvert bjelkeelement:\n\n');
    
    for i = 1 : nelem
        fprintf('Element %i:\n', i);
        fprintf('    -Lokal ende 1: %i\n', elem(i, 1));
        fprintf('    -Lokal ende 2: %i\n', elem(i, 2));
        fprintf('    -Lengde: %d\n', elementlengder(i));
        
        m1 = endemoment(i, 1)/(10^3);
        m2 = endemoment(i, 2)/(10^3);
        m3 = midtmoment(i, 1)/(10^3);
        s1 = skjar(i, 1)/(10^3);
        s2 = skjar(i, 2)/(10^3);
        
        if midtmoment(i, 2) == -1
            lasttype = 'Ingen ytre last';
            fprintf('    -Ytre last: %s\n', lasttype);
            fprintf('    -Moment ende 1: %f [kNm]\n', m1);
            fprintf('    -Moment midt på element: %f [kNm]\n', m3);
            fprintf('    -Moment ende 2: %f [kNm]\n', m2);
        elseif midtmoment(i, 2) == 0
            lasttype = 'Punktlast';
            fprintf('    -Ytre last: %s\n', lasttype);
            fprintf('    -Moment ende 1: %f [kNm]\n', m1);
            fprintf('    -Moment under punktlast: %f [kNm]\n', m3);
            fprintf('    -Moment ende 2: %f [kNm]\n', m2);
        else
            lasttype = 'Fordelt last';
            fprintf('    -Ytre last: %s\n', lasttype);
            fprintf('    -Moment ende 1: %f [kNm]\n', m1);
            fprintf('    -Moment midt på element: %f [kNm]\n', m3);
            fprintf('    -Moment ende 2: %f [kNm]\n', m2);
        end
        
        fprintf('    -Skjærkraft ende 1: %f [kN]\n', s1);
        fprintf('    -Skjærkraft ende 2: %f [kN]\n', s2);
        fprintf('    -Rotasjon ende 1: %f\n', rot(elem(i, 1)));
        fprintf('    -Rotasjon ende 2: %f\n', rot(elem(i, 2)));
        
        bs = boyespenning(i, 1)/(10^6);
        
        if boyespenning(i, 2) == 1
            fprintf('    -Maksimal bøyespenning (lokal ende 1): %f [MPa]\n', bs);
        elseif boyespenning(i, 2) == 2
            fprintf('    -Maksimal bøyespenning (lokal ende 2): %f [MPa]\n', bs);
        elseif boyespenning(i, 2) == 3 && midtmoment(i, 2) == 0
            fprintf('    -Maksimal bøyespenning (under punktlast): %f [MPa]\n', bs);
        else
            fprintf('    -Maksimal bøyespenning (midt på): %f [MPa]\n', bs);
        end
        
        fprintf('\n');
        
    end
    
    gbsabs = max(abs(boyespenning(:, 1)));
    pos = find(gbsabs == abs(boyespenning(:, 1)));
    gbs = boyespenning(pos, 1);
    fy = 350;
    fprintf('Global maksimal bøyespenning (element %i): %f [MPa]\n', pos, gbs/(10^6));
    fprintf('Prosent av flytspenning (350 MPa): %f\n', ((gbs/(10^6))/fy)*100);
    
    fclose(filid);

end

