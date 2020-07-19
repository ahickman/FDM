function [ q3 ] = mul( q1, q2 )
% Quaternion Multiplication: 
%    q3 = q1 * q2 
% ex:
%   q1 = [3 2 5 4];
%   q2 = [4 5 3 1];
%   q1*q2 = [-17 16 47 0]

% Overly Verbose Method for clarity
%     w1  = q1(1);
%     x1  = q1(2);
%     y1  = q1(3);
%     z1  = q1(4);
% 
%     w2  = q2(1);
%     x2  = q2(2);
%     y2  = q2(3);
%     z2  = q2(4);
% 
%     w   = w1*w2 - x1*x2 - y1*y2 - z1*z2;
%     x   = w1*x2 + x1*w2 + y1*z2 - z1*y2;
%     y   = w1*y2 - x1*z2 + y1*w2 + z1*x2;
%     z   = w1*z2 + x1*y2 - y1*x2 + z1*w2;
%     q3  = [w x y z]; 

% Compact Form:
    w  = -q1(:,2) * q2(:,2) - q1(:,3) * q2(:,3) - q1(:,4) * q2(:,4) + q1(:,1) * q2(:,1);
    x  =  q1(:,2) * q2(:,1) + q1(:,3) * q2(:,4) - q1(:,4) * q2(:,3) + q1(:,1) * q2(:,2);
    y  = -q1(:,2) * q2(:,4) + q1(:,3) * q2(:,1) + q1(:,4) * q2(:,2) + q1(:,1) * q2(:,3);
    z  =  q1(:,2) * q2(:,3) - q1(:,3) * q2(:,2) + q1(:,4) * q2(:,1) + q1(:,1) * q2(:,4);    
    q3 = [w x y z];
end

