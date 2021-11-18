%Turbine data
% Import the data from Excel for a Cp lookup table
cp_data = xlsread('CART3 Cp TSR pitch table.xls','Sheet1');
% Row indices for lookup table
breakpoints1 = cp_data(2:end,1)';
% Column indices for lookup table
breakpoints2 = cp_data(1,2:end);
% Output values for lookup table
cp_table_data = cp_data(2:end,2:end);

oversize = 1.2; %generator oversize
Ts_APC = 0.01;

FilterSetup


% fault adaptive controller initialization

% initialize data structure
data.savgP   = 0;
data.genTemp = 0;
data.dwHSS   = 0;
data.dT      = 0;
% data.ax      = 0;


% initialize ctrl structure
% constants
ctrl            = struct();
ctrl.mode       = [0 0 0 0 0 0];  %0 if off, 1 if on. All zeros = normal operation. [WNA WRP WS NS OLNS ES]
ctrl.modeValue  = 0;  %value of binary ctrl.mode
ctrl.FTC        = 0;  %TURNS FTC ON/OFF

% variables
ctrl.RP_prev                = 0; %previous timestep WRP
ctrl.T                      = 1; %torque command [pu]
ctrl.Tfuture                = 1; %predicted torque when timer hits zero
ctrl.genTemp.state          = 0; %sensor states, 0=nominal
ctrl.power.state            = 0;
ctrl.freqSensor.state       = 0;
ctrl.torqueSensor.state     = 0;
% ctrl.ax.state               = 0;
ctrl.step                   = 0;
ctrl.reduction              = 0; %1 if torque was ever reduced

% initialize faulty structure
faulty.genTemp.checkFun      = 'genTempWarnFun';
faulty.genTemp.type          = 'RP';
faulty.genTemp.shutdown      = 'NS';

faulty.power.checkFun        = 'powerWarnFun';
faulty.power.type            = 'RP';
faulty.power.shutdown        = 'ES';

% faulty.ax.checkFun           = 'axWarnFun';
% faulty.ax.type               = 'S';
% faulty.ax.shutdown           = 'NS';

faulty.freqSensor.checkFun   = 'freqSensorWarnFun';
faulty.freqSensor.type       = 'S';
faulty.freqSensor.shutdown   = 'NS';

faulty.torqueSensor.checkFun = 'torqueSensorWarnFun';
faulty.torqueSensor.type     = 'NA';
faulty.torqueSensor.shutdown = 'NS';

% initialize timer structures
% timers for modes
timer.tmax = 10; %WRP default
timer.TRP  = timer.tmax;
timer.TS   = 0;
timer.TNA  = 0;

% initialize simulink buses (correspond to MATLAB structs)
bus1        = Simulink.Bus.createObject(timer);
bus2        = Simulink.Bus.createObject(ctrl);
bus3        = Simulink.Bus.createObject(data);
timerBus    = slBus1;
ctrlBus     = slBus2;
dataBus     = slBus3;