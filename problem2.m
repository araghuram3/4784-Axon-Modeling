%%%%%% Problem 2: Step Current Stimulation %%%%%%%%

%% initialize constant values %%
g_bar_K = 36;
g_bar_Na = 120;
g_bar_L = 0.3;
E_K = -12; 
E_Na = 115;
E_L = 10.6;
Vm = 0;
V_rest = -70;
C_m = 1.0;
I = 0;

%% inital gate Variables %%
alpha_m = 0.1*((25-Vm)/(exp((25-Vm)/10) - 1));
beta_m = 4*exp(-Vm/18);
alpha_n = .01 * ((10-Vm)/(exp((10-Vm)/10) - 1));
beta_n = .125*exp(-Vm/80);
alpha_h = .07*exp(-Vm/20);
beta_h = 1/(exp((30-Vm)/10) + 1);

%% initialize gate constants in vector %% 
m(1) = alpha_m/(alpha_m+beta_m);
n(1) = alpha_n/(alpha_n+beta_n);
h(1) = alpha_h/(alpha_h+beta_h);

%% set up time and start loop %% 
t = 0:.01:100;
for step = 1:length(t)-1
    %% calculate gate variables %%
    alpha_m(step) = 0.1*((25-Vm(step))/(exp((25-Vm(step))/10) - 1));
    beta_m(step) = 4*exp(-Vm(step)/18);
    alpha_n(step) = .01 * ((10-Vm(step))/(exp((10-Vm(step))/10) - 1));
    beta_n(step) = .125*exp(-Vm(step)/80);
    alpha_h(step) = .07*exp(-Vm(step)/20);
    beta_h(step) = 1/(exp((30-Vm(step))/10) + 1);
    
    %% calculate currents %%
    I_Na = (m(step)^3)*g_bar_Na*h(step)*(Vm(step)-E_Na);
    I_K = (n(step)^4)*g_bar_K*(Vm(step)-E_K);
    I_L = g_bar_L*(Vm(step)-E_L);
    if step <= 5
        I = 5;
    else
        I = 0;
    end
    I_ion = I - I_K - I_Na - I_L;
    
    %% calculate derivatives %%
    delta_Vm = I_ion/(C_m);
    delta_m = alpha_m(step)*(1-m(step))-beta_m(step)*m(step);
    delta_n = alpha_n(step)*(1-n(step))-beta_n(step)*n(step);
    delta_h = alpha_h(step)*(1-h(step))-beta_h(step)*h(step);

    %% euler formula to update values with derivatives %%
    Vm(step + 1) = Vm(step) + .01*delta_Vm;
    m(step + 1) = m(step) + .01*delta_m;
    n(step + 1) = n(step) + .01*delta_n;
    h(step + 1) = h(step) + .01*delta_h;
    
end

%% Use actual resting voltage %%
V = Vm + V_rest;


%% conductances %%
g_K = g_bar_K*(n.^4);
g_Na = g_bar_Na*(m.^3).*h;

%% plots %%

    % plot for membrane voltage
    figure
    plot(t,V)
    title('Membrane Voltage Vs. Time')
    xlabel('time (ms)')
    ylabel('Voltage (mV)')
    legend('V_m')
    
    % plot for conducatances 
    figure
    plot(t,g_K,'r',t,g_Na,'b')
    title('Conductances Vs. Time')
    xlabel('time (s)')
    ylabel('g_i (mS/cm^2)')
    legend('g_K','g_N_a')