clc;
clear all;

video_path = 'D:\Unity projects\VRQoE\Test_session\video\';  % Change to your video path
hmdata_path = './final_myhmd/user/';  

%Setting the viewport size
FOV_horizontal = deg2rad(120);
FOV_vertical = deg2rad(120);

save_path = './viewport/';

video_files = dir([video_path, '*.mp4']);
hmdata_files = dir([hmdata_path, '*.csv']);

for k = 1:length(video_files)
    videoName = video_files(k).name;
    videoPath = [video_path, videoName];
    hmdata_file = fullfile(hmdata_path, [videoName(1:end-4), '.csv']);

    if exist(hmdata_file, 'file')
        videoReader = VideoReader(videoPath);
        width = videoReader.Width;
        height = videoReader.Height;
        fps = videoReader.FrameRate;

        [~, ~, eyeData] = xlsread(hmdata_file);
        num_frames = size(eyeData, 1);
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

        while hasFrame(videoReader)
            frame = readFrame(videoReader);
            lat = deg2rad(cell2mat(eyeData(index,1)));
            lon = deg2rad(cell2mat(eyeData(index,2)));

            rimg1 = cut_patch2(frame(:,:,1), lon, -lat, viewport_horizontal, viewport_vertical);
            rimg2 = cut_patch2(frame(:,:,2), lon, -lat, viewport_horizontal, viewport_vertical);
            rimg3 = cut_patch2(frame(:,:,3), lon, -lat, viewport_horizontal, viewport_vertical);
            rimg1 = uint8(rimg1);
            rimg2 = uint8(rimg2);
            rimg3 = uint8(rimg3);
            rimg = cat(3, rimg1, rimg2, rimg3);
            writeVideo(videoWriter, rimg);
            index = index + 2;
            fprintf('Video: %s, frame: %d\n', videoName, videoReader.CurrentTime * fps);
        end
        close(videoWriter);
    else
        fprintf('HM data file not found for video: %s\n', videoName);
    end
end
