function [i1, i2] = finnintensitet(lasti, k1, k2, punkt)

% Finner intensiteten til last lasti ved punktene k1 og k2.
% k1 og k2 er sortert slik at k1 ligger lenger ned
% og mot venstre enn k2.
% lasti: En rad fra lastmatrisa
% k1, k2: Knutepunkt
% punkt: Matrise med punktinformasjon
%
% Returner intensiteten ved k1 (i1) og k2 (i2)
   
    % l er total avstand lasti går over, l1 er avstand fra
    % lastis lokal ende 1 til k1, l2 er avstand fra lasti's
    % lokal ende 1 til k2.
    l = pavstand(punkt(lasti(2), 1), punkt(lasti(2), 2),...
        punkt(lasti(3), 1), punkt(lasti(3), 2));
    l1 = pavstand(punkt(lasti(2), 1), punkt(lasti(2), 2),...
        punkt(k1, 1), punkt(k1, 2));
    l2 = pavstand(punkt(lasti(2), 1), punkt(lasti(2), 2),...
        punkt(k2, 1), punkt(k2, 2));
    
    %i1 lastis intensitet ved k1, i2 lastis intensitet ved k2.
    i1 = lasti(4) + ((lasti(5) - lasti(4))/l)*l1;
    i2 = lasti(4) + ((lasti(5) - lasti(4))/l)*l2;
    
end