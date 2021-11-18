function getDs = getAutoDiffCoeff(N,r,v_k,p_k)
%GETAUTODIFFCOEFF computes the auto-diffusion coefficient for the given
%parameters
getDs = Interpolation(N,r,v_k,p_k);
end

