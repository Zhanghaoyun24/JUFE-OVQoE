clc;
clear all;

video_path = 'D:\Unity projects\VRQoE\Test_session\video\';  % 修改为你的视频路径
hmdata_path = './final_myhmd/user/';  

% 视口大小设置
FOV_horizontal = deg2rad(120);
FOV_vertical = deg2rad(120);

save_path = './viewport/';

video_files = dir([video_path, '*.mp4']);
hmdata_files = dir([hmdata_path, '*.csv']);

for k = 1:length(video_files)
    videoName = video_files(k).name;
    videoPath = [video_path, videoName];
    
    % 获取当前视频对应的hm_data文件
    hmdata_file = fullfile(hmdata_path, [videoName(1:end-4), '.csv']);

    if exist(hmdata_file, 'file')
        videoReader = VideoReader(videoPath);
        width = videoReader.Width;
        height = videoReader.Height;
        fps = videoReader.FrameRate;

        [~, ~, eyeData] = xlsread(hmdata_file);
        num_frames = size(eyeData, 1);

        % 计算新的viewport_size
        viewport_horizontal = floor(FOV_horizontal / (2*pi) * width);
        viewport_vertical = floor(FOV_vertical / pi * height);
        savePath = [save_path, '/'];
        
        if(~exist(savePath, 'dir'))
            mkdir(savePath);
        end

        videoWriter = VideoWriter([savePath, 'FOV_', videoName], 'MPEG-4');
        videoWriter.FrameRate = fps;
        open(videoWriter);
        index = 1;

        % 读取视频的每一帧
        while hasFrame(videoReader)
            frame = readFrame(videoReader);
            
            % 从头动数据中获取经度和纬度信息
            lat = deg2rad(cell2mat(eyeData(index,1)));
            lon = deg2rad(cell2mat(eyeData(index,2)));

            % 裁剪视口区域，分别对每个颜色通道进行裁剪
            rimg1 = cut_patch2(frame(:,:,1), lon, -lat, viewport_horizontal, viewport_vertical);
            rimg2 = cut_patch2(frame(:,:,2), lon, -lat, viewport_horizontal, viewport_vertical);
            rimg3 = cut_patch2(frame(:,:,3), lon, -lat, viewport_horizontal, viewport_vertical);
            rimg1 = uint8(rimg1);
            rimg2 = uint8(rimg2);
            rimg3 = uint8(rimg3);
            rimg = cat(3, rimg1, rimg2, rimg3);

            % 将裁剪后的帧写入新视频
            writeVideo(videoWriter, rimg);
            
            index = index + 2;
            fprintf('Video: %s, frame: %d\n', videoName, videoReader.CurrentTime * fps);
        end

        % 关闭VideoWriter对象
        close(videoWriter);
    else
        fprintf('HM data file not found for video: %s\n', videoName);
    end
end
