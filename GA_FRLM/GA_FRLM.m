%GA for FRLM
clc;
clear all;
close all;

tic %计时时间起始点

%%%初始参数录入
global p %可建设施数
global n %总节点数
global distances %n点中任两点间距离
global path
global totalvolume
global Px
totalvolume=500;
p=10  %染色体长度(设施数)(alternative)
n=25 %总节点数(alternative)
%for i=1:n
%    Px(i)=rand*800+200;
%end
% %fixed facility(alternative)
% fixedp=[8];
% fixedpnum=length(fixedp);
%O-D nodes(alternative)
%ODnodes=[1,7,11];
%距离(i to j)(alternative)
distances=load('distances.txt');
Px=load('W.txt');
Px=100*Px;
%%try Data 12-3%%%
%x=[2,2,29,22,2,67,98,33,25,95,36,31];
%y=[55,91,91,99,70,99,52,6,44,88,36,71];
%k=1;
%for i=1:12
%    for j=i+1:12
%        distances(k)=((x(i)-x(j))^2+(y(i)-y(j))^2)^(1/2);
%        k=k+1;
%    end
%end
%%try Data 12-3%%%

%%%程序GA算法参数录入
%最大进化代数MaxIter(alternative)
MaxIter=ceil(n*(p)^(1/2))
%变异概率(alternative 0.001-0.1)
pmutation=0.09
%初始化种群规模(alternative,vital)
d=ceil(n/p);
S=nchoosek(n,p);
popsize=max(d,ceil(log(S)/2))*2
%初始化种群(alternative,vital)
population=initial(n,p,popsize);

%%%Iteration
%计算适应度Fitvalue
Fitvalue=fitnessfun(population);
Generation=1;
while Generation<MaxIter+1
    %选择父母组合
    seln=selection(population);
    for i=1:(popsize/2)
        %交配（交叉）,greedy deletion
        child(i,:)=crossover(population,seln(i,:));
        %new member selection
        popnew((2*i-1):(2*i),:)=...
            newselection(population,seln(i,:),child(i,:));
        %变异mutation
        popnew((2*i-1):(2*i),:)=...
            mutation(popnew((2*i-1):(2*i),:),pmutation);
    end
    %产生新种群
    population=popnew;
    
    %计算新种群适应度
    Fitvalue=fitnessfun(population);
    
    %记录当代最好及最差的适应度及平均适应度
    [fworst,nworst]=min(Fitvalue);
    [fbest,nbest]=max(Fitvalue);
    fmean=mean(Fitvalue);
    yworst(Generation)=fworst;
    ybest(Generation)=fbest;
    ymean(Generation)=fmean;
    %记录当代最佳及最差染色体个体
    xworst(Generation,:)=population(nworst,:);
    xbest(Generation,:)=population(nbest,:);
    
    Generation=Generation+1;
end
%%%最优值
Generation=Generation-1;
Bestpopulation=population(nbest,:);
Besttargetfunvalue=targetfun(Bestpopulation)

runningtime=toc %计时终止点

%%%绘制适应度曲线
figure(1);
handbest=plot(1:Generation,ybest);
set(handbest,'linestyle','-','linewidth',1.8,'marker','*','markersize',6)
hold on;
handmean=plot(1:Generation,ymean);
set(handmean,'color','r','linestyle','-','linewidth',1.8,'marker','h',...
'markersize',6)
xlabel('进化代数');ylabel('最优/平均适应度');xlim([1 Generation]);
legend('最优适应度','平均适应度','Location','NorthEast');
box off;hold off;