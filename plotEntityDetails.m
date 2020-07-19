function [p, pTxt] = plotEntityDetails(x, in)
r = x(1:3);
v = x(4:6);
q = x(7:10);

zB = mul(mul(q, [0 0 0 1]), conjugate(q)); zB = zB(2:4); zB = zB ./norm(zB);
yB = mul(mul(q, [0 0 1 0]), conjugate(q)); yB = yB(2:4); yB = yB ./norm(yB);
xB = cross(yB, zB); xB = xB./norm(xB);

xB = xB.*0.5;
yB = yB.*0.5;
zB = zB.*0.5;


COM = computeCOM(in);
p = in(:,1:3)-COM;
global CMAP;


plot3([r(1)],[r(2)],[r(3)],'r+'); 
hold on 
for ii = 1:size(in,1)
  p_i = mul(mul(q, [0 p(ii,:)]), conjugate(q));
  p_i = p_i(2:4);
  plot3([r(1)+p_i(1)],[r(2)+p_i(2)],[r(3)+p_i(3)],'o', 'color', CMAP(ii,:), 'LineWidth', 1, 'MarkerFaceColor', CMAP(ii,:)); 
  plot3([r(1) r(1)+p_i(1)],[r(2) r(2)+p_i(2)],[r(3) r(3)+p_i(3)],'k:', 'LineWidth', 1); 
end
hold off
