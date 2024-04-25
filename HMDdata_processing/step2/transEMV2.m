%%%%本代码用于处理transEM下A的数据，通过减90度，或者加270,达到标记的作用
%session = ["Data_Session1","Data_Session2","Data_Session3","Data_Session4","Data_Session5","Data_Session6","Data_Session7","Data_Session8"];
%subFileList = ["001","002","003","004","005","006","007","008","009","010","011","012","013","014","015","016","017","018","019","020","021"];
%framelist = ["RateList1","RateList2","RateList3","RateList4","RateList5","RateList6","RateList7","RateList8"];
%transEM_path = 'transEM\';
%framelist_path = 'D:\我的文件\实验代码\data_process\R_frameRateList\';
%A_B = 'A\';
clc;
clear all;

org_file_path = '../Processed_HMD/Session/';
save_file_path = '../step1_Processed_HMD/Session1/';

[~,~,videoInfo] = xlsread('D:\Unity projects\VRQoE\Test_Session\videolist.xlsx');
video_name_list = videoInfo(1:end,1);
video_info = videoInfo(2:end,2:end);
video_info = cell2mat(video_info);
for i = 1:1:size(video_name_list,1)
    %[~,~,videolist] = xlsread('videolist.xlsx');
    %video_number =length(videolist); 
    hmd_files = dir([org_file_path,video_name_list{i}]);
    hmd_files = hmd_files(3:end,1);
    for n = 1:1
        [~,~,or_data] = xlsread([org_file_path,video_name_list{i},'\',hmd_files(n).name]);
        or_data = or_data(3:end,:);
        %video_name = videolist{n,1};
        %从transEM读取数据

        %[~,~,or_data] = xlsread(strcat(transEM_path,session(i),A_B,subFileList(j),'\',video_name,'.xlsx'));
        reData = zeros(length(or_data),5);
        lon_hm = cell2mat(or_data(:,8)); %经度对应第8列yaw
        lon_em = cell2mat(or_data(:,5));

        %修正操作.这里采用减90度操作
        lon_hm = lon_hm -90;
        lon_em = lon_em -90;
        %%对修正后的数据范围限定在-180到180之间，首先对lon_hm操作
        for m = 1:length(lon_hm)
            if ((lon_hm(m)>180)&&(lon_hm(m)<540))
                lon_hm(m) = lon_hm(m)-360;
            end
            if (lon_hm(m)>540)
                lon_hm(m) = lon_hm(m)-720;
            end
            if ((lon_hm(m)<-180)&&(lon_hm(m)>-540)) 
               lon_hm(m)= lon_hm(m)+360;
            end
            if (lon_hm(m)<-540)
               lon_hm(m) = lon_hm(m)+720;
            end
        end
       %对lon_em操作
       for z = 1:length(lon_em)
            if ((lon_em(z)>180)&&(lon_em(z)<540))
                lon_em(z) = lon_em(z)-360;
            end
            if (lon_em(z)>540)
                lon_em(z) = lon_em(z)-720;
            end
            if ((lon_em(z)<-180)&&(lon_em(z)>-540)) 
               lon_em(z)= lon_em(z)+360;
            end
            if (lon_em(z)<-540)
               lon_em(z) = lon_em(z)+720;
            end
        end           

%             if (lon(1)>180)
%                 lon = lon-360;
%             end
%             if (lon(1)<-180)
%                 lon = lon+360;
%             end
        %%赋值
        reData(:,1) = cell2mat(or_data(:,7));
        reData(:,2) = lon_hm;
        reData(:,3) = cell2mat(or_data(:,9));
        reData(:,4) = cell2mat(or_data(:,4));
        reData(:,5) = lon_em;

        %保存数据
        %saveFolder = save_file_path+session(i)+A_B+subFileList(j)+'\';
        saveFolder = [save_file_path,video_name_list{i},'\'];
        if(~exist(saveFolder,'dir'))
            mkdir(saveFolder);
        end
        %saveName = saveFolder + hmd_files(n).name;
        xlswrite([saveFolder,hmd_files(n).name],reData);
        %%数据还是有不对的
        a = abs(reData(:,2)-reData(:,5));
        %for s = 1:length(a)
        %     if((a(s)>15)&&((a(s)-360)>2.5))
        %        saveName
        %        a(s)
        %    end
        %end
    end 
end