r = [ 0 0 1 ]; % meters
vmag = 2; % m/s

% All angles in radians
% Velocity Vector
yaw = 0*pi/180; % +CW
pitch = 0*pi/180; % +NOSEUP

% AC orientation relative to velocity vector
roll = 0; % +CW
alpha = 0; % +NOSEUP

%Initial anglular rates (radians / second):
phiDot = 0*pi/180; % Roll Rate (about z)
thetaDot = 0*pi./180; % Pitch Rate (about y')
psiDot = 10*pi./180; % Yaw Rate (about x'')

% Angular Velocity Vector
w = [ phiDot thetaDot psiDot];

% Derive AC orientation from velocity and Alpha
qY = [ cos(-yaw/2) sin(-yaw/2) .* [ 0 0 1 ]];
qP = [ cos(-pitch/2) sin(-pitch/2) .* [ 0 1 0 ]];
qR = [ cos(roll/2) sin(roll/2) .* [ 1 0 0 ]];
qA = [ cos(-alpha/2) sin(-alpha/2) .* [ 0 1 0 ]];

% Compute Initial Velocity Vector
rot = mul(qY, qP);
v = mul(mul(rot, [0 vmag 0 0]), conjugate(rot));
v = v(2:4);

% Compute initial AC orientation:
% Sequence: yaw => pitch => roll => alpha
q = mul(mul(mul(qY, qP), qR), qA);

% State Vector:
X = [ r v q w ];

% Setup Simple ODE:
tFinal = 10;
nsteps = 100;
tspan = 0:tFinal/nsteps:tFinal;
[t, x] = ode45(@eomTumble, tspan, X, []);
idx = find(x(:,3)<0);
x(idx,:) = [];
t(idx) = [];

figure
for ii = 1:10:length(x)
  [p, pTxt] = plotEntity(x(ii,:));
end

legend(p, pTxt);
format_figure('Entity Over Time', 'X(inertial)', 'Y(inertial)', 'Z(inertial)')
axis equal