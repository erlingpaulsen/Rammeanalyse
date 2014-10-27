function skjarkraft = skjarkraft(last, nlast, endeM, nelem, elem, elementlengder)
skjarkraft = zeros(nelem, 2);
q0 = q(nelem, elem, nlast, last, elementlengder);
for i = 1:nelem;
    skjarkraft(i, 1) = -(endeM(i,1)+endeM(i,2))/elementlengder(i) + q0(i, 1);
    skjarkraft(i, 2) = -(endeM(i,1)+endeM(i,2))/elementlengder(i) + q0(i, 2);
end
end