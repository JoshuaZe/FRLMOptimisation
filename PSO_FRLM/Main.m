%主程序，使用PSO算法计算加电站的最优分布(25个候选点选择8个)
clc;
clear all;
close all;            
global sites     %候选点总数
global nums      %预建站点总数
global ranges    
global weights   
global dists     %各点之间的距离
global flows     %O-D对间的流量
global paths     %最短路径矩阵
global maxtr     %每个粒子的最大迭代次数
global population     
global c1        %每个粒子的个体学习因子
global c2        %每个粒子的社会学习因子
global w         %每个粒子的惯性因子
global vmax      %每个粒子的最大速度

maxtr=100;
sites=15;
nums=5;


population=30;
c1=2;
c2=22;
w=0.7;
vmax=0.7;

ranges=12
weights=2+fix(134*rand(1,sites));            
maxlength=10;              
dists=zeros(sites,sites);
flows=zeros(sites,sites);
paths=zeros(sites,sites);
fitvalue=zeros(1,population);

for i=1:sites                  
    for j=1:sites
        if j==i
            dists(i,j)=0;
        else
            dists(i,j)=inf;                
        end
    end                          
end

for i=2:sites                  
    for j=1:i-1
        r=decide(0.15);
        if r==1
            dists(i,j)=round(maxlength*rand(1))+1;
            dists(j,i)=dists(i,j);
        end
    end
end

for i=1:sites
    for j=1:sites
        if dists(i,j)>0&&dists(i,j)<inf
            paths(i,j)=i;
        end
    end
end

for k=1:sites                 %Floyed算法计算任意两点之间的最短距离和路径
    for i=1:sites
        if k~=i
            for j=1:sites
                if j~=i&&j~=k
                    if dists(i,k)+dists(k,j)<dists(i,j)
                        dists(i,j)=dists(i,k)+dists(k,j);
                        paths(i,j)=k;
                    end
                end
            end
        end
    end
end

for i=1:sites                             %使用重力模型生成每个OD对间的流量
    for j=1:sites
        if dists(i,j)~=0
            flows(i,j)=0.18*(weights(i)*weights(j))^1.15/(dists(i,j))^1.54;
        end       
    end
end


group=1+round(sites*rand(population,nums));


v=round(2*rand(population,nums));


for i=1:population
    fitvalue(1,i)=objfun(group(i,:));
end

%获取最优粒子及其适应度
popubest=group;
popubestfit=fitvalue;
globalbestfit=zeros(1,maxtr);
[globalbestfit(1,1),i]=max(popubestfit);
globalbest=zeros(maxtr,nums);
globalbest(1,:)=popubest(i,:);

i=1;
while i<=maxtr
    for j=1:population
        fitvalue(1,j)=objfun(group(j,:));
        if fitvalue(1,j)>popubestfit(1,j)           %判断当前位置是否是最佳位置
            popubestfit(1,j)=fitvalue(1,j);
            popubest(j,:)=group(j,:);
        end
    end
    [globalbestfit(1,i),j]=max(popubestfit);
    globalbest(i,:)=popubest(j,:);
    for j=1:population                 
        v(j,:)=w*v(j,:)+c1*round(rand*(popubest(j,:)-group(j,:)))+c2*round(rand*(globalbest(i,:)-group(j,:)));
        for k=1:nums
            if v(j,k)>vmax
                v(j,k)=vmax;
            elseif v(j,k)<-vmax
                v(j,k)=-vmax;
            end
        end
        group(j,:)=group(j,:)+round(v(j,:));
    end
    vmax=vmax*(1-((i-1)/i)^2);
    i=i+1;
end

bestgrain=num2str(globalbest(maxtr,:));
bestfit=num2str(globalbestfit(1,maxtr));

disp(['最大流量为:',bestfit]);
disp(['最佳建站组合为:',bestgrain]);








