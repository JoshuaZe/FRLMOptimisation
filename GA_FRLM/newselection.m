function newfamily=newselection(population,seln,child);
%new member selection
%�˴�selnֻ��һ���ͥ(array)
%�˴�childֻΪ��Ӧ��ͥ���Ǹ�����(array)
%�г���ĸ
mother=population(seln(1),:);
father=population(seln(2),:);
%�齨��ͥ���ֱ���㸸ĸ��Ӧ��
family=[mother;father];
familyvalue=fitnessfun(family);
%�����������Ӧ��
childvalue=targetfun(child);
if childvalue>min(familyvalue)
    %population������Ⱦɫ�����飬ȡ��С���
    worstninpop=min(find(familyvalue==min(familyvalue)));
    %�������滻��
    family(worstninpop,:)=child;
end
newfamily=family;