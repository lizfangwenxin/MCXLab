% Main 
clear
close all


tic

%% ==== Variables ====
SD = 20; % sender to detector distances, in mm
SDs = [10, 20, 30, 40];
hbt = 0.05; % total hemoglobin concentration, in mM
hbts = [5e-4,5e-3, 0.05, 0.5, 5];
% For two-layer model
L1 = 20; % first layer thickness, in mm
L1s = [20, 30, 40];
oxy_sim_all = [0.2 0.4 0.6 0.8 1]; % multiple oxygen levels

%% ==== Examples ====
% One layer example
%one_layer(hbt,SD, oxy_sim_all)
% Two layer example
%two_layer(hbt, SD, L1, oxy_sim_all)

%% ==== Figure 4 ====
% one-layer model example, multi-SD results
t=tiledlayout(2,2);
for i = 1:length(SDs)
    sd = SDs(i);
    nexttile;
    one_layer(hbt,sd, oxy_sim_all)
end
lgd=legend('Measured', 'Direct', 'Analytical');
lgd.Layout.Tile = 'north';

%% ==== Figure 6 ====
% two-layer model example, multi-thickness results
t=tiledlayout(2,3);
for i = 1:length(L1s)
    L1 = L1s(i);
    nexttile;
    two_layer(hbt, SD, L1, oxy_sim_all)
end

