function [ q3 ] = mul(q1, q2)
% Multiplication for quaternions in the [x y z w] form;

v1 = q1(1:3);
w1 = q1(4);
v2 = q2(1:3);
w2 = q2(4);

w 	= w1*w2 - dot(v1, v2);
v 	= w1*v2 + w2*v1 + cross(v1, v2);

q3 = [ v w ];
