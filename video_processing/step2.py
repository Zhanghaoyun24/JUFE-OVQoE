import os

video_folder = './final_video/'
video_paths = os.listdir(video_folder)
dict = {
    'Q1':48,
    'Q2':40,
    'Q3':29
}

for video_path in video_paths:
    if not video_path.endswith('.mp4'):
        video_names = os.listdir(video_folder + video_path)
        for video_name in video_names:
            video = video_folder + video_path +'/'+ video_name
            if not os.path.exists(f'./SS/{video_name[:-4]}'):
                os.makedirs(f'./SS/{video_name[:-4]}')
                # 视频QP不为29时，防止被处理为默认29
            if video_name[-6:-4] in dict.keys():
                print(dict[video_name[-6:-4]])
                os.system(
                    f'ffmpeg -i {video} -ss 00:00:00 -to 00:00:05 -qp {dict[video_name[-6:-4]]} SS/{video_name[:-4]}/{video_name[:-4]}_seg1.mp4'
                )
                os.system(
                    f'ffmpeg -i {video} -ss 00:00:05 -to 00:00:10 -qp {dict[video_name[-6:-4]]} SS/{video_name[:-4]}/{video_name[:-4]}_seg2.mp4'
                )
            else:
                os.system(
                    f'ffmpeg -i {video} -ss 00:00:00 -to 00:00:05 SS/{video_name[:-4]}/{video_name[:-4]}_seg1.mp4'
                )
                os.system(
                    f'ffmpeg -i {video} -ss 00:00:05 -to 00:00:10 SS/{video_name[:-4]}/{video_name[:-4]}_seg2.mp4'
                )

