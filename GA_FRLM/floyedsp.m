function maps=floyedsp(Dij);
%�ø��������㷨�㷨�������·�����洢
%�ܽ����
global n
global path
path=zeros(n);
maps=Dij;
for k=1:n
    for i=1:n
        if k~=i
            for j=1:n
                if((j~=i)&&(j~=k)&&(maps(i,k)>0)&&(maps(k,j)>0)&&...
                   ((maps(i,j)==0)||((maps(i,k)+maps(k,j)<maps(i,j)))))
                   maps(i,j)=maps(i,k)+maps(k,j);
                   %��ʱmaps(i,j)��ʾi��j�����·
                   path(i,j)=k;
                   %��ʱpath��i,j)��ʾi,j�������·��֮�侭���ĵ�
                end
            end
        end
    end
end