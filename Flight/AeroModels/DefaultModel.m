function [ CD, CL, CY ] = DefaultModel(x, u, alphar, betar, V) 

CD = 0;
CL = 0;
CY = 0;

global Ixx Iyy Izz Ixz mass
global cBar b S lHT


% LIFT
CLo       = 0;
CLa       = 0.5;
CLqhat    = 2.49;
CLq       =	CLqhat*cBar/(2*V);
CLdE      = 0.72;
CLdS      = CLdE;
 
%         Total Lift Coefficient, w/Mach Correction
%CL        =	(CLo + CLa*alphar + CLq*x(8) + CLdS*u(7) + CLdE*u(1))*Prandtl;
CL        =	(CLo + CLa*alphar);

% DRAG
CDo     = 0.019;
CD      = CDo;