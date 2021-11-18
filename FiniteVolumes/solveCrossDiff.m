function [U] = solveCrossDiff(getDs, v, p, sol_init, number_fine_time_step, Dt, fine_time_step, time_observable)
%SOLVECROSSDIFF calls the finite volume solver to solve the cross diffusion
%system
colors;
global meshdata
sol_all_time = zeros(2 * meshdata.ne, number_fine_time_step);
sol_red_all_time = zeros(meshdata.ne, number_fine_time_step);
sol_blue_all_time = zeros(meshdata.ne, number_fine_time_step);


newton_iter_all_time = zeros(1, number_fine_time_step);

matD = getD(v, p);

rhoRed_init = sol_init(1 : meshdata.ne);
rhoBlue_init = sol_init(meshdata.ne + 1 : 2 * meshdata.ne);

figure(2)
pdeplot(meshdata.coord, [], meshdata.elements, 'XYData', rhoRed_init, 'XYStyle','interp', 'ZData', rhoRed_init, 'ZStyle','continuous',...
    'ColorBar','off', 'Mesh', 'on', 'ColorMap', 'default', 'FaceAlpha', 0.5);
ylabel(['Time n =', num2str(0)]);
title('$\rho_{\mathrm{red}}^{n}$','Interpreter','latex');

figure(3)
pdeplot(meshdata.coord, [], meshdata.elements, 'XYData', rhoBlue_init, 'XYStyle','interp', 'ZData', rhoBlue_init, 'ZStyle','continuous',...
    'ColorBar','off', 'Mesh', 'on', 'ColorMap', 'default', 'FaceAlpha', 0.5);
ylabel(['Time n =', num2str(0)]);
title('$\rho_{\mathrm{blue}}^{n}$','Interpreter','latex');

%% loop on time

for tt = 1 : number_fine_time_step
    
    %% Implement a cell-centered finite volume scheme for the cross_diff pb
    
    [sol, newton_iter] = finite_volume(Dt, sol_init, getDs, matD);
    
    %% plot solution
%     if ismember(fine_time_step(tt), time_observable)
%         figure(40)
%         pdeplot(meshdata.coord, [], meshdata.elements, 'XYData', Sol, 'XYStyle','interp',...
%             'ZData', Sol,'ZStyle','continuous',...
%             'ColorBar','off', 'Mesh', 'on', 'ColorMap', 'default', 'FaceAlpha', 0.5);
%         title('Finite volume solution');
%         hold off
%     end
%% Update
sol_all_time(:, tt) = sol;
newton_iter_all_time(tt) = newton_iter;
sol_red_all_time(:, tt) = sol_all_time(1 : meshdata.ne, tt);
sol_blue_all_time(:, tt) = sol_all_time(meshdata.ne + 1 : 2 * meshdata.ne, tt);

%% Plot solution
%if ismember(fine_time_step(tt), time_observable)
    figure(20)
    pdeplot(meshdata.coord, [], meshdata.elements, 'XYData', sol(1 : meshdata.ne), 'XYStyle','interp', 'ZData', sol(1 : meshdata.ne), 'ZStyle','continuous',...
        'ColorBar','off', 'Mesh', 'on', 'ColorMap', 'default', 'FaceAlpha', 0.5);
    ylabel(['Time n =', num2str(tt)]);
    title('$\rho_{\mathrm{red}}^{n}$','Interpreter','latex');
    drawnow;
    
    figure(30)
    pdeplot(meshdata.coord, [], meshdata.elements, 'XYData', sol(meshdata.ne + 1 : 2 * meshdata.ne), 'XYStyle','interp', 'ZData', sol(meshdata.ne + 1 : 2 * meshdata.ne), 'ZStyle','continuous',...
        'ColorBar','off', 'Mesh', 'on', 'ColorMap', 'default', 'FaceAlpha', 0.5);
    ylabel(['Time n =', num2str(tt)]);
    title('$\rho_{\mathrm{blue}}^{n}$','Interpreter','latex');
    drawnow;
%end
% 
%     figure(4)
%     plot(1 : tt, newton_iter_all_time(1 : tt), 'd -', 'linewidth', 2, 'color', OrangeRed2, 'MarkerFaceColor', OrangeRed2)
%     ylabel('Number of Newton iterations');
%     xlabel('Time step')
%  

sol_init = sol;


end
end

