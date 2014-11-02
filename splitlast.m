function nylast = splitlast(last, nlast, elem, punkt, npunkt)

% splitlast endrer lastmatrisen slik at alle fordelte laster som gaar over flere
% elemtenter vil bli splittet opp i kortere fordelte laster som gaar over
% noyaktig ett element.
% last: Den opprinnelige lastmatrisen.
% nlast: antall laster i den opprinnelige lastmatrisen.
% elem: matrise med alle elementer i konstruksjonen.
% punkt: matrise med alle knutepunktene i konstruksjonen.
% npunkt: antal knutepunkter i konstruksjonen.
%
% nylast: Den nye lastmatrisen, hvor alle fordelte laster gaar over kun et element.

    nylast = [];
    
    % Gar gjennom alle fordelte laster i lastmatrisen,
    % og finner koordinatene til endepunktene gk1 og gk2
    for i = 1:nlast;
        if last(i, 1) == 1;
            knutepunkter = last(i, 2);
            gk1 = last(i, 2);
            gk2 = last(i, 3);
            koord1 = [punkt(gk1, 1), punkt(gk1, 2)];
            koord2 = [punkt(gk2, 1), punkt(gk2, 2)];
                
            % Gaar gjennom alle punkter i konstruksjonen og sjekker om punktet
            % ligger mellom gk1 og gk2. I safall ma den fordelte lasten splittes.
            for j = 1 : npunkt;
                
                % Dersom den fordelte lasten er vertlikal.
                if koord1(1) == koord2(1);
                    if ((koord1(2) < punkt(j, 2) && koord2(2) > punkt(j,2)) ||...
                            (koord1(2) > punkt(j, 2) && koord2(2) < punkt(j,2))) &&...
                            (punkt(j,1) == koord1(1));
                        
                        knutepunkter = [knutepunkter, j];
                        
                    end
                    
                % Dersom den fordelte lasten er horisontal.
                elseif koord1(2) == koord2(2);
                    if ((koord1(1) < punkt(j, 1) && koord2(1) > punkt(j,1)) ||...
                            (koord1(1) > punkt(j, 1) && koord2(1) < punkt(j,1))) &&...
                            (punkt(j,2) == koord1(2));
                        
                        knutepunkter = [knutepunkter, j];
                        
                    end
                end
            end
            
            knutepunkter = [knutepunkter, last(i, 3)];
            
            % Sorterer knutepunktene etter koordinatene.
            knutepunkter = sortbykoord(knutepunkter, punkt);
            
            % Gaar gjennom alle knutepunkter den fordelte lasten virker pa, 
            % og finner intensiteten ved hvert knutepunkt.
            for j = 1 : length(knutepunkter);
                for k = j + 1 : length(knutepunkter);
                    if (elementnr(knutepunkter(j), knutepunkter(k), elem,...
                            length(elem(:,1))) > 0);
                        
                        [i1, i2] = finnintensitet(last(i,:), knutepunkter(j),...
                            knutepunkter(k), punkt);
                        nylast = [nylast; [1, knutepunkter(j), knutepunkter(k),...
                            i1, i2, 0]];
                        
                    end
                end
            end
            
        else
            nylast = [nylast; last(i, :)];
        end
        
    end
end