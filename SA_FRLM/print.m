function route=print(i,j,path);
%输出两点的最短路径
%global path
global n
route=0;
if((i>=1&&i<=n)&&(j>=1&&j<=n)&&(i~=j))
    route=i;
    %首先将第一个点输入route矩阵
    route=calculate(i,j,route);
    %带入函数计算接下来的节点
end