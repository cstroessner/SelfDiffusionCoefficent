function [out] = disc_init_guess_rho_blue(xx, yy, init_guess_param)

switch init_guess_param
    
    case 1
        out = 0.5 - 0.5 * cos(pi * xx).*cos(pi * yy);
        
    case 2
        
        if (xx >= 4/8 && xx <= 7/8) && (yy <= 4/8 && yy <= 7/8)
            out = 0.2;
        else
            out = 0.75;
            
        end
        
end