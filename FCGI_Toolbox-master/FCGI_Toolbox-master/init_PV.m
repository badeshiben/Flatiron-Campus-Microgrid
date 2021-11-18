if (strcmp(EnArray,'on'))
    set_param([gcb '/PV_Array'],'BlockChoice','FS_Array')
else
    set_param([gcb '/PV_Array'],'BlockChoice','No_Array')
end

%% Set deafualt inverter tuning parameters
% Inverter current controller
if cc_kp<0
    cc_kp = 0.4;
end
if cc_Ti<0
    cc_Ti = 0.02;
end
% Inverter PLL tuning controller
if pll_kp<0
    pll_kp = 71;
end
if pll_ki<0
    pll_ki = 270;
end

Ts_Control = 10*Ts;