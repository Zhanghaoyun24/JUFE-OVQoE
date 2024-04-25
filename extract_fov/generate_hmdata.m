% 生成示例的头动数据，包含600帧
num_frames = 600;

% 初始化头动数据矩阵，每行包含纬度和经度
head_motion_data = zeros(num_frames, 2);

% 模拟平滑的头动数据的生成
for frame = 1:num_frames
    % 生成正弦和余弦函数值作为纬度和经度
    latitude = 30 * sin(2 * pi * frame / num_frames);  % 正弦函数
    longitude = 60 * cos(2 * pi * frame / num_frames);  % 余弦函数
    
    % 将生成的纬度和经度保存到头动数据矩阵中
    head_motion_data(frame, 1) = latitude;
    head_motion_data(frame, 2) = longitude;
end

% 显示头动数据的前几行
disp(head_motion_data(1:10, :));

% 可以将生成的头动数据保存到 Excel 文件中
xlswrite('smooth_head_motion_data.xlsx', head_motion_data, 'Sheet1');
