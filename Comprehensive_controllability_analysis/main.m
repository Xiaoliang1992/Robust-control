%能控性分析，这里包含了系统增益曲线与扰动分析

close all
clc
load('trim1226_7.mat');


disp('----------* Comprehensive controllability analysis with non-matched uncertainties *----------')
[Aa,Ba] = f_AB_filter(Aa,Ba);
A = Aa;
B = Ba;
C = eye(9);
D = zeros(9,4);
Bw = eye(9);
Cw = eye(9);
Dw = zeros(9,9);
G = ss(A,B,C,D);
Gd = ss(A,Bw,Cw,Dw);
disp('---------------------------------------------------------------------------------------------')
disp('Nominal system:')
G

disp('---------------------------------------------------------------------------------------------')
disp('Disturbance system:')
Gd

omega = logspace(-2,0,100);
[omega, res, ~, ~] = f_controllability_analysis_m(G,omega);
[~, resd, ~, ~] = f_controllability_analysis_m(Gd,omega);
res1 = res([1:3 9],:);
resd1 = resd([1:3 9],:);
num = res1./resd1;
disp('---------------------------------------------------------------------------------------------')
disp('Maximun disturbance tolerance:')
num = min(min(num))
grid on

omega = logspace(-2,2,100);
[omega, res, condition_num, rga] = f_controllability_analysis_m(G,omega);
[omegad, resd, condition_numd, rgad] = f_controllability_analysis_m(Gd,omega);
% 


disp('---------------------------------------------------------------------------------------------')
disp('Figure 1: Comprehensive controllability gain of each state')
subplot(1,3,1)
loglog(omega, res(1,:)',omega, res(2,:)','--',omega, res(3,:)','k-.')
legend('U','V','W')
xlabel('Frequency/(rad/s)')
ylabel('Magnitude')
grid on

subplot(1,3,2)
loglog(omega, res(4,:)',omega, res(5,:)','--',omega, res(6,:)','k-.')
legend('p','q','r')
xlabel('Frequency/(rad/s)')
ylabel('Magnitude')
grid on

subplot(1,3,3)
loglog(omega, res(7,:)',omega, res(8,:)','--',omega, res(9,:)','k-.')
legend('\phi','\theta','\psi')
xlabel('Frequency/(rad/s)')
ylabel('Magnitude')
grid on
resd = num*resd;


figure
disp('Figure 2: Comprehensive controllability gain with maximum tolerant non-matched disturbance')
res1 = res([1:3 9],:);
resd1 = resd([1:3 9],:);

hold on 

subplot(2,2,1)
loglog(omega, res1(1,:)',omega, resd1(1,:)','r--')
xlabel('Frequency/(rad/s)')
ylabel('Magnitude')
legend('U','U_{d}')
grid on

subplot(2,2,2)
loglog(omega, res1(2,:)',omega, resd1(2,:)','r--')
xlabel('Frequency/(rad/s)')
ylabel('Magnitude')
legend('V','V_{d}')
grid on

subplot(2,2,3)
loglog(omega, res1(3,:)',omega, resd1(3,:)','r--')
xlabel('Frequency/(rad/s)')
ylabel('Magnitude')
legend('W','W_{d}')
grid on

subplot(2,2,4)
loglog(omega, res1(4,:)',omega, resd1(4,:)','r--')
xlabel('Frequency/(rad/s)')
ylabel('Magnitude')
legend('\psi','\psi_{d}')
grid on