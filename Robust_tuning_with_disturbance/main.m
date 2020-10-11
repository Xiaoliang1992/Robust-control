close all
clc
load('trim1226_7.mat');

disp('----------* Robust H-infinity synthesis for baseline controller with fixed parameter *----------')

figure
imshow('control_block.JPG')
title('Control block')

Bd = [eye(6);zeros(3,6)];
Ap = Aa;
Bp = Ba;
Cp = f_select_matrix([1 2 3 9],9);
np = size(Ap,1);
n = size(Cp,1);
m = size(Bp,2);
Dp = zeros(n,m);
nd = size(Bd,2);
Cs = eye(9);
Ds = zeros(9,4);
% m为系统输出个数（参考输入个数）,n为系统输入个数，np为系统状态个数（阶数）
%正常下 m = n
if m~=n
    error('wocao\n');
end

KI = zeros(m,m);
KF = zeros(m,np);
ST0 = slTuner('DF_Hinf_tuning',{'KI','KF'});
addPoint(ST0,{'U-ref','V-ref','W-ref','psi-ref'})   % setpoint commands
addPoint(ST0,{'U','V','W','psi'})               % corresponding outputs
addPoint(ST0,{'dis','xp','y','u','yf','uI','yI'})         

%% Tuning specifications

% 1: Stability margin
% Gain and phase margins at plant inputs and outputs
MarginReq1 = TuningGoal.Margins('u',2,20);
MarginReq2 = TuningGoal.Margins('y',2,20);

% 2: Tracking performance
TrackReq = TuningGoal.StepTracking({'U-ref','V-ref','W-ref','psi-ref'},{'U','V','W','psi'},0.65,0.1);
TrackReq.RelGap = 0.001;

% 3: Input saturation
Req = TuningGoal.Gain({'U-ref','V-ref','W-ref','psi-ref'},'u',tf([0.004],[0.06 1]));

% 4: Disturbance rejection
Req2 = TuningGoal.Gain('dis','y',0.1);

% 5: Controller gain 这里没有用啊
% Req3 = TuningGoal.Gain('uI','yI',0.5);
% Req4 = TuningGoal.Gain('xp','yf',0.5);

%% Tuning
AllReqs = [TrackReq, MarginReq1, MarginReq2, Req, Req2];
ST1 = systune(ST0,AllReqs);
Try = getIOTransfer(ST1,{'U-ref','V-ref','W-ref','psi-ref'},{'U','V','W','psi'});
Tru = getIOTransfer(ST1,{'U-ref','V-ref','W-ref','psi-ref'},{'u'});
Tdy = getIOTransfer(ST1,{'dis'},{'U','V','W','psi'});
figure
step(Try,10)
Kblock = getBlockValue(ST1);
KI = Kblock.KI.d;
KF = Kblock.KF.d;

disp('---------------------------------------------------------------------------------------------')
disp('The controller KxT = [KI KF] is tuned as:')
KxT = [KI KF]


disp('---------------------------------------------------------------------------------------------')
disp('H-infinity norms are as follows:')
H_ru = hinfnorm(Tru)
H_ry = hinfnorm(Try)
H_dy = hinfnorm(Tdy)


disp('---------------------------------------------------------------------------------------------')
disp('Controller gain norm(KxT,2) is:')
nKxT = norm(KxT,2)

figure
subplot(1,2,1)
omega = logspace(-2,2,100);
sig = f_sigma(omega,Tdy);
loglog(omega,sig)
xlabel('Frequency/(rad/s)')
ylabel('Singular value plot of T_{dy}')

subplot(1,2,2)
omega = logspace(-2,2,100);
sig = f_sigma(omega,Tru);
loglog(omega,sig)
xlabel('Frequency/(rad/s)')
ylabel('Singular value plot of T_{ru}')


disp('---------------------------------------------------------------------------------------------')
disp('Figure 1: Control block')
disp('Figure 2: Step response of closed-loop system')
disp('Figure 3: Singular value plots of T_dy and T_ru')

disp('---------------------------------------------------------------------------------------------')
disp('Validation from simulation')
sim('DF_Hinf_tuning.slx');
g_plot_results;

disp('Figure 4: Mismatched disturbance from external forces and moments')
disp('Figure 5: System outputs for step-tracking commands under mismatched disturbance')
disp('Figure 6: Control inputs for step-tracking commands under mismatched disturbance')