import os
"""
LS fragments were processed into seven types: 
Q1, Q2, Q3, S1, S2, T1, T2
"""
video_folder = "./final_video/"
qp = [48, 40, 29]
videos = os.listdir(video_folder)
# Generate different QP levels
for i in range(len(qp)):
    for video in videos:
        if video.endswith('.mp4'):
            if not os.path.exists(f'./final_video/{video[:-5]}_QP'):
                os.makedirs(f'./final_video/{video[:-5]}_QP')
            os.system(
                f'ffmpeg -i final_video/{video} -c:v libx264 -qp {qp[i]} final_video/{video[:-5]}_QP/{video[:-4]}_Q{i + 1}.mp4')
# Generate different resolution levels
resulotion = ['640:480', '1280:960']
for i in range(len(resulotion)):
    for video in videos:
        if video.endswith('.mp4'):
            if not os.path.exists(f'./final_video/{video[:-5]}_Res'):
                os.makedirs(f'./final_video/{video[:-5]}_Res')
            os.system(
                f'ffmpeg -i final_video/{video} -vf scale={resulotion[i]} final_video/{video[:-5]}_Res/{video[:-4]}_S{i + 1}.mp4')
# Generate different frame rate levels
fps = [5, 10]
for i in range(len(fps)):
    for video in videos:
        if video.endswith('.mp4'):
            if not os.path.exists(f'./final_video/{video[:-5]}_FR'):
                os.makedirs(f'./final_video/{video[:-5]}_FR')
            os.system(
                f'ffmpeg -i final_video/{video} -r {fps[i]} final_video/{video[:-5]}_FR/{video[:-4]}_T{i + 1}.mp4')
