function mnew=mutation(snew,pmutation);
%mutation
%此处新选出的family:snew,为单亲家庭，两个解（矩阵）
global n
%染色体基因数
p=size(snew,2);
mnew=snew;
for i=1:2
    %依据变异概率进行判断（1 or 0）
    pmm=IfMut(pmutation);
    if pmm==1
        %在[1,P]范围内随机产生一个变异点
        chp=round(rand*(p-1))+1;
        r=ceil(rand*n);
        while repeatornot(mnew(i,:),p,r)
           r=ceil(rand*n);
        end
        mnew(i,chp)=r;
    end
end