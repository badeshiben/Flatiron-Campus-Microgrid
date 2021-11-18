clear all;
close all;

%% Add path to
thispath = pwd;
cd 'C:\Programs\Dev\MVDAS_Toolbox\Working\'
setpath;
cd 'C:\Programs\Dev\FCGI_Toolbox\Working\'
setpath;
cd(thispath);

%% Load test data
test_file_path = 'G:\NWTC Research Battery\Commissioning\20200605_Udq_steps_USF\PQ_F17\2020_06_09_15_14_26_PQ_F17_LVRTq20perc_P0_Q0.tdms';
%test_file_path = '2020_06_09_13_33_45_PQ_F17_LVRTd1perc_P0_Q0.tdms';
%test_file_path = '2020_06_09_13_37_52_PQ_F17_LVRTd2perc_P0_Q0.tdms';
%test_file_path = '2020_06_09_13_38_13_PQ_F17_LVRTd3perc_P0_Q0.tdms';
%test_file_path = '2020_06_09_13_38_48_PQ_F17_LVRTd5perc_P0_Q0.tdms';
%test_file_path = '2020_06_09_13_39_47_PQ_F17_LVRTd10perc_P0_Q0.tdms';
%test_file_path = '2020_06_09_13_43_49_PQ_F17_LVRTd20perc_P0_Q0.tdms';
%test_file_path = '2020_06_09_13_45_02_PQ_F17_LVRTd30perc_P0_Q0.tdms';
%test_file_path = '2020_06_09_13_46_35_PQ_F17_LVRTd40perc_P0_Q0.tdms';
%test_file_path = '2020_06_09_13_50_34_PQ_F17_LVRTd50perc_P0_Q0.tdms';

%test_file_path = '2020_06_09_15_11_21_PQ_F17_LVRTq1perc_P0_Q0.tdms';
%test_file_path = '2020_06_09_15_11_47_PQ_F17_LVRTq2perc_P0_Q0.tdms';
%test_file_path = '2020_06_09_15_12_25_PQ_F17_LVRTq3perc_P0_Q0.tdms';
%test_file_path = '2020_06_09_15_12_57_PQ_F17_LVRTq5perc_P0_Q0.tdms';
%test_file_path = '2020_06_09_15_13_22_PQ_F17_LVRTq10perc_P0_Q0.tdms';
%test_file_path = '2020_06_09_15_13_53_PQ_F17_LVRTq15perc_P0_Q0.tdms';
%test_file_path = '2020_06_09_15_14_26_PQ_F17_LVRTq20perc_P0_Q0.tdms';
%test_file_path = '2020_06_09_15_15_16_PQ_F17_LVRTq30perc_P0_Q0.tdms';
%test_file_path = '2020_06_09_15_15_49_PQ_F17_LVRTq40perc_P0_Q0.tdms';
%test_file_path = '2020_06_09_15_16_21_PQ_F17_LVRTq50perc_P0_Q0.tdms';

test_file_path = '2020_07_28_16_28_01_PQ_F17_VQFsteps_5perc_GFL_P0_Q0_NoDroop.tdms';
%test_file_path = '2020_07_28_16_40_01_PQ_F17_VQFsteps_5perc_GFL_P500_Q0.tdms';
%test_file_path = '2020_07_28_16_41_16_PQ_F17_VQFsteps_5perc_GFL_P0_Q500.tdms';
%test_file_path = '2020_07_28_16_40_40_PQ_F17_VQFsteps_5perc_GFL_P500_Q500.tdms';
%test_file_path = '2020_07_28_16_45_54_PQ_F17_VQFsteps_1perc_GFL_P0_Q0_NoDroop.tdms';
%test_file_path = '2020_07_28_16_46_51_PQ_F17_VQFsteps_1perc_GFL_P500_Q0_NoDroop.tdms';
%test_file_path = '2020_07_28_16_45_54_PQ_F17_VQFsteps_1perc_GFL_P0_Q0_NoDroop.tdms';
%test_file_path = '2020_07_28_16_45_54_PQ_F17_VQFsteps_1perc_GFL_P0_Q0_NoDroop.tdms';

test_file_path = '2020_08_03_14_27_41_PQ_F18_VQFsteps_5perc_Curt_200kW.tdms';


[t, U3, Cur3] = load_vi_data(test_file_path,'');


%% Simulation parameters
Ts = 10e-6;
measU3.time = t';
measU3.signals.values= U3';
measU3.signals.dimensions=3;

%% Run simulation once with initial parameters
cc_kp_init = 0.0311;
cc_Ti_init = 0.2532;
pll_kp_init = 70.9991 ;
pll_ki_init = 270.2331;

%tune_iter([cc_kp_init cc_Ti_init pll_kp_init pll_ki_init]);

options = optimset('Display','iter','MaxIter', 300, 'MaxFunEvals', 500, 'TolX',0.01);
fun = @(x)tune_iter_GFL(x);
xfind_a = fminsearch(fun, [cc_kp_init cc_Ti_init pll_kp_init pll_ki_init], options);
