% clear
g_Hinf_design;
disp('------------------------------* MRAC-LQR design *------------------------------')
load('trim1226_7.mat');
Ap = Aa;
Bp = Ba;
Cp = [1 0 0 0 0 0 0 0 0; 
      0 1 0 0 0 0 0 0 0;
      0 0 1 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0 1];
  
np = size(Ap,1);
n = size(Cp,1);
m = size(Bp,2);
Dp = zeros(n,m);
Gp = ss(Ap, Bp, Cp, Dp);
Csel = [zeros(np,n) eye(np)];
Aa = [zeros(n,n) Cp;zeros(np,n) Ap];
Ba = [Dp;Bp];
Bref = [-eye(n);zeros(np,n)];
Ca = [zeros(n,n) Cp];

Q = diag([10 10 10 10 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1])*0.5;%np + n
R = diag([10 10 10 10]);% n x n
P = are(Aa, Ba*R^(-1)*Ba',Q);

%Hinf?
disp('------------------------------* KxT gain tuned by LQR  *------------------------------')
% KxT = R^(-1)*Ba'*P

Aref = Aa - Ba*KxT;
Cref = Ca;
Dref = zeros(n,m);
disp('------------------------------* MRAC design  *------------------------------')
Q0 = diag([1 1 1 1 1 1 1 1 1 1 1 1 1])*80;%%
v = 0.1;
Qv = Q0 +(v+1)/v*eye(np+n);
Rv = v/(v+1)*eye(np+n);
Pv = are(Aref',inv(Rv), Qv)
Lv = Pv*inv(Rv)
% Q0 = diag([1 1 1 1 1 1 1 1 1 1 1 1 1])*100;%%
% Rv =eye(np+n)*10;
% Pv = are(Aref',Rv, Q0)
% Lv = Pv*inv(Rv)*0
% Gref = ss(Aref,Bref,Cref,Dref);
% step(Gref,10)
% % 
% THETA0 = [4*Ap(2,2) 2*Ap(2,3) 2*Ap(2,4); 4*Ap(2,1) 2*Ap(3,3) 2*Ap(3,4)]'
DA = 0.75*eye(n);
% Gama_u = 800
% 
Gama_theta_ = eye(13)*5; % np+n
if_sat_modification = 1;