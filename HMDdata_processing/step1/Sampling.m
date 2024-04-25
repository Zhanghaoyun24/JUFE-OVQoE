function reData = Sampling(data,frameNumber)

number = length(data);
if(number==frameNumber)
    reData = data;
elseif(number>frameNumber)
  mat = cell(frameNumber,9);
  mat(1:end,:) = data(1:frameNumber,:);
  reData = mat;
else
    less = frameNumber - number;
    lessIndex = floor(number/less);
    mat = cell(frameNumber,9);
    for i = 1:less
        if (i==1)
           mat(1:lessIndex,:) = data(1:lessIndex,:);
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
           if((mod(number,less))>0)
               mat(next1+i+1:frameNumber,:) = data(next1+1:number,:);
           end
        end 
    end   
    reData = mat;
end

end

