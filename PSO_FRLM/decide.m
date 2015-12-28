function decn=decide(whenum)
test(1:100)=0;
t=round(100*whenum);
test(1:t)=1;
n=round(rand*99)+1;
decn=test(n);