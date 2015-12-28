function route=calculate(i,j,route);
global path
if(path(i,j)>0)%当两个节点之间还有节点存在时
        route=calculate(i,path(i,j),route);
        route=calculate(path(i,j),j,route);
else
    route(size(route,2)+1)=j;%将其插入route矩阵
end