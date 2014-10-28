function rammeanalyse_autodim(npunkt, punkt, nelem, elem, nlast, last, nmom, mom)
    
    lflens = 50;
    tflens = 1;
    lsteg = 50;
    tsteg = 1;
    ir = 24;
    yr = 25;
    
    prosent_fy = 100;
    fy = 350;
    
    elementlengder = lengder(punkt,elem,nelem);
    fim = moment(npunkt, punkt, nelem, elem, nlast, last, elementlengder);
    b = lastvektor(fim, npunkt, punkt, nelem, elem, nmom, mom);
    
    while prosent_fy > 70
        
        for i = 1 : nelem
            if elem(i, 4) == 1
                elem(i, 5) = lsteg;
                elem(i, 6) = lflens;
                elem(i, 7) = tsteg;
                elem(i, 8) = tflens;
            elseif elem(i, 4) == 2
                elem(i, 5) = ir;
                elem(i, 6) = yr;
            end
        end
        
        [elemstivhet, maxY, I] = elementstivhet(nelem, elem, elementlengder);
        K = stivhet(nelem, elem, elemstivhet, npunkt);
        [Kn, Bn] = bc(npunkt, punkt, K, b);
        rot = Kn\Bn;
        endemoment = endeM(nelem, elem, elemstivhet, rot, fim);
        midtmoment = midtM(nelem, elem, elementlengder, nlast, last, endemoment);
        bs = boyespenning(I, maxY, endemoment, midtmoment, nelem);
        skjar = skjarkraft(last, nlast, endemoment, nelem, elem, elementlengder);
        
        gbsabs = max(abs(bs(:, 1)));
        pos = gbsabs == abs(bs(:, 1));
        gbs = bs(pos, 1);
        prosent_fy = ((gbs/(10^6))/fy)*100;
        
        
        lflens = lflens + 10;
        tflens = tflens + 1;
        lsteg = lsteg + 12;
        tsteg = tsteg + 1;
        ir = ir + 5;
        yr = yr + 5.3;
    end
    
    printresultat(npunkt, punkt, nelem, elem, elementlengder, rot, endemoment, midtmoment, bs, skjar);
    disp('Autodimensjonering brukt. Endte opp med f�lgende tverrsnittsprofiler:');
    disp('    -Boksprofil:');
    fprintf('        -Steglengde: %.2f [mm]\n', lsteg);
    fprintf('        -Flenslengde: %.2f [mm]\n', lflens);
    fprintf('        -Stegtykkelse: %.2f [mm]\n', tsteg);
    fprintf('        -Flenstykkelse: %.2f [mm]\n', tflens);
    disp('    -R�rsprofil:');
    fprintf('        -Indre radius: %.2f [mm]\n', ir);
    fprintf('        -Ytre radius: %.2f [mm]\n', yr);

end

