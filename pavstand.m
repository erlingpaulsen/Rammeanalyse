function avs = pavstand(x1, y1, x2, y2)

% (x1, y1): Koordinat til punktet p1
% (x2, y2): Koordinat til punktet p2
%
% Returnerer avstanden mellom p1 og p2

    avs = sqrt(((x2-x1)^2)+((y2-y1)^2));

end