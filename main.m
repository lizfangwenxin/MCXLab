% Main 
clear
close all


tic

%% ==== Variables ====
SD = 30; % sender to detector distances, in mm
%SDs = [20, 30, 40]
hbt = 0.05; % total hemoglobin concentration, in mM
% For two-layer model
L1 = 40; % first layer thickness, in mm
oxy_sim_all = [0.2 0.4 0.6 0.8 1]; % multiple oxygen levels


%% ==== SD configuration ====
src_rad = 1; % in mm
det_rad = 1; % in mm
dim = [100, 100, 100]; % volume, in mm

L_850_measured(2,5)=0;
L_780_measured(2,5)=0;
src_coor = [50, 45];
det_coor = [50, src_coor(2)+SD];
unit = 1;

% Get coefficients mu_a, mu_a_s and mu_a_d
[mu_a, mu_a_s, mu_a_d] = mu_a_calculation(hbt, oxy_sim_all);


%% ==== MC configuration ====
cfg.nphoton=5e5;
cfg.vol=uint8(ones(100,100,100));
cfg.vol(:,:,10:end)=2;    % add an inclusion
cfg.prop=[0 0 1 1
        mu_a(1,1) 11.1852 0.9 1.4
        mu_a(1,1) 11.1852 0.9 1.4]; % [mua,mus,g,n]
cfg.issrcfrom0=1;
cfg.srcpos=[30 30 1];
cfg.srcdir=[0 0 1];
cfg.detpos=[30 20 1 1;30 40 1 1;20 30 1 1;40 30 1 1];
cfg.vol(:,:,1)=0;   % pad a layer of 0s to get diffuse reflectance
cfg.issaveref=1;
cfg.gpuid=1;
cfg.autopilot=1;
cfg.tstart=0;
cfg.tend=5e-9;
cfg.tstep=5e-10;
% calculate the fluence distribution with the given config
[~,detpt]=mcxlabcl(cfg);

% One layer example

% Two layer example