function printresultat(npunkt, punkt, nelem, elem, elementlengder, rot,...
    endemoment, midtmoment, boyespenning, skjar)
    
% printresultat henter ut info om analysen elementvis og skriver alt til en
% resultat-fil. Beregner ogsaa maksimal boyespenning og hvilken prosentandel
% denne utgjor av flytspenningen.

    disp('--- Resultatet av analysen ligger lagret i resultat.txt ---');
    
    filid = fopen('resultat.txt', 'w');
    
    % Plotter figuren med riktig nummer pa knutepunkt og elementer
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
            tvtype = 'Roerprofil';
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
            fprintf(filid, '    -Moment midt p� element: %.3f [kNm]\n', m3);
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
            fprintf(filid, '    -Moment midt p� element: %.3f [kNm]\n', m3);
            fprintf(filid, '    -Moment ende 2: %.3f [kNm]\n', m2);
        end
        
        fprintf(filid, '    -Skjaerkraft ende 1: %.3f [kN]\n', s1);
        fprintf(filid, '    -Skjaerkraft ende 2: %.3f [kN]\n', s2);
        
        bs = boyespenning(i, 1)/(10^6);
        
        if boyespenning(i, 2) == 1
            fprintf(filid,...
                '    -Maksimal boeyespenning (lokal ende 1): %.3f [MPa]\n', bs);
        elseif boyespenning(i, 2) == 2
            fprintf(filid,...
                '    -Maksimal boeyespenning (lokal ende 2): %.3f [MPa]\n', bs);
        elseif boyespenning(i, 2) == 3 && midtmoment(i, 2) == 0
            fprintf(filid,...
                '    -Maksimal boeyespenning (under punktlast): %.3f [MPa]\n', bs);
        else
            fprintf(filid,...
                '    -Maksimal boeyespenning (midt p�): %.3f [MPa]\n', bs);
        end
        
        fprintf(filid, '\n');
        
    end
    
    fprintf(filid, 'Knutepunktsrotasjoner:\n');
    for i = 1 : length(rot)
       fprintf(filid, '    -%i: %.6f\n', i, rot(i));
    end
    fprintf(filid, '\n');
    
    % Regner ut maksimal global boyespenning og finner hvor mange % av
    % flytspenningen denne utgjor
    gbsabs = max(abs(boyespenning(:, 1)));
    pos = find(gbsabs == abs(boyespenning(:, 1)));
    gbs = boyespenning(pos, 1);
    fy = 320;
    fprintf(filid,...
     'Global maksimal boeyespenning (element %i): %.3f [MPa]\n', pos, gbs/(10^6));
    fprintf(filid,...
        'Prosent av flytspenning (%i MPa): %.2f %%', fy, ((gbs/(10^6))/fy)*100);
    
    fclose(filid);

end