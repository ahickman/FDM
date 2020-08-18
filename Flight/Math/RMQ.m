function [H] = RMQ(q)
% Direction-Cosine rotation matrix described by input quaternion

x	= q(1);
y	= q(2);
z = q(3);
w = q(4);

H(1,1)	=  x^2 - y^2 - z^2 + w^2;
H(1,2)	= 2 * ( x*y + z*w);
H(1,3)	= 2 * ( x*z - y*w);
H(2,1)	= 2 * ( x*y - z*w);
H(2,2)	= -x^2 + y^2 - z^2 + w^2;
H(2,3)	= 2 * ( y*z + x*w);
H(3,1)	= 2 * ( x*z + y*w);
H(3,2)	= 2 * ( y*z - x*w);
H(3,3)	= -x^2 - y^2 + z^2 + w^2;
