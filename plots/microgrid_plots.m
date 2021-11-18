% plotting data for microgrid paper
clf
set(groot, 'DefaultLineLineWidth', 1.5)

%% Closed planned transition, grid-island
x = load('closed_planned_wind.mat'); 
cp=x.log;
figure(1)
% plot P, Q
subplot(2, 1, 1)
plot(cp{5}.Values.time, cp{5}.Values.data(:,2)/1e3);
grid on
hold on
plot(cp{5}.Values.time, cp{5}.Values.data(:,1)/1e3);
plot(cp{6}.Values.time, cp{6}.Values.data(:,1)/1e3);
plot(cp{4}.Values.time, cp{4}.Values.data(:,1)/1e3);
plot(cp{7}.Values.time, cp{7}.Values.data(:,2)/1e3);
plot(cp{7}.Values.time, cp{7}.Values.data(:,1)/1e3);
plot(cp{8}.Values.time, cp{8}.Values.data(:,1)/1e3);
ylim([-200 1200])
xlim([30 48])
title('Closed, planned, grid-island transition')
ylabel('Power [kW/kVAR]')
xlabel('')
legend('wind Q','wind P','diesel P','PV P','grid Q', 'grid P', 'loads P');
hold off
% plot frequencies
subplot(2, 1, 2)
xlim([30 48])
yyaxis left
plot(cp{1}.Values, 'linewidth', 1.5)
ylim([56 61])
ylabel('Frequency [Hz]')
grid on
hold on
yyaxis right
ylim([0 1.5])
plot(cp{2}.Values, 'linewidth', 1.5)
ylabel('Voltage [pu]')
title('13.2 kV bus voltage/frequency')
xlabel('Time (s)')
hold off
sgtitle('')

% %% Closed unplanned transition, grid-island
% x = load('closed_unplanned_base.mat'); 
% cuB=x.log;
% x = load('closed_unplanned_IR.mat'); 
% cuIR=x.log;
% figure(2)
% plot P, wind ride through
% subplot(3, 1, 1)
% plot(cuB{5}.Values.time, cuB{5}.Values.data(:,1)/1e3);
% grid on
% hold on
% plot(cuB{6}.Values.time, cuB{6}.Values.data(:,1)/1e3);
% plot(cuB{4}.Values.time, cuB{4}.Values.data(:,1)/1e3);
% plot(cuB{7}.Values.time, cuB{7}.Values.data(:,1)/1e3);
% plot(cuB{8}.Values.time, cuB{8}.Values.data(:,1)/1e3);
% xlim([8 16])
% ylim([-50 1200])
% title('Closed, unplanned, grid-island transition - wind ride through')
% ylabel('Power [kW]')
% xlabel('')
% legend('wind P','diesel P','PV P','grid P', 'loads P');
% hold off
% plot P, wind inertial response
% subplot(3, 1, 2)
% plot(cuIR{5}.Values.time, cuIR{5}.Values.data(:,1)/1e3);
% grid on
% hold on
% plot(cuIR{6}.Values.time, cuIR{6}.Values.data(:,1)/1e3);
% plot(cuIR{4}.Values.time, cuIR{4}.Values.data(:,1)/1e3);
% plot(cuIR{7}.Values.time, cuIR{7}.Values.data(:,1)/1e3);
% plot(cuIR{8}.Values.time, cuIR{8}.Values.data(:,1)/1e3);
% xlim([8 16])
% ylim([-50 1200])
% title('Closed, unplanned, grid-island transition - wind inertial response')
% ylabel('Power [kW]')
% xlabel('')
% legend('wind P','diesel P','PV P','grid P', 'loads P');
% hold off
% plot frequencies
% subplot(3, 1, 3)
% plot(cuB{1}.Values, 'linewidth', 1.5)
% grid on
% hold on
% plot(cuIR{1}.Values, 'linewidth', 1.5)
% xlim([8 16])
% ylim([56 61])
% title('13.2 kV bus frequency')
% xlabel('Time (s)')
% ylabel('Frequency [Hz]')
% legend('ride through', 'inertial response')
% hold off
% sgtitle('')
% 
% %% Closed transition, island-grid
% x = load('island2grid_base.mat'); 
% igB=x.log;
% x = load('island2grid_VR.mat'); 
% igVR=x.log;
% 
% figure(3)
% plot P, wind ride through
% subplot(3, 1, 1)
% plot(igB{5}.Values.time, igB{5}.Values.data(:,2)/1e3);
% grid on
% hold on
% plot(igB{5}.Values.time, igB{5}.Values.data(:,1)/1e3);
% plot(igB{6}.Values.time, igB{6}.Values.data(:,1)/1e3);
% plot(igB{4}.Values.time, igB{4}.Values.data(:,1)/1e3);
% plot(igB{7}.Values.time, igB{7}.Values.data(:,1)/1e3);
% plot(igB{8}.Values.time, igB{8}.Values.data(:,1)/1e3);
% xlim([8 16])
% ylim([-500 1500])
% title('Closed island-grid transition - wind ride through')
% ylabel('Power [kW/kVAR]')
% xlabel('')
% legend('wind Q', 'wind P','diesel P','PV P','grid P', 'loads P');
% hold off
% plot P, wind voltage response
% subplot(3, 1, 2)
% plot(igVR{5}.Values.time, igVR{5}.Values.data(:,2)/1e3);
% grid on
% hold on
% plot(igVR{5}.Values.time, igVR{5}.Values.data(:,1)/1e3);
% plot(igVR{6}.Values.time, igVR{6}.Values.data(:,1)/1e3);
% plot(igVR{4}.Values.time, igVR{4}.Values.data(:,1)/1e3);
% plot(igVR{7}.Values.time, igVR{7}.Values.data(:,1)/1e3);
% plot(igVR{8}.Values.time, igVR{8}.Values.data(:,1)/1e3);
% xlim([8 16])
% ylim([-500 1500])
% title('Closed island-grid transition - wind voltage response')
% ylabel('Power [kW/kVAR]')
% xlabel('')
% legend('wind Q', 'wind P','diesel P','PV P','grid P', 'loads P');
% hold off
% plot voltages
% subplot(3, 1, 3)
% plot(igB{2}.Values*sqrt(3), 'linewidth', 1.5)
% grid on
% hold on
% plot(igVR{2}.Values, 'linewidth', 1.5)
% xlim([8 16])
% ylim([0 1.5])
% title('13.2 kV bus voltage/frequency')
% xlabel('Time (s)')
% ylabel('Voltage [pu]')
% legend('ride through', 'voltage response')
% hold off
% sgtitle('')

% %% Open transition, grid-island
% x = load('open_gen_mc.mat'); 
% open_mc=x.log;
% x = load('open_gen_trip.mat'); 
% open_trip=x.log;
% 
% figure(4)
% % plot MC P
% subplot(3, 1, 1)
% plot(open_mc{5}.Values.time, open_mc{5}.Values.data(:,1)/1e3, 'linewidth', 2);
% grid on
% hold on
% plot(open_mc{6}.Values.time, open_mc{6}.Values.data(:,1)/1e3);
% plot(open_mc{3}.Values.time, open_mc{3}.Values.data(:,1)/1e3, '-.');
% plot(open_mc{4}.Values.time, open_mc{4}.Values.data(:,1)/1e3);
% plot(open_mc{7}.Values.time, open_mc{7}.Values.data(:,1)/1e3,'--');
% plot(open_mc{8}.Values.time, open_mc{8}.Values.data(:,1)/1e3);
% xlim([1 16])
% ylim([-500 2000])
% title('Open, grid-island transition - wind momentary cessation')
% ylabel('Power [kW]')
% xlabel('')
% legend('wind P','diesel P','BESS P','PV P','grid P','loads P');
% hold off
% % plot trip P
% subplot(3, 1, 2)
% plot(open_trip{5}.Values.time, open_trip{5}.Values.data(:,1)/1e3, 'linewidth', 2);
% grid on
% hold on
% plot(open_trip{6}.Values.time, open_trip{6}.Values.data(:,1)/1e3);
% plot(open_trip{3}.Values.time, open_trip{3}.Values.data(:,1)/1e3, '-.');
% plot(open_trip{4}.Values.time, open_trip{4}.Values.data(:,1)/1e3);
% plot(open_trip{7}.Values.time, open_trip{7}.Values.data(:,1)/1e3,'--');
% plot(open_trip{8}.Values.time, open_trip{8}.Values.data(:,1)/1e3);
% xlim([1 16])
% ylim([-500 2000])
% title('Open, grid-island transition - wind trip')
% ylabel('Power [kW]')
% xlabel('')
% legend('wind P','diesel P','BESS P','PV P','grid P','loads P');
% hold off
% % plot frequencies and voltages
% subplot(3, 1, 3)
% yyaxis left
% plot(open_mc{1}.Values)
% hold on
% grid on
% plot(open_trip{1}.Values)
% ylim([56 61])
% ylabel('Frequency [Hz]')
% yyaxis right
% plot(open_mc{2}.Values)
% plot(open_trip{2}.Values)
% ylim([0 1.55])
% ylabel('Voltage [pu]')
% legend('momentary cessation', 'trip')
% xlim([1 16])
% title('13.2 kV bus voltage/frequency')
% xlabel('Time (s)')
% hold off
% sgtitle('')

% %% Voltage fault
% x = load('voltage_fault_base.mat'); 
% volt_base=x.log;
% x = load('voltage_fault_VR.mat'); 
% volt_response=x.log;
% 
% figure(3)
% % plot voltage response to 3 phase faults
% % plot 13.2kv voltage
% subplot(3, 1, 1)
% plot(volt_base{2}.Values, 'linewidth', 1.5)
% grid on
% hold on
% plot(volt_response{2}.Values, 'linewidth', 1.5)
% xlim([9.5 12])
% title('RMS 13.2 kV Bus Voltage')
% xlabel('Time (s)')
% ylabel('Voltage [pu]')
% legend('baseline', 'VR')
% hold off
% sgtitle('')
% % plot 575v voltage
% subplot(3, 1, 2)
% plot(volt_base{9}.Values, 'linewidth', 1.5)
% grid on
% hold on
% plot(volt_response{9}.Values, 'linewidth', 1.5)
% xlim([9.5 12])
% title('RMS 575 V Bus Voltage')
% xlabel('Time (s)')
% ylabel('Voltage [pu]')
% legend('baseline', 'VR')
% hold off
% sgtitle('')
% subplot(3, 1, 3)
% plot(volt_base{5}.Values.time, volt_base{5}.Values.data(:,2)/1e3);
% grid on
% hold on
% plot(volt_response{5}.Values.time, volt_response{5}.Values.data(:,2)/1e3);
% xlim([9.5 12])
% ylim([-250 50])
% title('Reactive Power from CART')
% ylabel('Power [kW/kVAR]')
% xlabel('')
% legend('baseline', 'VR');
% hold off