%Filter Setup
%This script, taken from code by:
%Jake Aho, CU Boulder
%Sets up the filter values programatically

% NREL Collective Pitch Baseline Controller
% For CART 3
% J.Aho 2/1/12
% This script sets up the variables for the CP simulink models

BO = bodeoptions; % Set phase visiblity to off and frequency units to Hz in options
BO.FreqUnits = 'Hz'; % Create plot with the options specified by P

makePlot = 0;

Wrated=1600*2*pi/60;
WratedRPM=1600;
Ngear=43.165;
DT=Ts;


%% Torque Controller

TqFiltNum=[0.02034    0.04068    0.02034];
TqFiltDen=[1.0000   -1.608    0.6893];
TqFilt=ss(tf(TqFiltNum,TqFiltDen,DT));

if(makePlot)
    figure
    bode(TqFilt,BO)
end


TqLPFNum=[0 1/400];
TqLPFDen=[1 -.9975];
TqLPF=ss(tf(TqLPFNum,TqLPFDen,DT));

if(makePlot)
    figure
    bode(TqLPF,BO)
end

%% Baseline Blade Pitch
% 
% BpKi=.109;
% BpKp=.0830;


FilterDTAdjNum=0.9968682357708073*[1 -1.998211394972369 1];
FilterDTAdjDen=[1 -1.9919534680032287 0.99373647154161415];
FilterDTAdj=ss(tf(FilterDTAdjNum,FilterDTAdjDen,DT));

if(makePlot)
    figure
    bode(FilterDTAdj,BO)
end


Notch3PAdjNum=0.99446178895819493*conv([1 -1.9990772582076561 1],[1 -1.9990772582076561 1]);
Notch3PAdjDen=conv([1 -1.9928522162552329 0.9939572479845733],[1 -1.9942003305496883  0.99496658627763479]);
Notch3PAdj=ss(tf(Notch3PAdjNum,Notch3PAdjDen,DT));

if(makePlot)
    figure
    bode(Notch3PAdj,BO)
end


Notch15Num=0.98895424806713994*conv([1 -1.9395484718843772 1],[1 -1.9395484718843772 1]);
Notch15Den=conv([1 -1.9258456924450686 0.98871181552035881],[1 -1.9317091556007062 0.98919674382272604]);
Notch15=ss(tf(Notch15Num,Notch15Den,DT));

if(makePlot)
    figure
    bode(Notch15,BO)
end


PitchRolloff10HzNum=[0.005525    0.01105    0.005525];
PitchRolloff10HzDen=[ 1.0000   -1.7791    0.8012];
PitchRolloff10Hz=ss(tf(PitchRolloff10HzNum,PitchRolloff10HzDen,DT));


if(makePlot)
    figure
    bode(PitchRolloff10Hz,BO)
end


Nf=0.9*2*pi;
Gen_p9Hz_Notch=tf([1 2*.02*Nf Nf^2],[1 2*.2*Nf Nf^2]);
Gen_p9Hz_Notch=ss(Gen_p9Hz_Notch);
Gen_p9Hz_Notch=c2d(Gen_p9Hz_Notch,DT);

%% Load drivetrain damper

load('cHinfDiscreteSISO.mat')

