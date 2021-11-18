function ctrl = freqSensorWarnFun(data, ctrl)
%   Determines turbine state based on difference between generator and HSS
%   frequency

%   state key:
%   operate: 0
%   warning: 1
%   fault:   2

    if abs(data.dwHSS) > 0.1
        ctrl.freqSensor.state = 2;
        disp('freqSensor fault')
    elseif abs(data.dwHSS) > 0.08
        ctrl.freqSensor.state = 1;
        disp('freqSensor warning')
    else
        ctrl.freqSensor.state = 0;
    end
    % OLD IMPLEMENTATION WITH WG INPUT
%     wg = 377; %for debug
%     if abs((wg-data.wHSS)/data.wHSS) > 0.2
%         ctrl.freqSensor.state = 2;
%         disp('freqSensor fault')
%     elseif abs((wg-data.wHSS)/data.wHSS) > 0.1
%         ctrl.freqSensor.state = 1;
%         disp('freqSensor warning')
%     else
%         ctrl.freqSensor.state = 0;
%     end
end