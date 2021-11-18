

clear all; 
close all;
clc;

% some colors for matlab plot
colors;                         

%% Mesh
global meshdata 

Hmax_values = [2, 0.9, 0.7, 0.5, 0.2, 0.1, 0.08, 0.06, 0.03, 0.02];

%% choice of the problem

Hmax = Hmax_values(6);

geometry_case = 3;

solution = solution_def(geometry_case);

my_meshdata(Hmax, solution.geometry);

%% Time_discretization
T_final = 1;

T_init = 0;

DT = T_final / (10 * T_final);

number_time_observable = T_final / DT;

time_observable = DT : DT : T_final;

Dt = DT / 1e3;

%% number time step
number_fine_time_step = DT/Dt * number_time_observable;

fine_time_step = Dt : Dt : T_final;

Sol_init_r = solution.u0(meshdata.center_element(1, :), meshdata.center_element(2, :));

Sol_init_b = solution.u0(meshdata.center_element(1, :), meshdata.center_element(2, :));

Sol_init = [Sol_init_r; Sol_init_b];

figure(40)
pdeplot(meshdata.coord, [], meshdata.elements, 'XYData', Sol_init_r, 'XYStyle','interp',...
            'ZData', Sol_init_r,'ZStyle','continuous',...
            'ColorBar','off', 'Mesh', 'on', 'ColorMap', 'default', 'FaceAlpha', 0.5);
title('Finite volume solution');
hold off

%% loop on time

for tt = 1 : number_fine_time_step
    
    %% Implement a cell-centered finite volume scheme for the cross_diff pb
    
    [Sol] = finite_volume(Dt, Sol_init);
    
    %% plot solution
    if ismember(fine_time_step(tt), time_observable)
        figure(40)
        pdeplot(meshdata.coord, [], meshdata.elements, 'XYData', Sol, 'XYStyle','interp',...
            'ZData', Sol,'ZStyle','continuous',...
            'ColorBar','off', 'Mesh', 'on', 'ColorMap', 'default', 'FaceAlpha', 0.5);
        title('Finite volume solution');
        hold off
    end
%% Update

Sol_init_r = Sol;


end



disp('end of simulation')