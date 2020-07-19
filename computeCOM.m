function [COM, M] = computeCOM(in)
  
M = sum(in(:,4));
Rx = (1/M) * sum(in(:,1).*in(:,4));
Ry = (1/M) * sum(in(:,2).*in(:,4));
Rz = (1/M) * sum(in(:,3).*in(:,4));
COM = [Rx Ry Rz];
