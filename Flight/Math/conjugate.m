function [ qout ] = conjugate( qin )
%QCONJ Summary of this function goes here
%   Detailed explanation goes here

qout(:,1) = -qin(:,1);
qout(:,2) = -qin(:,2);
qout(:,3) = -qin(:,3);
qout(:,4) =  qin(:,4);

end