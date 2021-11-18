%% Newton scheme

function [Sol, newton_counter] = Newton_scheme(xold, fun_old, getDs, matD, Dt)

colors;

global meshdata

tol = 1e-8;

fun_init = fun_old;

Jac_old2 = diag(repmat(1/Dt * meshdata.measure_element, 2, 1));
newton_counter = 1;
norm_res = 1e5;
%norm_res_rel = 1e5;
xold_newton = xold;

while norm_res > tol
    
    %% Construct Jacobian functions for Newton scheme

    Jac_old1 = compute_Jacobian(xold_newton, xold, getDs, matD, Dt);

    Jac_old = Jac_old2 - 1/2 * Jac_old1;
    
    F_old = Jac_old * xold_newton - fun_init;

    Sol = Jac_old \ F_old;
    
    %% Solution red and blue at iteration k
    xnew_r = Sol(1 : meshdata.ne);
    xnew_b = Sol(meshdata.ne + 1 : 2 * meshdata.ne);
    xnew = [xnew_r, xnew_b];
    
    
    %% evaluate S(X^{n,k})
    fun_Euler1 = 1/Dt * meshdata.measure_element .*(xnew_r - xold(1 : meshdata.ne));
    fun_Euler2 = 1/Dt * meshdata.measure_element .*(xnew_b - xold(meshdata.ne + 1 : 2 * meshdata.ne));
    fun_Euler = [fun_Euler1; fun_Euler2];
    fun = fun_Euler -1/2 * assembling_rhs(xnew, getDs, matD);
    
    %% Check stopping criterion    
    norm_res = norm(fun, 2) / norm(fun_old);
    %norm_res = max(abs(fun));
    norm_newton(newton_counter) = norm_res;
    
    %% update
    xold_newton = Sol;
    fun_init = fun;
%     if newton_counter > 1
%         if abs(norm_newton(newton_counter) - norm_newton(newton_counter - 1)) < tol
%             sprintf('Newton has cv in %d iterations', newton_counter)
%             figure(1)
%             plot(1 : newton_counter, norm_newton, 'd -', 'linewidth', 2, 'color', OrangeRed2, 'MarkerFaceColor', OrangeRed2);
%             xlabel('Number of Newton iterations');
%             ylabel('L2 error');
%             
%             figure(2)
%             semilogy(1 : newton_counter, norm_newton, 'd -', 'linewidth', 2, 'color', OrangeRed2, 'MarkerFaceColor', OrangeRed2);
%             xlabel('Number of Newton iterations');
%             ylabel('semilog L2 error');
%             break
%         end
%     end    
    
    if norm_newton(newton_counter) < tol
        sprintf('Newton has cv in %d iterations', newton_counter)
        
        figure(1)
        plot(1 : newton_counter, norm_newton, 'd -', 'linewidth', 2, 'color', OrangeRed2, 'MarkerFaceColor', OrangeRed2);
        xlabel('Number of Newton iterations');
        %ylabel('L2 error');
        ylabel('$L^{\mathrm{inf}}$','Interpreter', 'latex');
        
        figure(2)
        semilogy(1 : newton_counter, norm_newton, 'd -', 'linewidth', 2, 'color', OrangeRed2, 'MarkerFaceColor', OrangeRed2);
        xlabel('Number of Newton iterations');
        ylabel('$L^{\mathrm{inf}}$','Interpreter', 'latex');
        %ylabel('semilog L2 error');
        break
    end
    newton_counter = newton_counter + 1;
   
  
end


end