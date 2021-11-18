%% Function that computes Jacobian by finite difference scheme

function [Jac_bis] = compute_Jacobian(xold_newton, xold, getDs, matD, Dt)

global meshdata


hh = 1e-6;
Jac_bis = zeros(2 * meshdata.ne, 2 * meshdata.ne);
% for ii = 1 : 2 * meshdata.ne
%     
%          Jac(ii, :) = (assembling_rhs(xold_newton + hh * mat_direction, getDs, matD)...
%              - assembling_rhs(xold_newton, getDs, matD))/hh;
% end
% 

%% TEST%%
mat_direction_bis = eye(2 * meshdata.ne, 2 * meshdata.ne);
assemble_right_hand_side = assembling_rhs(xold_newton, getDs, matD);

for ii = 1 : 2 * meshdata.ne
        Jac_bis(:, ii) = (assembling_rhs(xold_newton + hh * mat_direction_bis(:, ii), getDs, matD) - assemble_right_hand_side)/hh;    
end


end