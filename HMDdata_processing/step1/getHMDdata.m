clc;
clear;

[~,~,videoInfo] = xlsread('.\videolist.xlsx');
video_name_list = videoInfo(1:end,1);
video_info = videoInfo(2:end,2:end);
video_info = cell2mat(video_info);
session_num = 1;
% HMD_files = dir(['.\Org_HMD\Session',num2str(session_num)]);
HMD_files = dir(['.\Org_HMD\Session']);
% session_videolist = textread(['Session_videolist\session_',num2str(session_num),'.txt'],'%s');
session_videolist_path = fullfile('Session_videolist', 'session.txt');
session_videolist = textread(session_videolist_path, '%s');

video_num = length(session_videolist);
for i=1:size(HMD_files,1)-2 
    [~,~,videoHMDataList] = xlsread(['.\Org_HMD\Session\',HMD_files(i+2).name]);
    for j=1:video_num
        video_name = session_videolist{j};
        index_all=find(ismember(video_name_list,video_name));
        video = VideoReader(['D:\Unity projects\VRQoE\Assets\StreamingAssets\AVProVideoSamples\VRData\VideoSequence\',video_name]);
        framerate = video.FrameRate;
        duration = video.duration;
        clear video;
        total_frame = round(framerate*duration);
        start_index = getVideoStartIndex(videoHMDataList,video_name);
        break_index = getBreakIndex(videoHMDataList,start_index,j)-2;
        % 8,9,10: eye data (x,y,z), 12,13,14: head data (pitch, yaw, roll)
        current_videoData = videoHMDataList(start_index+2:break_index,[5,6,7,8,9,10,12,13,14]);
        if framerate<=45
            Total_frame = total_frame*2;
        else
            Total_frame = total_frame;
        end
        current_videoData_tmp = Sampling(current_videoData,Total_frame);
        newCurrentVideoData = [videoHMDataList(start_index:start_index+1,[1,2,3,4,5,6,7,8,9]);current_videoData_tmp];
%         if (class(newCurrentVideoData)=="cell")
%             newCurrentVideoData = cell2mat(newCurrentVideoData);
%         end
        saveFolder = ['.\Processed_HMD\Session\', video_name, '\'];
        if (~exist(saveFolder,'dir'))%%判断文件夹是否存在
             mkdir(saveFolder);  
        end
        dataSavePath = [saveFolder,video_name,'_',num2str(i,'%02d'),'.csv'];
        xlswrite(dataSavePath ,newCurrentVideoData);
        fprintf('%d-th session, %d-th file, %d-th video. frames: %d, length: %d.\n',session_num,i,j,total_frame,break_index-start_index);
    end
end