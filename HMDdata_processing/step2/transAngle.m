function [lat,lon] = transAngle(x,y,z)
%TRANSANGLE �˴���ʾ�йش˺�����ժҪ
% x y,z Ϊ��ά����ϵ�µĵ�
% lat,lon Ϊ��ά�����µ�γ�Ⱥ;���,��λΪ�Ƕ�
%ת����ʽ
lat = rad2deg(asin(y./1));
lon = rad2deg(atan2(x,-z)); %%%
end

