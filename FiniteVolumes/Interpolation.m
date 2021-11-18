%this is very temporary so far
function getDs = Interpolation(N,r,v_k,p_k)
load('matricesALSsmall.mat')
N = size(Dals,2)-1;
nodes = linspace(0,1,N+1);

for i = 1:N+1
   vals11(i) = Dals{i}(1,1);
   vals21(i) = Dals{i}(2,1);
   vals22(i) = Dals{i}(2,2);    
end

spline11 = spline(nodes,vals11);
spline21 = spline(nodes,vals21);
spline22 = spline(nodes,vals22);

getDs = @(rho) [ppval(spline11,rho),ppval(spline21,rho);ppval(spline21,rho),ppval(spline22,rho)];
end