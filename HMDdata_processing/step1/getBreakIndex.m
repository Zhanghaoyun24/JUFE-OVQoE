function breakIndex= getBreakIndex(data, start_index, j)
%break and rating
number = length(data);
if j==12
    breakIndex = number;
end
for i = start_index:number
    k1=strfind(data{i,1},'break and rating');
    [r1,c1]=size(k1);
    if (r1>=1)
        breakIndex = i;
        break;
    end
end

end

