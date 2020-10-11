close all
clc
load('trim1226_7.mat');

disp('----------* Robust H-infinity synthesis for baseline controller with fixed parameter *----------')

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
% mΪϵͳ����������ο����������,nΪϵͳ���������npΪϵͳ״̬������������
%������ m = n
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

% 5: Controller gain ����û���ð�
% Req3 = TuningGoal.Gain('uI','yI',0.5);
% Req4 = TuningGoal.Gain('xp','yf',0.5);

%% Tuning
AllReqs = [TrackReq, MarginReq1, MarginReq2, Req, Req2];
ST1 = systune(ST0,AllReqs);
Try = getIOTransfer(ST1,{'U-ref','V-ref','W-ref','psi-ref'},{'U','V','W','psi'});
Tru = getIOTransfer(ST1,{'U-ref','V-ref','W-ref','psi-ref'},{'u'});
Tdy = getIOTransfer(ST1,{'dis'},{'U','V','W','psi'});

figure(1)
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

figure(2)
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

figure(3)
omega = logspace(-2,2,100);
sig = f_sigma(omega,Try);
loglog(omega,sig)
xlabel('Frequency/(rad/s)')
ylabel('Singular value plot of T_{ry}')

disp('---------------------------------------------------------------------------------------------')
disp('Figure 1: Step response of closed-loop system')
disp('Figure 2: Singular value plots of T_dy and T_ru')
disp('Figure 3: Singular value plots of T_ry')
