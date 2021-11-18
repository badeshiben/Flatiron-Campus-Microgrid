function err_tot = tune_iter(x)
tic
set_param('PV_validation/FC_PV_FirstSolar', 'cc_kp', num2str(x(1)));
set_param('PV_validation/FC_PV_FirstSolar', 'cc_Ti', num2str(x(2)));
set_param('PV_validation/FC_PV_FirstSolar', 'pll_kp', num2str(x(3)));
set_param('PV_validation/FC_PV_FirstSolar', 'pll_ki', num2str(x(4)));

%% Run simulation
out = sim('PV_validation');

%% Process results
F1 = 59.9981;

% process simulation results
tsim = out.ScopeDataCGI.time';
Ts = tsim(2)-tsim(1);
Usim = out.ScopeDataCGI.signals(1).values';
Isim = -out.ScopeDataCGI.signals(2).values';
theta = 2*pi*F1*tsim;


% process reference data
if ~evalin('base', 'exist(''ref_processed'',''var'')')
    t = evalin('base', 't');
    U3i = interp1(t, evalin('base','U3'''), tsim)';
    Cur3i = interp1(t, evalin('base','Cur3'''), tsim)';
    udq_ref = abc2dq(theta,U3i,Ts);
    idq_ref = abc2dq(theta,Cur3i,Ts);
    udq_ref = udq_ref.dq(1,:) + 1i*udq_ref.dq(2,:);
    idq_ref = idq_ref.dq(1,:) + 1i*idq_ref.dq(2,:);
    a0 = mean(angle(udq_ref(1:round(1/Ts))));
    udq_ref = udq_ref*exp(-1i*a0);
    idq_ref = idq_ref*exp(-1i*a0);
    assignin('base', 'a0', a0 );
    assignin('base', 'udq_ref', udq_ref);
    assignin('base', 'idq_ref', idq_ref);
    assignin('base', 'ref_processed',1);
end
udq_ref = evalin('base', 'udq_ref');
idq_ref = evalin('base', 'idq_ref');
a0 = evalin('base', 'a0');
udq_sim = abc2dq(theta,Usim,Ts);
idq_sim = abc2dq(theta,Isim,Ts);
udq_sim = udq_sim.dq(1,:) + 1i*udq_sim.dq(2,:);
idq_sim = idq_sim.dq(1,:) + 1i*idq_sim.dq(2,:);
udq_sim = udq_sim*exp(-1i*a0);
idq_sim = idq_sim*exp(-1i*a0);

%% Calculate error
err = abs(idq_sim(tsim>1.5)-idq_ref(tsim>1.5)).^4;
err(isnan(err))=[];
err_tot = sum(err);


%% Plotting results
figure(1);
ax(1)=subplot(411); plot(tsim,[real(udq_ref); real(udq_sim)]);
ax(2)=subplot(412); plot(tsim,[imag(udq_ref); imag(udq_sim)]);
ax(3)=subplot(413); plot(tsim,[real(idq_ref); real(idq_sim)]);
ax(4)=subplot(414); plot(tsim,[imag(idq_ref); imag(idq_sim)]);
linkaxes(ax,'x');
xlim([5.47 5.55]);

%%
% figure(2);
% ax(1)=subplot(411); plot(tsim,[U3i(1,:); Usim(1,:)]);
% ax(2)=subplot(412); plot(tsim,[Cur3i(1,:); Isim(1,:)]);
% ax(3)=subplot(413); plot(tsim,[Cur3i(2,:); Isim(2,:)]);
% ax(4)=subplot(414); plot(tsim,[Cur3i(3,:); Isim(3,:)]);
% linkaxes(ax,'x');
% xlim([2 2.15]);
end