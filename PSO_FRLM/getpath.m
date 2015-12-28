function [pnode,m]=getpath(pstart,pend,pnode,m)
global paths
if paths(pstart,pend)>0&&pstart~=paths(pstart,pend)
    [pnode,m]=getpath(pstart,paths(pstart,pend),pnode,m);
    [pnode,m]=getpath(paths(pstart,pend),pend,pnode,m);
else 
    pnode(1,m)=pend;
    m=m+1;
end