function mnew=mutation(snew,pmutation);
%mutation
%�˴���ѡ����family:snew,Ϊ���׼�ͥ�������⣨����
global n
%Ⱦɫ�������
p=size(snew,2);
mnew=snew;
for i=1:2
    %���ݱ�����ʽ����жϣ�1 or 0��
    pmm=IfMut(pmutation);
    if pmm==1
        %��[1,P]��Χ���������һ�������
        chp=round(rand*(p-1))+1;
        r=ceil(rand*n);
        while repeatornot(mnew(i,:),p,r)
           r=ceil(rand*n);
        end
        mnew(i,chp)=r;
    end
end