function nykp = sortbykoord(kp, punkt)

% sortbykoord sorterer en vektor med knutepunktnummeretter
% koordinatene til knutepunktet(bubble sort).
% kp: vektor med knutepunkter
% punkt: Matrise med alle knutepunkter i konstruksjonen.
%
% nykp: vektor med knutepunkter, sortert etter koordinater.

    n = length(kp);
    
    for i = (n-1) : -1 : 1;
        teller = 0;
        for j = 1 : i;
            % Gsar gjennom alle knutepunkt. Sammenligner to og to elementer og
            % bytter plass p� de dersom det forste er storst.
            if (punkt(kp(j), 1) + punkt(kp(j), 2) >...
                    punkt(kp(j+1), 1) + punkt(kp(j+1), 2));
                temp = kp(j+1);
                kp(j+1) = kp(j);
                kp(j) = temp;
                teller = teller +1;
                disp(kp);
            end
        end
        % Dersom ingen elementer byttet plass i forrige iterasjon
        % er listen ferdigsortert.
        if teller == 0;
            nykp = kp;
            return;
        end
    end
    
    nykp = kp;
    
end