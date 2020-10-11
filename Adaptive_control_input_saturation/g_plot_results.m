disp('----------------------* Figure 4: Matched disturbance  *------------------------')
figure(4)
subplot(4,1,1)
plot(t,ud(:,1))
ylabel('ud(1)')

subplot(4,1,2)
plot(t,ud(:,2))
ylabel('ud(2)')

subplot(4,1,3)
plot(t,ud(:,3))
ylabel('ud(3)')

subplot(4,1,4)
plot(t,ud(:,4))
ylabel('ud(4)')

xlabel('Time/(s)');

disp('----------------------* Figure 5: Mismatched disturbance  *------------------------')
figure(5)
subplot(2,1,1)
plot(t,wd(:,1), t,wd(:,2), t,wd(:,3))
legend('d_{U}', 'd_{V}', 'd_{W}')
ylabel('Mismatched disturbance')

subplot(2,1,2)
plot(t,wd(:,4), t,wd(:,5), t,wd(:,6))
legend('d_{p}', 'd_{q}', 'd_{r}')
ylabel('Mismatched disturbance')
xlabel('Time/(s)');

disp('----------------------* Figure 6: System output response of reference tracking for Adaptvie control and MARC-LQR control  *------------------------')
figure(6) 
subplot(4,1,1)
plot(t,y(:,1),'b', t,ref(:,1),'r--')
ylabel('U/(m/s)')
legend('MARC-Hinf','Reference');

subplot(4,1,2)
plot(t,y(:,2),'b', t,ref(:,2),'r--')
ylabel('V/(m/s)')
legend('MARC-Hinf','Reference');

subplot(4,1,3)
plot(t,y(:,3),'b', t,ref(:,3),'r--')
ylabel('W/(m/s)')
legend('MARC-Hinf','Reference');

subplot(4,1,4)
plot(t,y(:,4),'b', t,ref(:,4),'r--')
ylabel('\psi/(rad)')
legend('MARC-Hinf','Reference');
xlabel('Time/(s)');

disp('----------------------* Figure 7: Control input response of reference tracking for Adaptvie control and MARC-LQR control  *------------------------')
figure(7) 
subplot(4,1,1)
plot(t,u(:,1),'b')
ylabel('u_{col}/(m/s)')
legend('MARC-Hinf');

subplot(4,1,2)
plot(t,u(:,2),'b')
ylabel('u_{lat}/(m/s)')
legend('MARC-Hinf');

subplot(4,1,3)
plot(t,u(:,3),'b')
ylabel('u_{lon}/(m/s)')
legend('MARC-Hinf');

subplot(4,1,4)
plot(t,u(:,4),'b')
ylabel('u_{ped}/(m/s)')
legend('MARC-Hinf');
xlabel('Time/(s)');