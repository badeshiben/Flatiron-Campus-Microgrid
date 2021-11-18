function timer = maxTDRPTimers(ctrl, fault, timer, faultName)
%   set all other TDRP timers to max

    fields = fieldnames(fault);
    timer.TRP = inf;
    for i=1:length(fields)  
        if strcmp(fault.(fields{i}).type, 'RP') && ~(strcmp(faultName, fields{i})) %for all other TDRP faults
            timer.(fields{i}) = ctrl.timerMax; %set timers to max
        end
    end