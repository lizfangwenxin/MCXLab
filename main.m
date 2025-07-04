% Main 
clear
close all

L1 = 40; % intralipid thickness in mm
%L2 = 6.5; % dermis tissue thickness in mm

tic
%% ==== SD configuration ====
SD = 30; % in mm 
src_rad = 1; % in mm
det_rad = 1; % in mm
dim = [100, 100, 100]; % volume, in mm
hbt = 0.05;
excoef = [710 1058; 1075.44 691.32]; %[780 850]
excoef = excoef * 2.303/1000;
oxy_sim_all = [0.2 0.4 0.6 0.8 1];
L_850_measured(2,5)=0;
L_780_measured(2,5)=0;
dim0 = dim(1);
%src_coor = [dim0/2,(dim0 - SD(end))/2]; 
src_coor = [50, 45];
det_coor = [50, src_coor(2)+SD];
unit = 1;

layer=2;