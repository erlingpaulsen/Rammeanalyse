function b = lastvektor(fim, npunkt, nelem, elem, nmom, mom)

% lastvektor beregner lastvektoren til systemet
% fim: Vektor med fastinnspenningsmomenter
% npunkt: Antall knutepunkter
% punkt: Matrise med knutepunktsinfo
% nelem: Antall elementer
% elem: Matrise med elementinfo
%
% b: Lastvektor

    b = zeros(npunkt, 1);

    % Summerer fastinnspenningsmoment med negativt fortegn
    % for begge lokale ender for hvert element 
    for i = 1:nelem;
    
      b(elem(i,1)) = b(elem(i,1)) + fim(i, 1)*-1;
      b(elem(i,2)) = b(elem(i,2)) + fim(i, 2)*-1;

    end
    
    % Gar gjennom alle pasatte moment, og adderer disse
    % pa tilhorende knutepunkts fastinnspenningsmoment
    for i = 1:npunkt;
        for j = 1:nmom;
            if (i == mom(j, 1));
                b(i) = b(i) + mom(j, 2);
            end
        end
    end
end

