function population=initial(n,p,popsize);
%initializing the population
d=ceil(popsize/2);%ÿ��group��d��Ⱦɫ��
%2��group��ʼ��,ȷ������ż����Ⱦɫ��,�Ա��Ϊfather&mother
for set=1:2
    temp(1)=1;
    stn=ceil(rand*d);%��ʼ��ֵ
    %��ʱ����tempѭ����ʼ��
    for i=1:(n-1)
        if temp(i)+ceil(set*rand*5)<=n
            temp(i+1)=temp(i)+ceil(set*rand*5);
        else
            temp(i+1)=stn+1;
        end
    end
    %������հ�
    for i=n:d*p
       r=ceil(rand*n);
       %while ~(isempty(find((temp-r)==0))),bad speed
       row=d;
       while repeatornot(temp((1+(row-1)*p):i),i-(row-1)*p,r)
           r=ceil(rand*n);
       end
       temp(i+1)=r; 
    end 
    %������ֵ��ֵ����Ⱥ����
    for row=1:d
        population(row+(set-1)*d,:)=temp((1+(row-1)*p):(p+(row-1)*p));
    end
end