function seln=selection(population);
%selecting the parents(randomly)
%selnΪpopsize/2���У����ͥ�����󣩣�ĸ�����У�
popsize=size(population,1);
fathern=1;
mothern=1;
father=0;
mother=0;
for i=1:popsize
    switch round(rand)
        case 1
            if fathern<=popsize/2
                father(fathern)=i;
                fathern=fathern+1;
            else
                mother(mothern)=i;
                mothern=mothern+1;
            end
        case 0
            if mothern<=popsize/2
                mother(mothern)=i;
                mothern=mothern+1;
            else
                father(fathern)=i;
                fathern=fathern+1;
            end
    end
end
%����Ⱥ��ѡ��popsize/2����������
for i=1:(popsize/2)
    r0=ceil(rand*popsize/2);%�����mothern
    r1=ceil(rand*popsize/2);%�����fathern
    seln(i,:)=[mother(r0),father(r1)];
end