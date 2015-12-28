%������ʹ��PSO�㷨����ӵ�վ�����ŷֲ�(25����ѡ��ѡ��8��)
clc;
clear all;
close all;            
global sites     %��ѡ������
global nums      %Ԥ��վ������
global ranges    
global weights   
global dists     %����֮��ľ���
global flows     %O-D�Լ������
global paths     %���·������
global maxtr     %ÿ�����ӵ�����������
global population     
global c1        %ÿ�����ӵĸ���ѧϰ����
global c2        %ÿ�����ӵ����ѧϰ����
global w         %ÿ�����ӵĹ�������
global vmax      %ÿ�����ӵ�����ٶ�

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

for k=1:sites                 %Floyed�㷨������������֮�����̾����·��
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

for i=1:sites                             %ʹ������ģ������ÿ��OD�Լ������
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

%��ȡ�������Ӽ�����Ӧ��
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
        if fitvalue(1,j)>popubestfit(1,j)           %�жϵ�ǰλ���Ƿ������λ��
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

disp(['�������Ϊ:',bestfit]);
disp(['��ѽ�վ���Ϊ:',bestgrain]);








