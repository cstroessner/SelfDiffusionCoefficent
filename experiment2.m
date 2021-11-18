% this script produces the values for Table 1 and plots Figure 3

clear
close all
rng(1)
addpath('AutoDiffCoeff')

%% initialize parameters
[d,N,K,v,p,vectors,tau] = initialization();

%% eval for different u
u = [1,0];
[valLSQ10,valALS10] = getVals(u,v,p,tau,N)

u = [0,1];
[valLSQ01,valALS01] = getVals(u,v,p,tau,N)

u = [1,1];
[valLSQ11,valALS11] = getVals(u,v,p,tau,N)
% these are the values depicted in table 1

%% get the matrices
for l = 0:N
   d11 = valLSQ10(l+1); 
   d22 = valLSQ01(l+1);
   d12 = 0.5*(valLSQ11(l+1)-d11-d22);
   Dlsq{l+1} = [d11 d12; d12 d22];
   
   d11 = valALS10(l+1); 
   d22 = valALS01(l+1);
   d12 = 0.5*(valALS11(l+1)-d11-d22);
   Dals{l+1} = [d11 d12; d12 d22];
end

%% plot traces
for l = 0:N
    trlsq(l+1) = trace(Dlsq{l+1});
    trals(l+1) = trace(Dals{l+1});
end

%% plot
rhos = ((0:N))/(N); 
plot(rhos,trlsq,'b-',rhos,trals,'r--',linspace(0,1,N+1),1:-1/N:0,'k:');
set(gca,'fontsize',10)
set(figure(1), 'Position', [0 0 370 300])
leg = legend('LSQ','ALS','$1-\rho$');
set(leg,'Interpreter','latex');
xlabel('$\rho$','Interpreter','latex')
ylabel('tr$(D_s(\rho))$','Interpreter','latex')
%print -depsc 'TraceN8'

%% save the matrices
save('matricesALSsmall.mat','Dals');
save('matricesLSQsmall.mat','Dlsq');

%% functions
function [valAluPsiLSQ,valAluRALS] = getVals(u,v,p,tau,N)
%% compute LSQ solution
[PsiLSQFun] = computeLSQsolution(u,v,p,tau,N);
%% compute ALS solution
% initialize
psiData = rand(8,2); %psiData(j,1) = psis{j}(0), psiData(j,2) = psis{j}(1)
% solve
psiData = ALS(u,psiData,v,p,tau,N,1e-5);
% get functions
RALSFun = getPsiFunctions(psiData);
%% evaluate A^u
valAuPsiLSQ = evalAuNaive(u,PsiLSQFun,v,p,tau,N);
valAuRALS = evalAuNaive(u,RALSFun,v,p,tau,N);
%% evaluate A_l^u
for l = 0:N
    valAluPsiLSQ(l+1) = evalAluNaive(u,PsiLSQFun,l,v,p,tau,N);
    valAluRALS(l+1) = evalAluNaive(u,RALSFun,l,v,p,tau,N);
end
end
