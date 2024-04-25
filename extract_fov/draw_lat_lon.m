clc;
clear all;

folder_path = 'D:\Unity projects\VRQoE\Test_session\step1_Processed_HMD111\Session\Animal2_4K.mp4\';
% 获取文件夹中所有CSV文件的信息
files = dir([folder_path, '*.csv']);
% 时间步长
time_step = 1 / 60;
% 创建经度和纬度的图
figure;

% 绘制经度随时间变化的图
subplot(2, 1, 1);
hold on;

for i = 1:length(files)
    % 读取CSV文件
    [~,~,data] = xlsread([folder_path,'\',files(i).name]);
    data = cell2mat(data(:,:));
    % 计算时间向量
    time = (1:size(data, 1)) * time_step;
    
    % 提取经度数据
    longitude = data(:, 5);
    
    % 绘制经度随时间变化的曲线
    plot(time, longitude, 'DisplayName', sprintf('Person %d', i));
end

xlabel('时间（秒钟）');
ylabel('经度');
title('经度随时间变化');
legend('Location', 'Best');

% 绘制纬度随时间变化的图
subplot(2, 1, 2);
hold on;

for i = 1:length(files)
    
    [~,~,data] = xlsread([folder_path,'\',files(i).name]);
    data = cell2mat(data(:,:));
   
    % 计算时间向量
    time = (1:size(data, 1)) * time_step;
    
    % 提取纬度数据
    latitude = data(:, 4);
    
    % 绘制纬度随时间变化的曲线
    plot(time, latitude, 'DisplayName', sprintf('Person %d', i));
end

xlabel('时间（秒钟）');
ylabel('纬度');
title('纬度随时间变化');
legend('Location', 'Best');
