function fim = moment(npunkt,punkt,nelem,elem,nlast,last,elementlengder)

% moment regner ut fastinnspenningsmomentene
% npunkt: Antall punkter
% punkt: Matrise med knutepunktsinformasjon
% nelem; Antall elementer
% elem: Matrise med elementinformasjon
% nlast: Antall laster
% last: Matrise med lastinformasjon
% elementlengder: Lengden til elementene
%
% fim: Vektor med fastinnspenningsmomentene

    fim = zeros(2*nelem, 1);
    
    for i = 1 : nlast;
        
        ende1 = last(i, 2);
        ende2 = last(i, 3);
        el = elementlengder(elementnr(ende1, ende2, elem, nelem));
        lasttype = last(i, 1);
        lastint1 = last(i, 4);
        lastavstand = last(i, 6);
        
        % Regner ut fastinnspenningsmomentet til en punktlast
        if lasttype == 0;
            lastvinkel = last(i, 5);
            temp1 = (- lastint1*cosd(lastvinkel) * lastavstand * (el-lastavstand)^2)/(el^2);
            temp2 = (lastint1 *cosd(lastvinkel)* lastavstand * (el-lastavstand)^2)/(el^2);
        
        % Regner ut fastinnspenningsmomentet til en fordelt last
        elseif lasttype == 1;
            lastint2 = last(i, 5);
            temp1 = ((-1/20) * lastint1 * (el)^2) + ((-1/30) * lastint2 * (el)^2);
            temp2 = ((1/30) * lastint1 * (el)^2) + ((1/20) * lastint2 * (el)^2);
        else
            disp('Error: Ugyldig lasttype (0: Punktlast, 1: Fordelt last')
            return;
        end
        
        % Finner tilhørende elementnummer til knutepunktene og setter inn
        % fastinnspenningsmomentet ved lokal ende 1 og 2
        fim(2*elementnr(ende1, ende2, elem, nelem)-1) = fim(2*elementnr(ende1, ende2, elem, nelem)-1) + temp1;
        fim(2*elementnr(ende1, ende2, elem, nelem)) = fim(2*elementnr(ende1, ende2, elem, nelem)) + temp2;
    end
end

