%SA for P-Median
clc;
clear all;
close all;

tic %计时时间起始点

%初始参数录入
global p %可建设施数
global n %总选择点
global W %结点权重
global distances %任两点间距离
global path
global totalvolume
global Px
totalvolume=500;
Px=load('W.txt');
Px=100*Px;
distances=load('distances.txt');%距离(i to j)
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
p=5  %染色体长度(设施数)
n=50 %(需求数)

%程序参数录入
%生成初始解并初始化
sol_new=initial(n,p);
sol_current=sol_new;
sol_best(1,:)=sol_new;
E_new=targetfun(sol_new);
E_current=E_new;E_best(1,:)=E_new;
%初始化代数,初始化温度即衰减度(0.5~0.99)
t0=500;tf=3;t=t0;alpha=0.6;tnum=1;
%Markov链长度(任意温度的迭代次数)
Markov_length=p*(n-p);
%Markov_length=100*n;
%Markov_length=ceil(n*(p)^(1/2));
while t>=tf
    for l = 1:Markov_length
        %存储内能变化值
        E_history(l,tnum)=E_current;
        %随机扰动
        if rand<0.3 %单换
            r=ceil(rand*n);
            while repeatornot(sol_new(1:p),p,r)
                r=ceil(rand*n);
            end
            sol_new(ceil(rand*p))=r;
        else %双换
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
        %对新解计算内能并判断
        E_new=targetfun(sol_new);
        if E_new < E_current
            E_current=E_new;
            sol_current=sol_new;
            if E_new <= E_best(size(E_best,1),:)
                %保存冷却过程中最优解
                E_best(size(E_best,1)+1,:)=E_new;
                sol_best(size(sol_best,1)+1,:)=sol_new;
            end
        else
            %以一定概率接受新非优解
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

runningtime=toc %计时终止点