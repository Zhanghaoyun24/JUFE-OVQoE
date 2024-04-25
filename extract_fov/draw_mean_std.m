clc;
clear all;
folder_path = 'D:\Unity projects\VRQoE\Test_session\step1_Processed_HMD111\Session\Animal2_4K.mp4\';
files = dir([folder_path, '*.csv']);

% 初始化存储经度和纬度均值和方差的数组
meanLongitude = [];
varLongitude = [];
meanLatitude = [];
varLatitude = [];

for n = 1:2:3600
    tempLon = [];
    tempLat = [];
    for i = 1:length(files)
        [~,~,data] = xlsread([folder_path,'\',files(i).name]);
        data = cell2mat(data(:,:));
        tempLon = [tempLon,data(n,2)];
        tempLat = [tempLat,data(n,1)];
    end
    
    meanLongitude = [meanLongitude,mean(tempLon)];
    varLongitude = [meanLongitude,var(tempLon)];
    meanLatitude = [meanLatitude,mean(tempLat)];
    varLatitude = [meanLatitude,var(tempLat)];
end

% 计算时间
time = (1:size(meanLongitude, 1)) / 60;  

% 绘制经度均值和方差的曲线
figure;
subplot(2, 1, 1);
plot(time, meanLongitude, 'o-', 'LineWidth', 2, 'DisplayName', '均值');
hold on;
plot(time, varLongitude, 's-', 'LineWidth', 2, 'DisplayName', '方差');
title('经度均值和方差随时间变化');
xlabel('时间（秒）');
ylabel('经度');
legend;

% 绘制纬度均值和方差的曲线
subplot(2, 1, 2);
plot(time, meanLatitude, 'o-', 'LineWidth', 2, 'DisplayName', '均值');
hold on;
plot(time, varLatitude, 's-', 'LineWidth', 2, 'DisplayName', '方差');
title('纬度均值和方差随时间变化');
xlabel('时间（秒）');
ylabel('纬度');
legend;
