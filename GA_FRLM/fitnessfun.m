function Fitvalue=fitnessfun(population);
%Fitness Function
%��popsize������
popsize=size(population,1);
for i=1:popsize
    chromosome=population(i,:);
    %������Ӧ�Ⱥ���ֵ
    Fitvalue(i)=targetfun(chromosome);
end
Fitvalue=Fitvalue';