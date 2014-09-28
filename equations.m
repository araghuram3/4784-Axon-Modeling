%%%%%% This is a first trial to get a hang of what is happening %%%%%%%%
function equations(Vm)

%% load constant values %%
load constants.mat

%% listing out equations %%
% inital gate Variables 
[alpha_m, alpha_n, alpha_h, beta_m, beta_n, beta_h] = ...
    gateVariables(Vm);

% initialize gate constants
m = alpha_m/(alpha_m+beta_m);
n = alpha_n/(alpha_n+beta_n);
h = alpha_h/(alpha_h+beta_h);

%% for loop simulation: set timestep in milliseconds (need 100 runs) %%
for t = 1:100
    %% currents %%
    I_Na = m^3*g_bar_Na*h*(Vm-E_Na);
    I_K = n^4*g_bar_K*(Vm-E_K);
    I_L = g_bar_L*(Vm-E_L);
    I_ion = I - I_K - I_Na - I_L;
    
    %% calculate conductances %% 
    g_K = g_bar_K*n^4;
    g_Na = (m^3)*t*g_bar_Na; 
    
    %% plot values %%
    subplot(2,2,1)
    plot(t, Vm)
    xlabel('time (ms)')
    ylabel('Vm (mV)')
    hold on
    subplot(2,2,2)
    plot(t,I_ion)
    xlabel('time (ms)')
    ylabel('I_ion (microA)')
    hold on
    subplot(2,2,3)
    plot(t,g_K)
    xlabel('time (ms)')
    ylabel('g_K (S/cm^2)')
    hold on
    subplot(2,2,4)
    plot(t,g_Na)
    xlabel('time (ms)')
    ylabel('g_Na (S/cm^2)')
    hold on

    %% calculate derivatives %%
    [delta_Vm, delta_m, delta_n, delta_h] = derivatives(I_ion, alpha_m, alpha_n, alpha_h, ...
        m, n, h, beta_m, beta_n, beta_h);

    %% euler formula to update values with derivatives %%
    Vm = Vm + t*delta_Vm;
    m = m + t*delta_m;
    n = n + t*delta_n;
    h = h + t*delta_h;
end