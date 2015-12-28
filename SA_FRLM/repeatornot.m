%judge whether repeat 
%array从1到endnum是否有等于check的重复数值
function repeatornot=repeatornot(array,endnum,check);
repeatornot=0;
for i=1:endnum
    if array(i)==check
        repeatornot=1;
        break;
    end
end