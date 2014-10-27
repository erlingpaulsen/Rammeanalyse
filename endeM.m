function endemoment = endeM(nelem, elem, elementstivhet, rot, fim)
    
    endemoment = zeros(nelem, 2);
    lokalK = [4 2; 2 4];
    
    % Summerer fastinnspenningsmoment og bjelkeendemoment fra rotasjoner
    for i = 1 : nelem
       lokal1 = elem(i, 1);
       lokal2 = elem(i, 2);
       lokalrot = [rot(lokal1), rot(lokal2)]';
       lokalfim = [fim(2*i - 1), fim(2*i)]';
       
       K = elementstivhet(i)*lokalK;
       
       endemoment(i, 1) = K(1,:)*lokalrot + lokalfim(1);
       endemoment(i, 2) = K(2,:)*lokalrot + lokalfim(2);
       
    end

end

