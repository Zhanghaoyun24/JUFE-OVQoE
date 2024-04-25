clc;
clear all;

org_file_path = '../Processed_HMD/Session/';
save_file_path = '../step2_Processed_HMD/Session/';

[~,~,videoInfo] = xlsread('D:\Unity projects\VRQoE\Test_Session\videolist.xlsx');
video_name_list = videoInfo(1:end,1);
video_info = videoInfo(2:end,2:end);
video_info = cell2mat(video_info);

for i=1:size(video_name_list,1)
    hmd_files = dir([org_file_path,video_name_list{i}]);
    hmd_files = hmd_files(3:end,1);
    for k=1:20
        [~,~,rawdata] = xlsread([org_file_path,video_name_list{i},'\',hmd_files(k).name]);
        len = length(rawdata);
        % 4,5,6: eye data (x,y,z), 7,8,9: head data (pitch, yaw, roll)
        for j=3:len
            offset=rawdata{2,1};  % offset
            subfile{j-2,1}=rawdata{j,7};   % pitch
            yaw=rawdata{j,8};
            subfile{j-2,3}=rawdata{j,9};   % roll
            %对修改后的y值需要进行判断，并且落在-180�?80之间
%             subfile{j-2,2} = yaw+offset;
            if(yaw+offset>180)
                subfile{j-2,2} = yaw+offset-360;
            elseif (yaw+offset<-180)
                subfile{j-2,2} = yaw+offset+360;
            else
                subfile{j-2,2} = yaw+offset;
            end

            eye_x=rawdata{j,4};  % directionX
            eye_y=rawdata{j,5};  % directionY
            eye_z=rawdata{j,6}; % directionZ
            % yaw yaw   = -Math.atan2(dx,-dz);
            eye_lon=-rad2deg(atan2(rawdata{j,5},sqrt(rawdata{j,4}*rawdata{j,4}+rawdata{j,6}*rawdata{j,6})));
            eye_lat=rad2deg(atan2(rawdata{j,4},rawdata{j,6}));
            % pitch pitch = Math.atan2(dy, Math.sqrt((dx * dx) + (dz * dz)));
    %         [eye_lat, eye_lon] = transAngle(eye_x,eye_y,eye_z);

            subfile{j-2,4}=eye_lon;
%             subfile{j-2,5}=eye_lat+offset;
            if(eye_lat+offset>180)
                subfile{j-2,5}=eye_lat+offset-360;
            elseif(eye_lat+offset<-180)
                subfile{j-2,5}=eye_lat+offset+360;
            else
                subfile{j-2,5}=eye_lat+offset;
            end
             %subfile{j-2,6}=rawdata{j,11};
        end
        folder=[save_file_path,video_name_list{i},'\'];
        if (~exist(folder,'dir'))
            mkdir(folder);
        end
        % head data: pitch, yaw, roll, eye data: latitude, longitude
        writecell(subfile, [folder,hmd_files(k).name], 'FileType', 'text');
        
        fprintf('file: %s.\n',hmd_files(k).name);
    end
end

