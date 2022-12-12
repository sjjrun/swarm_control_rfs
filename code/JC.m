function jc = JC(mk,pk,mc,d)
c1=0;
for i=1:size(mc,2)
    if norm(mk-mc(:,i))<=(d(i)+3*max(pk))
        c1=c1+(-20);
    else
        c1=c1+min(log(norm(mk-mc(:,i))-(d(i)+3*max(pk))),3);
%         c1=c1+log(norm(mk-mc(:,i))-(d(i)+3*max(pk)));
    end
end
jc=-20*c1;
end

