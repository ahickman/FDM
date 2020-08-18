function [p, pTxt] = drawStateVector(t, sv)
r = sv(4:6); r(:,3) = r(:,3);
%v = x(4:6);
q = sv(10:13);

zB = mul(mul(q, [0 0 1 0]), conjugate(q)); zB = zB(1:3); zB = zB ./norm(zB);
yB = mul(mul(q, [0 1 0 0]), conjugate(q)); yB = yB(1:3); yB = yB ./norm(yB);
xB = mul(mul(q, [1 0 0 0]), conjugate(q)); xB = xB(1:3); xB = xB ./norm(xB);
%xB = cross(yB, zB); xB = xB./norm(xB);

HEB = RMQ(q);
xB = HEB' * [ 1 0 0]';
yB = HEB' * [ 0 1 0]';
zB = HEB' * [ 0 0 1]';

vLen = norm(sv(1:3))*0.5;
xB = xB.*vLen;
yB = yB.*vLen;
zB = zB.*vLen;


%COM = computeCOM(in);
%p = in(:,1:3)-COM;
%global CMAP;


%p(2) = plot([r(1) r(1)+xB(1)],[r(3) r(3)+xB(3)],'b-', 'LineWidth', 2);
%p(3) = plot([r(1) r(1)+yB(1)],[r(3) r(3)+yB(3)],'g-', 'LineWidth', 2);
%p(4) = plot([r(1) r(1)+zB(1)],[r(3) r(3)+zB(3)],'r-', 'LineWidth', 2);



%p(1) = plot3([r(1) r(1)+uv(1)],[r(2) r(2)+uv(2)],[r(3) r(3)+uv(3)],'k-', 'LineWidth', 1);
%p(1) = plot3([r(1) r(1)], [r(2) r(2)], [0 r(3)], '-', 'color', [.8 .8 .8])
p(2) = plot3([r(1) r(1)+xB(1)],[r(2) r(2)+xB(2)],[r(3) r(3)+xB(3)],'b-', 'LineWidth', 2);
p(3) = plot3([r(1) r(1)+yB(1)],[r(2) r(2)+yB(2)],[r(3) r(3)+yB(3)],'g-', 'LineWidth', 2);
p(4) = plot3([r(1) r(1)+zB(1)],[r(2) r(2)+zB(2)],[r(3) r(3)+zB(3)],'r-', 'LineWidth', 2);



%HEB = RMQ(q);
%xB = HEB' * [ 1 0 0]';
%t = [ HEB' * [1 0 0']';