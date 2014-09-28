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

%% currents %%
I_Na = m^3*g_Na*h*(Vm-E_Na);
I_K = n^4*g_K*(Vm-E_K);
I_L = g_L*(Vm-E_L);
I_ion = I - I_K - I_Na - I_L;

%% run simulation
