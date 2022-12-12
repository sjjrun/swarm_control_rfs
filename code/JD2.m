function jd1 = JD2(wk,hmx,pk,wd,md,pd,s)
c1=0;
c2=0;
c3=0;
for i=1:size(hmx,2)
    for j=1:size(hmx,2)
        c1=c1+wk(i)*wk(j)*mvnpdf(hmx(:,i), hmx(:,j), diag(pk(:,i))+diag(pk(:,j)));
    end
end

temp=zeros(size(hmx,2),size(md,2));
for i=1:size(hmx,2)
    for j=1:size(md,2)
        for k=1:size(hmx,2)
            if k~=i
                temp(i,j)=temp(i,j)+(wk(k)/wd(j))*mvnpdf(md(:,j), hmx(:,k), diag(pk(:,k))+diag(pd(:,j)));
            end
        end
    end
end

[temp2,sigma]=min(temp');

for i=1:size(hmx,2)
    for j=1:size(md,2)
%         if wk(i)>0.8*wd(j) || length(wk) ~= 6
%             c2=c2+wk(i)*wd(j)*mvnpdf(hmx(:,i), md(:,j), diag(pk(:,i))+diag(pd(:,j)));
%         else
%             c2=c2+wk(i)*wd(sigma(i))*mvnpdf(hmx(:,i), md(:,sigma(i)), diag(pk(:,i))+diag(pd(:,sigma(i))));
%         end
        c2=c2+wk(i)*wd(j)*mvnpdf(hmx(:,i), md(:,j), diag(pk(:,i))+diag(pd(:,j)));
    end
end

for i=1:size(hmx,2)
    c3=c3+wk(i)*wd(sigma(i))*((hmx(:,i)-md(:,sigma(i)))'/(diag(pk(:,i))+diag(pd(:,j)))*(hmx(:,i)-md(:,sigma(i)))-log((2*pi)^(size(hmx,1)/2)*(det(diag(pk(:,i))+diag(pd(:,j))))^(1/2)));
end

jd1=200*c1-400*c2+0.04*c3;
% jd1=200*c1-400*c2;

end
