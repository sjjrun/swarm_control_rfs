function [A,wk,mx,dmx,pk,ul,p1]=cut(A,wk,mx,dmx,wd,md,pk,pd,ul,p1,H)
    for i = 1:length(wk)
        for j = 1:length(wk)
            if i~=j && wk(i)~=0 && wk(j)~=0 && wk(i)+wk(j) < 1.1 * max(wd) && norm(mx((i-1)*2*H+1:(i-1)*2*H+2,i)-mx((j-1)*2*H+1:(j-1)*2*H+2,j)) < 1
                for k=1:length(wd)
                    temp1=0.12;
                    temp2=0;
                    for s = 1:length(wk)
                        temp2=temp2+(wk(s)/wd(k))*mvnpdf(md(:,k), mx(1:2,s), diag(pd(:,k))+diag(pk(:,i)));
                    end
                    if norm(mx((i-1)*2*H+1:(i-1)*2*H+2,i)-md(1:2,k)) < 0.5 && temp2 < temp1
                        wk(i)=wk(i)+wk(j);
                        wk(j)=0;
                        dmx((i-1)*2*H+1:i*2*H,i)=zeros(2*H,1);
                        dmx((j-1)*2*H+1:j*2*H,j)=zeros(2*H,1);
                        ul(:,i)=zeros(2*H,1);
                        ul(:,j)=zeros(2*H,1);
                        A(i,:)=A(i,:)+A(j,:);
                        A(i,:)=min(A(i,:),ones(1,size(A,2)));
                        A(:,i)=A(:,i)+A(:,j);
                        A(:,i)=min(A(:,i),ones(size(A,1),1));
                        A(j,:)=zeros(1,size(A,2));
                        A(:,j)=zeros(size(A,1),1);
                        A(i,i)=0;
                        A(i,j)=0;
                        p1=1./(sum(A'));
                        continue;
                    end
                end
            end
        end
    end
end