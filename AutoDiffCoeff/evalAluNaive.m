function val = evalAluNaive(u,psi,l,v,p,tau,N)
% sum over all etas not put into the equation
val = 0; num = 0;
Etas = dec2bin(0:2^N-1)' - '0';
for i = 1:size(Etas,2)
    eta = Etas(:,i);
    if sum(eta) == l
        num = num+1;
        val = val +  evalAuforEta(u,psi,eta,v,p,tau);
    end
end
val = val/num;
end