%% Add path to
thispath = pwd;
cd 'C:\Programs\Dev\MVDAS_Toolbox\Working\'
setpath;
cd 'C:\Programs\Dev\FCGI_Toolbox\Working\'
setpath;
cd(thispath);

%% Load test data
test_file_path = 'G:\NWTC Research Battery\Commissioning\20200605_Udq_steps_USF\PQ_F17\2020_06_09_15_14_26_PQ_F17_LVRTq20perc_P0_Q0.tdms';
test_file_path = '2020_06_09_13_43_49_PQ_F17_LVRTd20perc_P0_Q0.tdms';
[t, U3, Cur3] = load_vi_data(test_file_path,'');


%% Simulation parameters
Ts = 10e-6;
measU3.time = t';
measU3.signals.values= U3';
measU3.signals.dimensions=3;
set_param('BESS_Validation/FC_BESS', 'cc_kp', '-1');
set_param('BESS_Validation/FC_BESS', 'cc_Ti', '-1');
set_param('BESS_Validation/FC_BESS', 'pll_kp', '-1');
set_param('BESS_Validation/FC_BESS', 'pll_ki', '-1');

%% Run simulation
tic;
run('BESS_Validation');

%% Process results
F1 = 59.9981;
tic

% process simulation results
tsim = out.ScopeDataCGI.time';
Usim = out.ScopeDataCGI.signals(1).values';
Isim = -out.ScopeDataCGI.signals(2).values';
theta = 2*pi*F1*tsim;
udq_sim = abc2dq(theta,Usim,Ts);
idq_sim = abc2dq(theta,Isim,Ts);
udq_sim = udq_sim.dq(1,:) + 1i*udq_sim.dq(2,:);
idq_sim = idq_sim.dq(1,:) + 1i*idq_sim.dq(2,:);
udq_sim = udq_sim*exp(-1i*a0);
idq_sim = idq_sim*exp(-1i*a0);

% process reference data
if ~exist('ref_processed', 'var')
theta = 2*pi*F1*tsim;
U3i = interp1(t, U3', tsim)';
Cur3i = interp1(t, Cur3', tsim)';
udq_ref = abc2dq(theta,U3i,Ts);
idq_ref = abc2dq(theta,Cur3i,Ts);
udq_ref = udq_ref.dq(1,:) + 1i*udq_ref.dq(2,:);
idq_ref = idq_ref.dq(1,:) + 1i*idq_ref.dq(2,:);
a0 = mean(angle(udq_ref(1:50e3)));
udq_ref = udq_ref*exp(-1i*a0);
idq_ref = idq_ref*exp(-1i*a0);
ref_processed = 1;
end;

toc;

%% Calculate error
err = abs(idq_sim-idq_ref).^2;
err(isnan(err))=[];
err_tot = sum(err);

%% Plotting results
figure;
ax(1)=subplot(411); plot(tsim,[real(udq_ref); real(udq_sim)]);
ax(2)=subplot(412); plot(tsim,[imag(udq_ref); imag(udq_sim)]);
ax(3)=subplot(413); plot(tsim,[real(idq_ref); real(idq_sim)]);
ax(4)=subplot(414); plot(tsim,[imag(idq_ref); imag(idq_sim)]);
linkaxes(ax,'x');
%%
figure;
ax(1)=subplot(411); plot(tsim,[U3i(1,:); Usim(1,:)]);
ax(2)=subplot(412); plot(tsim,[Cur3i(1,:); Isim(1,:)]);
ax(3)=subplot(413); plot(tsim,[Cur3i(2,:); Isim(2,:)]);
ax(4)=subplot(414); plot(tsim,[Cur3i(3,:); Isim(3,:)]);
linkaxes(ax,'x');