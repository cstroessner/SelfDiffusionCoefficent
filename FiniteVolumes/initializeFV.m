%% some colors for matlab plot
colors;                         

%% Mesh
global meshdata 

Hmax_values = [2, 0.9, 0.7, 0.5, 0.2, 0.1, 0.08, 0.06, 0.03, 0.02];

%% choice of the problem

Hmax = Hmax_values(6);

geometry_case = 4;

solution = solution_def(geometry_case);

my_meshdata(Hmax, solution.geometry);

init_guess_param = 1;

%% Time_discretization
T_final = 10;

T_init = 0;

DT = T_final / 1e1;

number_time_observable = T_final / DT;

time_observable = DT : DT : T_final;

Dt = DT / 1e3;

%% number time step
number_fine_time_step = DT/Dt * number_time_observable;

fine_time_step = Dt : Dt : T_final;

%% Vector of init guess

%% test_case discontinuous ured0 and ublue0
Sol_init_red = zeros(meshdata.ne, 1);
Sol_init_blue = zeros(meshdata.ne, 1);

for ii = 1 : meshdata.ne    
        
    Sol_init_red(ii) = disc_init_guess_rho_red(meshdata.center_element(1, ii), meshdata.center_element(2, ii), init_guess_param);
    Sol_init_blue(ii) = disc_init_guess_rho_blue(meshdata.center_element(1, ii), meshdata.center_element(2, ii), init_guess_param);
end



Sol_init(1 : meshdata.ne) = Sol_init_red;
Sol_init(meshdata.ne + 1 : 2 * meshdata.ne) = Sol_init_blue;
