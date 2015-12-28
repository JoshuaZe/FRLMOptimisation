function newfamily=newselection(population,seln,child);
%new member selection
%此处seln只有一组家庭(array)
%此处child只为对应家庭的那个独子(array)
%列出父母
mother=population(seln(1),:);
father=population(seln(2),:);
%组建家庭并分别计算父母适应度
family=[mother;father];
familyvalue=fitnessfun(family);
%计算独生子适应度
childvalue=targetfun(child);
if childvalue>min(familyvalue)
    %population中最差的染色体数组，取最小编号
    worstninpop=min(find(familyvalue==min(familyvalue)));
    %将最差的替换掉
    family(worstninpop,:)=child;
end
newfamily=family;