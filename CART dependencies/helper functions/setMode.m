function ctrl = setMode(ctrl, fault, faultName)
%   set the turbine mode based on the command state
    if ctrl.(faultName).state == 2 %if faulted
        if strcmp(fault.(faultName).shutdown, 'ES') %if ES type
            ctrl.mode(6) = 1; %ES mode
        else
            ctrl.mode(4) = 1; %NS mode
        end
    end
    
    switch fault.(faultName).type
        case 'RP'
            if ctrl.(faultName).state == 1 %if warning
                ctrl.mode(2) = 1; %WRP mode
            end
        case 'S'
            if ctrl.(faultName).state == 1 %if warning
                ctrl.mode(3) = 1; %WS mode
            end
        case 'NA'
            if ctrl.(faultName).state == 1
                ctrl.mode(1) = 1; %WNA mode
            end
    end