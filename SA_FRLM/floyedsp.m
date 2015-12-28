function maps=floyedsp(Dij);
%用弗洛伊德算法算法计算最短路径并存储
%总结点数
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
                   %此时maps(i,j)表示i到j的最短路
                   path(i,j)=k;
                   %此时path（i,j)表示i,j两点最短路径之间经过的点
                end
            end
        end
    end
end