function ctrl = powerWarnFun(data, ctrl)
%   Determines turbine state based on 1-second average generator power

%   state key:
%   operate: 0
%   warning: 1
%   fault:   2
    
    if data.savgP > 1.50
        ctrl.power.state = 2;
        disp('overpower fault')
    elseif data.savgP > 1.25
        ctrl.power.state = 1;
        disp('overpower warning')
    else
        ctrl.power.state = 0;
    end
end

