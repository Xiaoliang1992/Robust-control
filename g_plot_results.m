t = yout.Time;
yo = yout.Data;
uo = uout.Data;
do = dout.Data;
refo = refout.Data;
% close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(4) 
subplot(4,1,1)
plot(t,yo(:,1),'b',t,refo(:,1),'r--')
ylabel('U/(m/s)')
legend('U','U_{ref}');
axis([0 20 0 1.5])

subplot(4,1,2)
plot(t,yo(:,2),'b',t,refo(:,2),'r--')
ylabel('V/(m/s)')
legend('V','V_{ref}');
axis([0 20 0 1.5])

subplot(4,1,3)
plot(t,yo(:,3),'b',t,refo(:,3),'r--')
ylabel('W/(m/s)')
legend('W','W_{ref}');
axis([0 20 0 1.5])

subplot(4,1,4)
plot(t,yo(:,4),'b',t,refo(:,4),'r--')
xlabel('Time/(s)')
ylabel('\phi/(rad)')
legend('\psi','\psi_{ref}');
axis([0 20 0 1.3])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(5)
subplot(4,1,1)
plot(t,uo(:,1),'b')
ylabel('u_{col}')

subplot(4,1,2)
plot(t,uo(:,2),'b')
ylabel('u_{lat}')

subplot(4,1,3)
plot(t,uo(:,3),'b')
ylabel('u_{lon}')

subplot(4,1,4)
plot(t,uo(:,4),'b')
xlabel('Time/(s)')
ylabel('u_{ped}')

figure(6)
subplot(2,1,1)
plot(t,do(:,1),'b',t,do(:,2),'r',t,do(:,3),'g')
legend('d_{U}','d_{V}','d_{W}')
ylabel('Disturbance')

subplot(2,1,2)
plot(t,do(:,4),'b',t,do(:,5),'r',t,do(:,6),'g')
legend('d_{p}','d_{q}','d_{r}')
xlabel('Time/(s)')
ylabel('Disturbance')