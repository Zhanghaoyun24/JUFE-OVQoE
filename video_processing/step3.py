import os
import cv2

video_folder = './SS'
video_paths = os.listdir(video_folder)

video_seg1_list = []
video_seg2_list = []
for video_path in video_paths:
    video_path = os.path.join(video_folder, video_path)
    video = os.listdir(video_path)[0]
    video_seg1_list.append(os.path.join(video_path, os.listdir(video_path)[0]))
    video_seg2_list.append(os.path.join(video_path, os.listdir(video_path)[1]))

    if (len(video_seg1_list) == 7):
        for seg1 in video_seg1_list:
            for seg2 in video_seg2_list:
                if not os.path.exists(f'./LS/{video[:-12]}'):
                    os.makedirs(f'./LS/{video[:-12]}')
                cap1 = cv2.VideoCapture(seg1)
                cap2 = cv2.VideoCapture(seg2)
                width = 0
                height = 0
                if cap1.get(cv2.CAP_PROP_FRAME_WIDTH) != cap2.get(cv2.CAP_PROP_FRAME_WIDTH):
                    if (cap1.get(cv2.CAP_PROP_FRAME_WIDTH) < cap2.get(cv2.CAP_PROP_FRAME_WIDTH)):
                        width = int(cap2.get(cv2.CAP_PROP_FRAME_WIDTH))
                        height = int(cap2.get(cv2.CAP_PROP_FRAME_HEIGHT))
                    else:
                        width = int(cap1.get(cv2.CAP_PROP_FRAME_WIDTH))
                        height = int(cap1.get(cv2.CAP_PROP_FRAME_HEIGHT))
                    # 实现不同分辨率视频拼接
                    os.system(
                        f'ffmpeg -i {seg1} -i {seg2} -filter_complex "[0:v:0]scale={width}x{height}[video1];[1:v:0]scale={width}x{height}[video2];[video1][video2]concat=n=2:v=1:a=0[outv]" -map "[outv]" -vsync 2 LS/{video[:-12]}/{video[:-12]}_{seg1[-11:-9]}{seg2[-11:-9]}.mp4'
                    )
                else:
                    # 此命令可实现不同帧率的视频拼接
                    os.system(
                        f'ffmpeg -i {seg1} -i {seg2} -filter_complex "[0:v:0][1:v:0]concat=n=2:v=1:a=0[outv]" -map "[outv]" -vsync 2 LS/{video[:-12]}/{video[:-12]}_{seg1[-11:-9]}{seg2[-11:-9]}.mp4'
                    )
        # 处理完一类视频后初始化
        video_seg1_list = []
        video_seg2_list = []

