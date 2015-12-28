function [judgeresult,volume]=judge(route,chromosome,maps,volume);
%判断OD队是否能够走通
global totalvolume
judgeresult=0;
repeatornot1=repeatornot(chromosome,size(chromosome,2),route(1));
if volume==-1
    if(repeatornot1==0)
        volume=totalvolume/2;
    else
        volume=totalvolume;
    end
else
    if(repeatornot1~=0)
        volume=totalvolume;
    end
end
if(volume<maps(route(1),route(2)))
   judgeresult=0;
else
    volume=volume-maps(route(1),route(2));
    judgeresult=1;
    for i=2:size(route,2)-1
        judgeresult=0;
        repeatornot2=repeatornot(chromosome,size(chromosome,2),route(i));
        if(repeatornot2==0)
            if(volume<maps(route(i),route(i+1)))
                break;
            else
                volume=volume-maps(route(i),route(i+1));
            end
        else
            volume=totalvolume;
            if(volume<maps(route(i),route(i+1)))
                break;
            else
                volume=volume-maps(route(i),route(i+1));
            end
        end
        judgeresult=1;
    end
end