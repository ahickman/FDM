function I = computeMOI(in)

I = zeros(3,3);

[COM, M] = computeCOM(in);

xk = in(:,1) - COM(1);
yk = in(:,2) - COM(2);
zk = in(:,3) - COM(3);

Ixx = sum(M.*(yk.^2+zk.^2));
Iyy = sum(M.*(xk.^2+zk.^2));
Izz = sum(M.*(xk.^2+yk.^2));

Ixy = -1 * sum(M.*(xk.*yk)); Iyx = Ixy;
Ixz = -1 * sum(M.*(xk.*zk)); Izx = Ixz;
Iyz = -1 * sum(M.*(yk.*zk)); Izy = Iyz;

I = [ Ixx Ixy Ixz; Iyx Iyy Iyz; Izx Izy Izz];