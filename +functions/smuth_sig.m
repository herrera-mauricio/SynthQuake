function output=smuth_sig(input,n)
%--------------------------------------------------------------------------
% Proposed multi-times averaging with moving short window method
% Input variables
% input   : power2 of the recorded earthquake signal (acc.^2)
% n       : how many times for repearting the averaging process
% Output variables
% output  : energy distribution of recorded earthquake signal
% Zheng Li, Panagiotis Kotronis, Hanliang Wu, 2016. lizheng619@hotmail.com; lizheng619@gmail.com
%--------------------------------------------------------------------------
output = zeros(size(input,1),size(input,2));
for j=1:n
    %
    for i=2:length(input)-1
        output(i) = 0.5*(input(i-1)+input(i+1));
    end
    %
    output(1)             = 0.5*(input(2)+input(length(input)));
    output(length(input)) = 0.5*(input(length(input)-1)+input(1));
    %
    input = output;
    %
end
return