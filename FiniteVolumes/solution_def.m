function [solution] = solution_def(index)

switch index
    case 1
        %solution.u = @(x,y) (x-1).*(x+1).*(y-1).*(y+1);
        %solution.f = @(x,y) -2 * (x.^2 - 1 + y.^2 - 1);
        %solution.ugrad = @(X,Y) [(2*X).*(Y.^2-1), ...
        %   (2*Y).*(X.^2-1)];
        %solution.name = 'polynomial';
        solution.geometry =[ 2.0000    2.0000    2.0000    2.0000;...
            0    1.0000    1.0000         0;...
            1.0000    1.0000         0         0;...
            0.5000    0.5000         0         0;...
            0.5000         0         0    0.5000;...
            0         0         0         0;...
            1.0000    1.0000    1.0000    1.0000];
        
    case 2
        solution.geometry = [4.0000, 4.0000, 4.0000, 4.0000;...
            -1.0000, 0, 1.0000, 0; ...
            0 , 1.0000,  0, -1.0000; ...
            0, -1.0000, 0, 1.0000; ...
            -1.0000, 0,  1.0000,  -0.0000; ...
            1.0000,  1.0000,  1.0000,  1.0000; ...
            0, 0, 0, 0; ...
            0, 0, 0, 0; ...
            0, 0, 0, 0; ...
            1.0000    1.0000    1.0000    1.0000;...
            1.0000    1.0000    1.0000    1.0000;...
            0,   0,    0,   0];
        solution.name = 'circle';
        %radius = 1;
        %solution.diamOmega = 2 * radius;
        
    case 3
        
        solution.f = @(x,y) 0;
        solution.rhoRed0 = @(x,y) 0.5 * (0.5 + 0.3* cos(2 * pi * x).*cos(2 * pi * y));
        solution.rhoBlue0 = @(x,y) 0.5 * (0.5 + 0.3 * sin(2 * pi * x).*sin(2 * pi * y));
        %% Check neumann boundary conditions
        
        %[out] = check_neumann_boundary(solution.grad, [0, 1]);
        
        solution.geometry = [2     2     2     2
            0     1     1     0
            1     1     0     0
            1     1     0     0
            1     0     0     1
            0     0     0     0
            1     1     1     1];
        
        
    case 4
        
        solution.f = @(x,y) 0;
        %solution.rhoRed0 = @(x,y) 0.25 + 0.25 * cos(pi * x).*cos(pi * y);
        %solution.rhoBlue0 = @(x,y) 0.5 - 0.5 * cos(pi * x).*cos(pi * y);
        
        solution.geometry = [2     2     2     2
            0     1     1     0
            1     1     0     0
            1     1     0     0
            1     0     0     1
            0     0     0     0
            1     1     1     1];
        
     
end



end 