function [delta_Vm, delta_m, delta_n, delta_h] = derivatives(I_ion, alpha_m, alpha_n, alpha_h, ...
    m, n, h, beta_m, beta_n, beta_h)

    % load variables needed 
    load constants.mat
    
    % calculate derivatives
    delta_Vm = I_ion/Cm;
    delta_m = alpha_m*(1-m)-beta_m*m;
    delta_n = alpha_n*(1-n)-beta_n*n;
    delta_h = alpha_h*(1-h)-beta_h*h;
end