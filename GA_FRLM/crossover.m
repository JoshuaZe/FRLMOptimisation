function child=crossover(population,seln);
%Crossover operartion
%�˴�selnֻ��һ���ͥ(array)
%����seln��һ�Ը�ĸ�Ķ����ӣ�child��array��
p=size(population,2);
%get the fixed genes
fixedgenes=0;
fixednum=0;
for i=1:p
    for j=1:p
        if(population(seln(1),i)==population(seln(2),j))
            fixednum=fixednum+1;
            fixedgenes(fixednum)=population(seln(1),i);
            break;
        end
    end
end
%get the m draft
m=fixednum;
draft=fixedgenes;
for i=1:2
    for j=1:p
        if ~repeatornot(fixedgenes,fixednum,population(seln(i),j))
            m=m+1;
            draft(m)=population(seln(i),j);
        end
    end
end
%greedy deletion
%��draft��ɾȥ�������򣬵õ�del����Ϊ�µ�draft
while m>p
    drafty=targetfun(draft);
    for i=1:(m-fixednum)
        temp=draft;
        temp(i+fixednum)=[];
        if i==1
            del=temp;
            decreased=drafty-targetfun(temp);
        elseif (drafty-targetfun(temp))<decreased
            decreased=drafty-targetfun(temp);
            del=temp;
        end
    end
    draft=del;
    m=m-1;
end
child=draft;