function [lat,lon] = transAngle(x,y,z)
%TRANSANGLE 此处显示有关此函数的摘要
% x y,z 为三维坐标系下的点
% lat,lon 为三维坐标下的纬度和经度,单位为角度
%转换公式
lat = rad2deg(asin(y./1));
lon = rad2deg(atan2(x,-z)); %%%
end

