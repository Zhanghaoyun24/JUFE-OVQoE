# JUFE-OVQoE
Omnidirectional video viewport adaptive streaming QoE database

## Database
We provides a Viewport-based Omnidirectional Video QoE database, which includes twelve original omnidirectional videos with diverse content, and corresponding 378 viewport videos generated by compressing the raw viewports using a variety of combinations of amplitude (quantization parameter), spatial (frame size), and temporal (frame rate) resolutions.
## Download
[Video data](https://pan.baidu.com/s/1n6S8dnj8M7vhj-ozxmDqVg?pwd=1234)
## Usage Guidelines
After collecting the raw head-movement data and eye-movement data, the following steps are required to process them.
### 1. HMDdata_processing
The raw head and eye movement data needs to be processed in two steps to be converted into panoramic video latitude and longitude data, you need to run the getHMDdata.m and VRVQoE.m files.
### 2. extract_fov
After processing the head-movement and eye-movement data, you just need to run the demo.m file to extract the corresponding viewport video
### 3. video_processing
step1.py: Encoding viewport video into different quality representations  
step2.py: Cropping a 10 seconds long sequences (LS) into into two 5 seconds viewport short segments (SS)  
step3.py: Concatenate two consecutive viewport SS of 5 seconds with different representations from the same viewport video into LS of 10 seconds

## Citation
Please cite our papers if it helps your research:
```bibtex
@inproceedings{liu2024icip,
title={Quality of Experience of viewport adaptive omnidirectional video streaming},
author={Liu, Xuelin and Zhang, Haoyun and Yan, Jiebin and Zhang, Hao and Fang, Yuming and Wang, Shiqi},
booktitle={IEEE ICIP},
year={2024}
}
