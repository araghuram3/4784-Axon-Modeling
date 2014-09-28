function [alpha_m, alpha_n, alpha_h, beta_m, beta_n, beta_h] = ...
    gateVariables(Vm)
% Calculates the gate variables given Vm

    alpha_m = 0.1*((25-Vm)/(exp((25-Vm)/10) - 1));
    beta_m = 4*exp(-Vm/18);
    alpha_n = .01 * ((10-Vm)/(exp((10-Vm)/10) - 1));
    beta_n = .125*exp(-Vm/80);
    alpha_h = .07*exp(-Vm/20);
    beta_h = 1/(exp((30-Vm)/10) + 1);

end