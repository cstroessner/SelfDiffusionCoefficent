function psiData = ALS(u,psiData,v,p,tau,N,tol)
decay = 1e14; iters = 1; val(iters) =  evalAu(u,psiData,v,p,tau,N);
while decay > tol*abs(val(iters)) && iters < 15000
    for mode = 1:N
       psiData = optimizeMode(mode,u,psiData,v,p,tau,N);
       iters = iters+1;
       newVal = evalAu(u,psiData,v,p,tau,N);
       val(iters) =  newVal;
    end
    decay = val(iters-N)-val(iters);
    if decay < 0
        warning('ALS not decaying')
    end
end
fprintf('als converged at iteration %i to a solution with value %d.\n',iters,newVal)
end

function psiDataNew = optimizeMode(mode,u,psiData,v,p,tau,N)
    if mode == 1
        psiDataFun = @(a,b) [a,b; psiData(2:end,:)];
    elseif mode == N
        psiDataFun = @(a,b) [psiData(1:end-1,:);a,b];
    else
        psiDataFun = @(a,b) [psiData(1:mode-1,:);a,b; psiData(mode+1:end,:)];
    end
    evalAB = @(a,b)evalAu(u,psiDataFun(a,b),v,p,tau,N);
    
    x = [1, 0, 2.5, .5, -2, -1];
    y = [0, 1, 1.5, 2.5, -2, 3];
    for i = 1:6
        f(i) = evalAB(x(i),y(i));
    end
    poly = fit([x', y'], f', 'poly22');
    alpha = coeffvalues(poly);
    alpha = alpha([4,6,5,2,3,1]);
    
    minIsUniqueAndExists = min(eigs([2*alpha(1),alpha(3);alpha(3),2*alpha(2)]) > 0);
    if ~minIsUniqueAndExists
        warning('the polynomial does not have a (unique) minimum')
        %psiDataNew = psiData; return
    end
    
            
    newparams = [2*alpha(1), alpha(3); alpha(3), 2*alpha(2)]\[-alpha(4);-alpha(5)];
    if mode == 1
        psiDataNew = [newparams';psiData(2:end,:)];
    elseif mode == N
        psiDataNew = [psiData(1:end-1,:);newparams'];
    else
        psiDataNew = [psiData(1:mode-1,:);newparams'; psiData(mode+1:end,:)];
    end
end
