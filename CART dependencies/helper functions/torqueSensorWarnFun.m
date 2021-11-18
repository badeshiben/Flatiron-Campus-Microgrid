function ctrl = torqueSensorWarnFun(data, ctrl)
%   Determines turbine state based on difference between HSS and
%   LSS torque.

%   state key:
%   operate: 0
%   warning: 1
%   fault:   2

    if abs(data.dT) > 0.4
        ctrl.torqueSensor.state = 2;
        disp('torqueSensor fault')
    elseif abs(data.dT) > 0.3
        ctrl.torqueSensor.state = 1;
        disp('torqueSensor warning')
    else
        ctrl.torqueSensor.state = 0;
    end
end