function [PsiLSQFun,PsiLSQVec,lsqErr] = computeLSQsolution(u,v,p,tau,N)
if N ~= 8
    warning('LSQ is only implemented for N=8')
end

%% get system
[A,b] = assemble(u,v,p,tau,N);

%% solve linear least squares problem
Psi0 = lsqr(A,-b,1e-14,1000);
lsqErr = norm(A*Psi0-b)^2;
PsiLSQVec = [Psi0;0]; %the last column of A is zero so we need to add this element

%% check consistency between norm(A*Psi0-b)^2 and an evaluation A^u(Psi0)
PsiLSQFun = @(eta) PsiLSQVec(Eta2I(eta));
end

function [A,b] = assemble(u,v,p,tau,N)
row = 1;
M = 2^N;
A = sparse([4096,M]);
b = zeros([1,4096]);
for k = 1:numel(v)
    for i = 1:N
        if tau(k,i) > 0
            for I = 1:M
                eta = I2Eta(I);
                etaSw = etaSwap(eta,i,tau(k,i));
                if max(eta-etaSw ~= 0)
                    Isw = Eta2I(etaSw);
                    A(row,Isw) = + sqrt(1/2)*sqrt(p(k));
                    A(row,I) = - sqrt(1/2)*sqrt(p(k));
                    b(row) = 0;
                    row = row +1;
                end
            end
        end
    end
end
for k = 1:numel(v)
    uv = u*v{k}';
    for I = 1:M
        eta = I2Eta(I);
        if eta(vecIndex(v{k})) == 0
            etaSh = etaShift(eta,k,tau);
            Ish = Eta2I(etaSh);
            b(row) = sqrt(p(k))*uv;
            A(row,Ish) = sqrt(p(k));
            A(row,I) = -sqrt(p(k));
            row = row + 1;
        end
    end
end
b = b';
end
