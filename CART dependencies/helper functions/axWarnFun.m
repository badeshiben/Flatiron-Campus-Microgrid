function ctrl = axWarnFun(data, ctrl, ~)
%   Determines turbine state based on nacelle x-acceleration

%   state key:
%   operate: 0
%   warning: 1
%   fault:   2
    
    if data.ax > 0.4
        ctrl.ax.state = 2;
        disp('ax fault')
    elseif data.ax > 0.3
        ctrl.ax.state = 1;
        disp('ax warning')
    else
        ctrl.ax.state = 0;
    end
end
