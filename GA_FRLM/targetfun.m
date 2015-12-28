function y=targetfun(chromosome);
%target function
%x is one of the members with many genes(x��Ⱦɫ��)
global p %�ɽ���ʩ��
global n %��ѡ���
global distances %��������
global path
%¼��distances�����Dij
k=1;
for i=1:n
    for j=i:n
        if i==j
            Dij(i,j)=0;
        else
            Dij(i,j)=distances(k);
            Dij(j,i)=distances(k);
            k=k+1;
        end
    end
end
%core
y=0;
route=0;
maps=floyedsp(Dij);
for i=1:n
    for j=(i+1):n
            route=print(i,j,path);
            [x,volume]=judge(route,chromosome,maps,-1);
            if x==1
                route2=fliplr(route);
                [x,volume]=judge(route2,chromosome,maps,volume);
            end
            fq=flow(maps(i,j),route,x);
            y=y+fq;
    end
end