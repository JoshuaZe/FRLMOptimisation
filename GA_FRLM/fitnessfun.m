function Fitvalue=fitnessfun(population);
%Fitness Function
%有popsize个个体
popsize=size(population,1);
for i=1:popsize
    chromosome=population(i,:);
    %计算适应度函数值
    Fitvalue(i)=targetfun(chromosome);
end
Fitvalue=Fitvalue';