function [t, f] = rungekutta(odeFcn, aeroModel, tspan, x0);

x = x0;

f = zeros(length(tspan), length(x0));
f(1,:) = x0;
t = 0;
h = 0.01;
deltaTime = tspan(2) - tspan(1);
for ii=2:length(tspan)
	for jj=1:deltaTime/h
		  F1 = h*feval(odeFcn, aeroModel, t,		x);
  		F2 = h*feval(odeFcn, aeroModel, t+0.5*h, 	x+0.5*F1);
  		F3 = h*feval(odeFcn, aeroModel, t+0.5*h, 	x+0.5*F2);
  		F4 = h*feval(odeFcn, aeroModel, t+h, 	x+F3);
		  x = x + (1 / 6) * (F1 + 2*F2 + 2*F3 + F4);
	end
	f(ii,:) = x;
end

t = tspan;
