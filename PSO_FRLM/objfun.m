function y=objfun(x)
global sites   %��ѡ������
global ranges  %�綯���ܺ�����
global dists  %����֮��ľ���
global flows %O-D�Լ������
global paths
y=zeros(1);          %���ڱ���Ŀ��ֵ
chnode=zeros(1,sites);
pnode=zeros(1,sites);

for i=1:sites        %iΪ·�����
    k=1;
    for j=1:sites
        chnode(1,j)=0;
    end
    for j=1:sites
        if paths(i,j)>0
            chnode(1,k)=j;
            k=k+1;
        end
    end
    j=1;
    if numel(find(x==i))==0
        range=ranges/2;
    else
        range=ranges;
    end
    pstart=i;
    while j<k
        r=range;
        for o=1:sites
            pnode(1,o)=0;
        end
        m=1;
        pend=chnode(1,j);
        [pnode,m]=getpath(pstart,pend,pnode,m);
        pstart=i;
        a=1;
        while r>=0&&pnode(1,a)~=0
            if all([numel(find(x==pnode(1,a)))==0,dists(pstart,pnode(1,a))<=r/2])
                r=r-dists(pstart,pnode(1,a));
                pstart=pnode(1,a);
                a=a+1;
            elseif all([numel(find(x==pnode(1,a)))~=0,dists(pstart,pnode(1,a))<=r])
                pstart=pnode(1,a);
                r=ranges;
                a=a+1;
            else
                r=-1;
            end
        end
        if pnode(1,a)==0
            a=a-1;
            pstart=pnode(1,a);
            a=a-1;
            while r>=0&&a~=0
                if all([numel(find(x==pnode(1,a)))==0,dists(pstart,pnode(1,a))<=r/2])
                    r=r-dists(pstart,pnode(1,a));
                    pstart=pnode(1,a);
                    a=a-1;
                elseif all([numel(find(x==pnode(1,a)))~=0,dists(pstart,pnode(1,a))<=r])
                    pstart=pnode(1,a);
                    a=a-1;
                    r=ranges;
                else
                    r=-1;
                end
            end
        end
        if a==0
            y=y+flows(i,j);
        end
        j=j+1;
    end        
end
y=y/2;    
        
    

