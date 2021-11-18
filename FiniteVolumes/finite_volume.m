function[Sol, newton_iter] = finite_volume(Dt, sol_init, getDs, matD)


global meshdata

Amat1 = zeros(meshdata.ne, meshdata.ne); 
right_hand_side = zeros(meshdata.ne, 1);

xold_r = sol_init(1 : meshdata.ne);
xold_b = sol_init(meshdata.ne + 1 : 2 * meshdata.ne);

xold = [xold_r; xold_b];

%% Compute the nonlinear flux function

[Fmat_Flux] = -1/2 * assembling_rhs(xold, getDs, matD);
  

%% Employ Newton solver
[Sol, newton_iter] = Newton_scheme(xold, Fmat_Flux, getDs, matD, Dt);

