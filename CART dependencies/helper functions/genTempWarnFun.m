function ctrl = genTempWarnFun(data, ctrl, ~)
%   Determines turbine state based on gearbox oil temp
%   operate: 0
%   warning: 1
%   fault:   2
    
    if data.genTemp > 130
        ctrl.genTemp.state = 2;
        disp('GT fault')
    elseif data.genTemp > 120
        ctrl.genTemp.state = 1;
        disp('GT warning')
    else
        ctrl.genTemp.state = 0;
    end
end

