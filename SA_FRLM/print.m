function route=print(i,j,path);
%�����������·��
%global path
global n
route=0;
if((i>=1&&i<=n)&&(j>=1&&j<=n)&&(i~=j))
    route=i;
    %���Ƚ���һ��������route����
    route=calculate(i,j,route);
    %���뺯������������Ľڵ�
end