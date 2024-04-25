function startIndex= getVideoStartIndex(data,video_name)
%video_name
number = length(data);
for i = 1:number
    k1=strfind(data{i,1},video_name);
    [r1,c1]=size(k1);
    if (r1>=1)
        startIndex = i;
        break;
    end
end

end

