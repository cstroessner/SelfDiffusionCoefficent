function val = evalAuNaive(u,psi,v,p,tau,N)
% sum over all etas not put into the equation
val = 0;
Etas = dec2bin(0:2^N-1)' - '0';
for i = 1:size(Etas,2)
    eta = Etas(:,i);
    val = val +  evalAuforEta(u,psi,eta,v,p,tau);
end
end

