function [v_out]=acc_envelope(acc,t)
%--------------------------------------------------------------------------
% Proposed envelope shape based on the (recorded earthquake time-history).^2
% Input variables
% acc   : recorded earthquake signal
% t     : time
% Output variables
% v_out : output envelope shape
% Zheng Li, Panagiotis Kotronis, Hanliang Wu, 2016. lizheng619@hotmail.com; lizheng619@gmail.com
%--------------------------------------------------------------------------
% normalization of the (acc.^2)
acc_abs = abs(acc.^2)./max(abs(acc.^2));
% find the peak and the time point
loc_mid(1) = find(acc_abs==max(acc_abs));
t_mid(1)   = t(loc_mid(1));
v_mid(1)   = acc_abs(loc_mid(1));
% find peaks after the time of the peak
loc_right = loc_mid;
for i=2:200
    if loc_right<length(acc_abs)
        loc_right(i) = find(acc_abs==max(acc_abs(loc_right(i-1)+1:length(acc_abs))), 1, 'last' );
        t_right(i)   = t(loc_right(i));
        v_right(i)   = acc_abs(loc_right(i));
    end
end
t_right(1)=[];
v_right(1)=[];
% find peaks before the time of the peak
loc_left = loc_mid;
for i=2:200
    if loc_left>1
        loc_left(i) = find(acc_abs==max(acc_abs(1:loc_left(i-1)-1)), 1, 'first' );
        t_left(i)   = t(loc_left(i));
        v_left(i)   = acc_abs(loc_left(i));
    end
end
t_left = fliplr(t_left); t_left(length(t_left))=[];
v_left = fliplr(v_left); v_left(length(v_left))=[];

t_temp = [t_left t_mid t_right];
v_temp = [v_left v_mid v_right];

t_out = t';
% find envelope shape by linear interpolation
v_out = interp1(t_temp,v_temp,t_out);

return