function printresultat(npunkt, punkt, nelem, elem, elementlengder, rot, endemoment, midtmoment, boyespenning, skjar)

    disp('--- Resultatet av analysen ligger lagret i resultat.txt ---');
    
    filid = fopen('resultat.txt', 'w');
    
    plotfig(npunkt, punkt, elem, nelem);
    
    fprintf(filid, '--Resultat av rammeanalyse--\n\n');
    fprintf(filid, 'Informasjon om konstruksjonen:\n');
    fprintf(filid, '    -Antall knutepunkt: %i\n', npunkt);
    fprintf(filid, '    -Antall elementer: %i\n\n', nelem);
    fprintf(filid, 'Informasjon om hvert bjelkeelement:\n\n');
    
    for i = 1 : nelem
        fprintf(filid, 'Element %i:\n', i);
        fprintf(filid, '    -Lokal ende 1: %i\n', elem(i, 1));
        fprintf(filid, '    -Lokal ende 2: %i\n', elem(i, 2));
        fprintf(filid, '    -Lengde: %.2f [m]\n', elementlengder(i));
        
        if elem(i, 4) == 1
            tvtype = 'Boksprofil';
        elseif elem(i, 4) == 2
            tvtype = 'Rørprofil';
        end
        
        fprintf(filid, '    -Tversnittstype: %s\n', tvtype);
        
        m1 = endemoment(i, 1)/(10^3);
        m2 = endemoment(i, 2)/(10^3);
        m3 = midtmoment(i, 1)/(10^3);
        s1 = skjar(i, 1)/(10^3);
        s2 = skjar(i, 2)/(10^3);
        
        if midtmoment(i, 2) == -1
            lasttype = 'Ingen ytre last';
            fprintf(filid, '    -Ytre last: %s\n', lasttype);
            fprintf(filid, '    -Moment ende 1: %.3f [kNm]\n', m1);
            fprintf(filid, '    -Moment midt på element: %.3f [kNm]\n', m3);
            fprintf(filid, '    -Moment ende 2: %.3f [kNm]\n', m2);
        elseif midtmoment(i, 2) == 0
            lasttype = 'Punktlast';
            fprintf(filid, '    -Ytre last: %s\n', lasttype);
            fprintf(filid, '    -Moment ende 1: %.3f [kNm]\n', m1);
            fprintf(filid, '    -Moment under punktlast: %.3f [kNm]\n', m3);
            fprintf(filid, '    -Moment ende 2: %.3f [kNm]\n', m2);
        else
            lasttype = 'Fordelt last';
            fprintf(filid, '    -Ytre last: %s\n', lasttype);
            fprintf(filid, '    -Moment ende 1: %.3f [kNm]\n', m1);
            fprintf(filid, '    -Moment midt på element: %.3f [kNm]\n', m3);
            fprintf(filid, '    -Moment ende 2: %.3f [kNm]\n', m2);
        end
        
        fprintf(filid, '    -Skjærkraft ende 1: %.3f [kN]\n', s1);
        fprintf(filid, '    -Skjærkraft ende 2: %.3f [kN]\n', s2);
        fprintf(filid, '    -Rotasjon ende 1: %.6f\n', rot(elem(i, 1)));
        fprintf(filid, '    -Rotasjon ende 2: %.6f\n', rot(elem(i, 2)));
        
        bs = boyespenning(i, 1)/(10^6);
        
        if boyespenning(i, 2) == 1
            fprintf(filid, '    -Maksimal bøyespenning (lokal ende 1): %.3f [MPa]\n', bs);
        elseif boyespenning(i, 2) == 2
            fprintf(filid, '    -Maksimal bøyespenning (lokal ende 2): %.3f [MPa]\n', bs);
        elseif boyespenning(i, 2) == 3 && midtmoment(i, 2) == 0
            fprintf(filid, '    -Maksimal bøyespenning (under punktlast): %.3f [MPa]\n', bs);
        else
            fprintf(filid, '    -Maksimal bøyespenning (midt på): %.3f [MPa]\n', bs);
        end
        
        fprintf(filid, '\n');
        
    end
    
    gbsabs = max(abs(boyespenning(:, 1)));
    pos = find(gbsabs == abs(boyespenning(:, 1)));
    gbs = boyespenning(pos, 1);
    fy = 350;
    fprintf(filid, 'Global maksimal bøyespenning (element %i): %.3f [MPa]\n', pos, gbs/(10^6));
    fprintf(filid, 'Prosent av flytspenning (350 MPa): %.2f %%', ((gbs/(10^6))/fy)*100);
    
    fclose(filid);

end

