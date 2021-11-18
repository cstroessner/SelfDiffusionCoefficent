%% discontinuous initial guess 

function [out] = disc_init_guess_rho_red(xx, yy, init_guess_param)

switch init_guess_param
    
    case 1
        
        out =  0.25 + 0.25 * cos(pi * xx).*cos(pi * yy);
        
    case 2
        if (xx >= 4/8 && xx <= 7/8) && (yy <= 4/8 && yy <= 7/8)
            out = 0.6;
        else
            out = 0.1;
        end
        
end