function route=calculate(i,j,route);
global path
if(path(i,j)>0)%�������ڵ�֮�仹�нڵ����ʱ
        route=calculate(i,path(i,j),route);
        route=calculate(path(i,j),j,route);
else
    route(size(route,2)+1)=j;%�������route����
end