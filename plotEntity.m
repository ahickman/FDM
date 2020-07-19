function [p, pTxt] = plotEntity(x)
r = x(1:3);
v = x(4:6);
q = x(7:10);

vmag = norm(v);
if vmag==0
  uv = [ 1 0 0];
 else
  uv = v./ vmag;
end
zB = mul(mul(q, [0 0 0 1]), conjugate(q)); zB = zB(2:4); zB = zB ./norm(zB);
yB = mul(mul(q, [0 0 1 0]), conjugate(q)); yB = yB(2:4); yB = yB ./norm(yB);
xB = cross(yB, zB); xB = xB./norm(xB);

xB = xB.*0.5;
yB = yB.*0.5;
zB = zB.*0.5;

p = zeros(4,1);
hold on
p(1) = plot3([r(1) r(1)+uv(1)],[r(2) r(2)+uv(2)],[r(3) r(3)+uv(3)],'k-', 'LineWidth', 1);
p(2) = plot3([r(1) r(1)+xB(1)],[r(2) r(2)+xB(2)],[r(3) r(3)+xB(3)],'b-', 'LineWidth', 2);
p(3) = plot3([r(1) r(1)+yB(1)],[r(2) r(2)+yB(2)],[r(3) r(3)+yB(3)],'g-', 'LineWidth', 2);
p(4) = plot3([r(1) r(1)+zB(1)],[r(2) r(2)+zB(2)],[r(3) r(3)+zB(3)],'r-', 'LineWidth', 2);
hold off
pTxt = {'uv', 'xB', 'yB', 'zB'};