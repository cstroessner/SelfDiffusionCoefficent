% this script computes the finite volume solution depicted in Figure 4

clear; clc; close all;
addpath('FiniteVolumes')
colors;

%% initialize
N = 8;
r = 1; 
v = {[1,0],[-1,0],[0,1],[0,-1]};
p = [1/4,1/4,1/4,1/4];
getDs = getAutoDiffCoeff(N,r,v,p); 

initializeFV()

%% Solve the corresponding cross-diffustion system
U = solveCrossDiff(getDs, v, p, Sol_init', number_fine_time_step, Dt, fine_time_step, time_observable);

% the figure in the paper was obtained by merging the plots in Figure 20
% and Figure 30 for the corresponding values time steps (here the time
% steps are denoted by $n$ instead of $p$