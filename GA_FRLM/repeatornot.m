function repeatornot=repeatornot(array,endnum,check);
%judge whether repeat 
%for initial() , crossover() , mutation()
%array��1��endnum�Ƿ��е���check���ظ���ֵ
repeatornot=0;
for i=1:endnum
    if array(i)==check
        repeatornot=1;
        break;
    end
end