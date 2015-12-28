%SA for P-Median
clc;
clear all;
close all;

tic %��ʱʱ����ʼ��

%��ʼ����¼��
global p %�ɽ���ʩ��
global n %��ѡ���
global W %���Ȩ��
global distances %����������
global path
global totalvolume
global Px
totalvolume=500;
Px=load('W.txt');
Px=100*Px;
distances=load('distances.txt');%����(i to j)
%%%try Data 12-3%%%
% x=[2,2,29,22,2,67,98,33,25,95,36,31];
% y=[55,91,91,99,70,99,52,6,44,88,36,71];
% k=1;
% for i=1:12
%     for j=i+1:12
%         distances(k)=((x(i)-x(j))^2+(y(i)-y(j))^2)^(1/2);
%         k=k+1;
%     end
% end
%%%try Data 12-3%%%
p=5  %Ⱦɫ�峤��(��ʩ��)
n=50 %(������)

%�������¼��
%���ɳ�ʼ�Ⲣ��ʼ��
sol_new=initial(n,p);
sol_current=sol_new;
sol_best(1,:)=sol_new;
E_new=targetfun(sol_new);
E_current=E_new;E_best(1,:)=E_new;
%��ʼ������,��ʼ���¶ȼ�˥����(0.5~0.99)
t0=500;tf=3;t=t0;alpha=0.6;tnum=1;
%Markov������(�����¶ȵĵ�������)
Markov_length=p*(n-p);
%Markov_length=100*n;
%Markov_length=ceil(n*(p)^(1/2));
while t>=tf
    for l = 1:Markov_length
        %�洢���ܱ仯ֵ
        E_history(l,tnum)=E_current;
        %����Ŷ�
        if rand<0.3 %����
            r=ceil(rand*n);
            while repeatornot(sol_new(1:p),p,r)
                r=ceil(rand*n);
            end
            sol_new(ceil(rand*p))=r;
        else %˫��
            r1=ceil(rand*n);r2=ceil(rand*n);
            d1=ceil(rand*p);d2=ceil(rand*p);
            while repeatornot(sol_new(1:p),p,r1)&&...
                    repeatornot(sol_new(1:p),p,r2)&&...
                    (r1==r2)
                r1=ceil(rand*n);r2=ceil(rand*n);
            end
            while d1==d2
                d1=ceil(rand*p);d2=ceil(rand*p);
            end
            sol_new(d1)=r1;
            sol_new(d2)=r2;
        end
        %���½�������ܲ��ж�
        E_new=targetfun(sol_new);
        if E_new < E_current
            E_current=E_new;
            sol_current=sol_new;
            if E_new <= E_best(size(E_best,1),:)
                %������ȴ���������Ž�
                E_best(size(E_best,1)+1,:)=E_new;
                sol_best(size(sol_best,1)+1,:)=sol_new;
            end
        else
            %��һ�����ʽ����·��Ž�
            if rand < exp(-(E_new-E_current))/t
                E_current=E_new;
                sol_current=sol_new;
            else
                sol_new=sol_current;
            end
        end
    end
    t=t*alpha;
    tnum=tnum+1;
end

Besttargetfunvalue=-min(E_best)

runningtime=toc %��ʱ��ֹ��