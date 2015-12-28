function child=crossover(population,seln);
%Crossover operartion
%此处seln只有一组家庭(array)
%返回seln中一对父母的独生子，child（array）
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
%从draft中删去不良基因，得到del，作为新的draft
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