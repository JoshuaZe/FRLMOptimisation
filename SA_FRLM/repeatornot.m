%judge whether repeat 
%array��1��endnum�Ƿ��е���check���ظ���ֵ
function repeatornot=repeatornot(array,endnum,check);
repeatornot=0;
for i=1:endnum
    if array(i)==check
        repeatornot=1;
        break;
    end
end