%%%%���������ڴ���transEM��A�����ݣ�ͨ����90�ȣ����߼�270,�ﵽ��ǵ�����
%session = ["Data_Session1","Data_Session2","Data_Session3","Data_Session4","Data_Session5","Data_Session6","Data_Session7","Data_Session8"];
%subFileList = ["001","002","003","004","005","006","007","008","009","010","011","012","013","014","015","016","017","018","019","020","021"];
%framelist = ["RateList1","RateList2","RateList3","RateList4","RateList5","RateList6","RateList7","RateList8"];
%transEM_path = 'transEM\';
%framelist_path = 'D:\�ҵ��ļ�\ʵ�����\data_process\R_frameRateList\';
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
        %��transEM��ȡ����

        %[~,~,or_data] = xlsread(strcat(transEM_path,session(i),A_B,subFileList(j),'\',video_name,'.xlsx'));
        reData = zeros(length(or_data),5);
        lon_hm = cell2mat(or_data(:,8)); %���ȶ�Ӧ��8��yaw
        lon_em = cell2mat(or_data(:,5));

        %��������.������ü�90�Ȳ���
        lon_hm = lon_hm -90;
        lon_em = lon_em -90;
        %%������������ݷ�Χ�޶���-180��180֮�䣬���ȶ�lon_hm����
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
       %��lon_em����
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
        %%��ֵ
        reData(:,1) = cell2mat(or_data(:,7));
        reData(:,2) = lon_hm;
        reData(:,3) = cell2mat(or_data(:,9));
        reData(:,4) = cell2mat(or_data(:,4));
        reData(:,5) = lon_em;

        %��������
        %saveFolder = save_file_path+session(i)+A_B+subFileList(j)+'\';
        saveFolder = [save_file_path,video_name_list{i},'\'];
        if(~exist(saveFolder,'dir'))
            mkdir(saveFolder);
        end
        %saveName = saveFolder + hmd_files(n).name;
        xlswrite([saveFolder,hmd_files(n).name],reData);
        %%���ݻ����в��Ե�
        a = abs(reData(:,2)-reData(:,5));
        %for s = 1:length(a)
        %     if((a(s)>15)&&((a(s)-360)>2.5))
        %        saveName
        %        a(s)
        %    end
        %end
    end 
end