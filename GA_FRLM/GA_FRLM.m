%GA for FRLM
clc;
clear all;
close all;

tic %��ʱʱ����ʼ��

%%%��ʼ����¼��
global p %�ɽ���ʩ��
global n %�ܽڵ���
global distances %n��������������
global path
global totalvolume
global Px
totalvolume=500;
p=10  %Ⱦɫ�峤��(��ʩ��)(alternative)
n=25 %�ܽڵ���(alternative)
%for i=1:n
%    Px(i)=rand*800+200;
%end
% %fixed facility(alternative)
% fixedp=[8];
% fixedpnum=length(fixedp);
%O-D nodes(alternative)
%ODnodes=[1,7,11];
%����(i to j)(alternative)
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

%%%����GA�㷨����¼��
%����������MaxIter(alternative)
MaxIter=ceil(n*(p)^(1/2))
%�������(alternative 0.001-0.1)
pmutation=0.09
%��ʼ����Ⱥ��ģ(alternative,vital)
d=ceil(n/p);
S=nchoosek(n,p);
popsize=max(d,ceil(log(S)/2))*2
%��ʼ����Ⱥ(alternative,vital)
population=initial(n,p,popsize);

%%%Iteration
%������Ӧ��Fitvalue
Fitvalue=fitnessfun(population);
Generation=1;
while Generation<MaxIter+1
    %ѡ��ĸ���
    seln=selection(population);
    for i=1:(popsize/2)
        %���䣨���棩,greedy deletion
        child(i,:)=crossover(population,seln(i,:));
        %new member selection
        popnew((2*i-1):(2*i),:)=...
            newselection(population,seln(i,:),child(i,:));
        %����mutation
        popnew((2*i-1):(2*i),:)=...
            mutation(popnew((2*i-1):(2*i),:),pmutation);
    end
    %��������Ⱥ
    population=popnew;
    
    %��������Ⱥ��Ӧ��
    Fitvalue=fitnessfun(population);
    
    %��¼������ü�������Ӧ�ȼ�ƽ����Ӧ��
    [fworst,nworst]=min(Fitvalue);
    [fbest,nbest]=max(Fitvalue);
    fmean=mean(Fitvalue);
    yworst(Generation)=fworst;
    ybest(Generation)=fbest;
    ymean(Generation)=fmean;
    %��¼������Ѽ����Ⱦɫ�����
    xworst(Generation,:)=population(nworst,:);
    xbest(Generation,:)=population(nbest,:);
    
    Generation=Generation+1;
end
%%%����ֵ
Generation=Generation-1;
Bestpopulation=population(nbest,:);
Besttargetfunvalue=targetfun(Bestpopulation)

runningtime=toc %��ʱ��ֹ��

%%%������Ӧ������
figure(1);
handbest=plot(1:Generation,ybest);
set(handbest,'linestyle','-','linewidth',1.8,'marker','*','markersize',6)
hold on;
handmean=plot(1:Generation,ymean);
set(handmean,'color','r','linestyle','-','linewidth',1.8,'marker','h',...
'markersize',6)
xlabel('��������');ylabel('����/ƽ����Ӧ��');xlim([1 Generation]);
legend('������Ӧ��','ƽ����Ӧ��','Location','NorthEast');
box off;hold off;