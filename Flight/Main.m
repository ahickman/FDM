addpath(fullfile(pwd, "AircraftGeometry"));
addpath(fullfile(pwd, "AeroModels"));
addpath(fullfile(pwd, "Math"));
addpath(fullfile(pwd, "Utilities"));

%DefaultGeometry
%aeroModel = @DefaultModel;

DefaultGeometry
aeroModel = @DefaultModel;

D2R       = pi / 180;
R2D       = 180 / pi;

% Initial state
% x(1:3) 	= Body-axis inertial velocity (ub, vb, wb) m/s		vB
% x(4:6) 	= Inertial Position of COM (xe, ye, ze = -altitude)	rI
% x(7:9) 	= Body-axis angular rates (roll, pitch, yaw)		wB
% x(10:13)	= Orientation Quaternion (x,y,z,w)				qI

alt 		  = 10000;
V 		    = 150;
windB		  = [ 0 0 0 ];

alpha 	  = 10;  % If Pitch==Alpha, initial velocity aligned with xI
beta 		  = 0;
yaw 		  = 0;
pitch 	  = 10;
roll 		  = 0;

phiDot 	  = 0;
thetaDot	= 10;
psiDot 	  = 0; 

%% Parameters derived form initial conditions
alphar 	  = D2R * alpha;
betar 	  = D2R * beta;

vB 		    = [	V * cos(alphar) * cos(betar) - windB(1), ...
		  	      V * sin(betar) - windB(2), ...
		  	      V * sin(alphar) * cos(betar) - windB(3) ];

rI		    = [ 0 0 -alt ];

yawr		  = D2R * yaw;
pitchr	  = D2R * pitch;
rollr 	  = D2R * roll;

% Compute Rotation Quaternions
qY 		    = [sin(yawr/2) 	  .* [ 0 0 1 ] 	cos(yawr/2)   ];
qP		    = [sin(pitchr/2)  .* [ 0 1 0 ] 	cos(pitchr/2) ]; 
qR		    = [sin(rollr/2)   .* [ 1 0 0 ] 	cos(rollr/2)  ];
qI		    = mul(mul(qY, qP), qR);

phirDot	  = D2R * phiDot;
thetarDot	= D2R * thetaDot;
psirDot 	= D2R * psiDot;
wB 	 	    = [ phirDot thetarDot psirDot ];

x 		    = zeros(1,13);
x(1:3) 	  = vB;
x(4:6) 	  = rI;
x(7:9) 	  = wB;
x(10:13) 	= qI;

%xDot = EOM(aeroModel, 0, x);
%rIdot = xDot(4:6)
%vBdot = xDot(1:3)
%qIdot = xDot(10:13)
%wBdot = xDot(7:9)

if 1
  tFinal 	  = 30;
  nSteps 	  = tFinal*20;
  tspan 	  = 0:tFinal/nSteps:tFinal;
  [t, x] 	  = rungekutta(@EOM, aeroModel, tspan, x);
  
  idx = find(mod(t,1)==0);
  
  t = t(idx);
  x = x(idx, :);
  % Draw 3D Flight Path
  figure(1);
  clf;
  plot3(x(:,4), x(:,5), x(:,6), 'b*')
  hold on
  for ii = 1:length(t)  
    drawStateVector(t(ii), x(ii,:));
  end
  axis equal
  set(gca, 'YDir','reverse')
  set(gca, 'ZDir','reverse')
  formatFigure('3D Flight Path','X','Y','Altitude (-Z)')

  figure;
  plot(t(3:end), diff(diff(x(:,4))), 'b*')
  
end