function [ xD ] = eomTumble( t, x )

%%% EOM
r = x(1:3)';
v = x(4:6)';
q = x(7:10)';
w = x(11:13)'; % Roll, Pitch, Yaw (Angular Rates)

mass = 1;

% Set up 3x3 Inertia Tensor

vmag = norm(v);

% Compute AC body axes
if vmag>0
  % Get velocity unitVector
  uv = v / norm(v);
  % Get Body axes from orientation quaternion
  zB = mul(mul(q, [0 0 0 1]), conjugate(q)); zB = zB(2:4); zB = zB ./norm(zB);
  yB = cross(zB, uv); yB=yB./norm(yB);
  xB = cross(yB, zB); xB=xB./norm(xB);
else
  % Get velocity unitVector
  uv = [ 0 0 -1];
  % Get Body axes from orientation quaternion
  zB = mul(mul(q, [0 0 0 1]), conjugate(q)); zB = zB(2:4); zB = zB ./norm(zB);
  yB = mul(mul(q, [0 0 1 0]), conjugate(q)); yB = yB(2:4); yB = yB ./norm(yB);
  xB = cross(yB, zB); xB=xB./norm(xB);
end

% Compute AC_Alpha and lift/drag vectors
alpha = -acos(min([dot(uv,xB), 1]));
uLift = cross(uv, yB); % Lift acts perpendicular to the velocity vector
uDrag = -uv;
uGrav = [0 0 1];
F = [ 0 0 0 ];

% Simple Sphere First
I1 = 1;
I2 = 1;
I3 = 1;

L_T = 0; % Total Torque vector in Body Frame about the X_B, Y_B, & Z_B axes
M_T = 0;
N_T = 0;

wD(1) = (L_T - (I3-I2) * w(2)*w(3))/I1;
wD(2) = (M_T - (I1-I3) * w(3)*w(1))/I2;
wD(3) = (M_T - (I2-I1) * w(1)*w(2))/I3;


% Compute derivatives
rD = v;
vD = F./mass;
wW = mul(mul(q, [ 0 w ]), conjugate(q));
qD = 0.5 * mul(wW, q);

xD = [ rD vD qD wD ]'; 