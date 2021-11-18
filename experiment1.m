% this script reproduces the data given in Section 5.1.1

clear
close all
rng(1)
addpath('AutoDiffCoeff')

%% initialize parameters
[d,N,K,v,p,vectors,tau] = initialization();

%% get u
u = [1,0];

%% compute LSQ solution
[PsiLSQFun,PsiLSQ,lsqErr] = computeLSQsolution(u,v,p,tau,N);

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

%% repeat for different initializations
for iters = 2:100
psiData = rand(8,2); 
psiData = ALS(u,psiData,v,p,tau,N,1e-5);
RALSFun = getPsiFunctions(psiData);
valAuRALS(iters) = evalAuNaive(u,RALSFun,v,p,tau,N);
end

%% very long run
psiData = rand(8,2); 
psiData = ALS(u,psiData,v,p,tau,N,1e-16);
RALSFun = getPsiFunctions(psiData);
valManyIterations = evalAuNaive(u,RALSFun,v,p,tau,N);

%% print data
LSQ = valAuPsiLSQ
maximum = max(valAuRALS) 
minimium = min(valAuRALS) 
mean = mean(valAuRALS) 
manyIterations = valManyIterations


