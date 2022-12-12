function jd1 = JD1(wk,hmx,pk,wd,md,pd,s)
c1=0;
c2=0;
c3=0;
for i=1:size(hmx,2)
    for j=1:size(hmx,2)
        c1=c1+wk(i)*wk(j)*mvnpdf(hmx(:,i), hmx(:,j), diag(pk(:,i))+diag(pk(:,j)));
    end
end


%%
temp=0.07;
alpha=zeros(size(md,2),1);
[temp1,temp2]=sort(wd,'descend');
for n=1:size(md,2)
    temp3=0;
    for j=1:size(hmx,2)
        temp3=temp3+(wk(j)/wd(temp2(n)))*mvnpdf(md(:,temp2(n)), hmx(:,j), diag(pd(:,temp2(n)))+diag(pk(:,j)));
    end
    if n == 1
        alpha(temp2(n))=sig(temp-temp3);
    else
        temp4=1;
        for k = 1:n-1
            temp4=temp4*(1-alpha(temp2(k)));
        end
        alpha(temp2(n))=temp4*sig(temp-temp3);
    end
    
end
% for i=1:size(md,2)
%     if wk(s)/wd(i)*mvnpdf(md(:,i), hmx(:,s), diag(pd(:,i))+diag(pk(:,s)))>=0.01
%     alpha=zeros(size(md,2),1);
%     alpha(i)=1;
%     end
% end

%%

for i=1:size(hmx,2)
    for j=1:size(md,2)
        if wk(i)>0.8*wd(j)
            c2=c2+wk(i)*wd(j)*mvnpdf(hmx(:,i), md(:,j), diag(pk(:,i))+diag(pd(:,j)));
        else
            c2=c2+alpha(j)*wk(i)*wd(j)*mvnpdf(hmx(:,i), md(:,j), diag(pk(:,i))+diag(pd(:,j)));
        end
%             c2=c2+wk(i)*wd(j)*mvnpdf(hmx(:,i), md(:,j), diag(pk(:,i))+diag(pd(:,j)));

    end
end

for i=1:size(hmx,2)
    for j=1:size(md,2)
        c3=c3+alpha(j)*wk(i)*wd(j)*((hmx(:,i)-md(:,j))'/(diag(pk(:,i))+diag(pd(:,j)))*(hmx(:,i)-md(:,j))-log((2*pi)^(size(hmx,1)/2)*(det(diag(pk(:,i))+diag(pd(:,j))))^(1/2)));
    end
end

% jd1=200*c1-400*c2+0.04*c3;
jd1=200*c1-400*c2;


end