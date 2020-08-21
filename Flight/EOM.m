function [ xDot ] = EOM(AeroModel, t, x)

% Inputs
vB = x(1:3);
rI = x(4:6);
wB = x(7:9);
qI = x(10:13);

global Ixx Iyy Izz mass
global cBar b S lHT
rho = 1.225;

R2D = 180 / pi;

HEB = RMQ(qI);
V = norm(vB);
alphar = atan(vB(3) / abs(vB(1)));

%disp(alphar*180/pi)
%[CD,CL,CY,Cl,Cm,Cn,Thrust]	=	AeroModel(x,uTotal,alphar,betar,V);
[CD,CL,CY]	=	AeroModel(x,0,alphar,0,V);

qbarS = 0.5 * rho * V * V * S;

% CL & CD are aligned with Velocity vector, project onto body axes
CX = -CD*cos(alphar) + CL*sin(alphar);
CZ = -CD*sin(alphar) - CL*cos(alphar);

% Compute State Accelerations
xB = (CX * qbarS) / mass;
yB = (CY * qbarS) / mass;
zB = (CZ * qbarS) / mass;

F = [ 0 0 0 ];
M = [ 0 0 0 ];

wBdot(1) = (M(1) - (Izz-Iyy)*wB(2)*wB(3))/Ixx;
wBdot(2) = (M(2) - (Ixx-Izz)*wB(3)*wB(1))/Iyy;
wBdot(3) = (M(3) - (Iyy-Ixx)*wB(1)*wB(2))/Izz;

qIdot = 0.5 * mul(qI, [wB 0]);


% Update vB based on change in orientation:
% udot =  psiDot   * v - thetaDot * w;
% vdot = -psiDot   * u + phiDot   * w; 
% wdot =  thetaDot * u - phiDot   * v;



%xB = 0; yB = 0; zB = 0;

% Dynamic Equations
% vBdot ...
% dAxial    =  yawDot   * v - pitchDot * w;
% dSideways = -yawDot   * u + rollDot  * w; 
% dNormal   =  pitchDot * u - rollDot  * v;
vBdot(1) = xB + x(9) * x(2) - x(8) * x(3);
vBdot(2) = yB - x(9) * x(1) + x(7) * x(3);
vBdot(3) = zB + x(8) * x(1) - x(7) * x(2);


rIdot = [ HEB' * vB']';

xDot = [vBdot rIdot wBdot qIdot];
