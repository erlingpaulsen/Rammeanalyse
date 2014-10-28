function [Kn, Bn] = bc(npunkt, punkt, K, b)

% bc innforer randbetingelser 
% (1: fast innspent, 0: fri rotasjon)
% npunkt: Antall punkter
% punkt: Matrise med punktinformasjon
% K: Systemstivhetsmatrisa
% b: Lastvektor
%
%[Kn, Bn]: Returnerer en oppdatert systemstivhetsmatrise
% og lastvektor

    Kn = K;
    Bn = b;
    
    % Traverserer alle punkter og sjekker randbetingelse
    for n = 1 : npunkt
       if punkt(n, 3) == 1
           
           % Nuller ut tilhorende rad og kolonne i 
           % systemstivhetsmatrisa
           for m = 1 : npunkt
              Kn(n, m) = 0;
              Kn(m, n) = 0;
           end
           
           % Setter diagonalelementet til et vilkarlig tall
           Kn(n, n) = 1;
           
           % Nuller ut tilhorende element i lastvektoren
           Bn(n) = 0;
       end
    end
    
end

