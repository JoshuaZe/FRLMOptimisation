function pcc=IfMut(pmut);
%If mutation
test(1:100)=0;
l=round(100*pmut);
test(1:l)=1;
n=round(rand*99)+1;
pcc=test(n);