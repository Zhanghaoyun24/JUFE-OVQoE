function reData = Sampling(data,frameNumber)
%获取data的长度
number = length(data);
%进行比较
%如果实际搜集的数目与预计的相同
if(number==frameNumber)
    reData = data;
 %如果实际搜索的数目比预计的多，则抽取
elseif(number>frameNumber)
  %创建一个mat数组
  mat = cell(frameNumber,9);
  mat(1:end,:) = data(1:frameNumber,:);
  reData = mat;
else
    %如果实际的数目要比预测的数目少，需要插空补充
    less = frameNumber - number;
    lessIndex = floor(number/less);
    %创建一个空的元胞数组
    mat = cell(frameNumber,9);
    %从头开始赋值
    for i = 1:less
        if (i==1)
           mat(1:lessIndex,:) = data(1:lessIndex,:);
           %开始补充一行
           mat(lessIndex+1,:) = data(lessIndex,:);
        elseif(i<less)
           index = (i-1)*lessIndex;
           next = i*lessIndex; 
           mat(index+i:next+i-1,:) = data(index+1:next,:);
           mat(next+i,:) = data(next,:);
        else
           index1 = (i-1)*lessIndex;
           next1 = i*lessIndex; 
           mat(index1+i:next1+i-1,:) = data(index1+1:next1,:);
           mat(next1+i,:) = data(next1,:);
           %补充后面的,
           if((mod(number,less))>0)
               mat(next1+i+1:frameNumber,:) = data(next1+1:number,:);
           end
        end 
    end   
    reData = mat;
end

end

