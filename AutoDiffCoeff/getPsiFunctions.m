function [psi,psis] = getPsiFunctions(psiData)
psi1 = psiData(1,:);
psi2 = psiData(2,:);
psi3 = psiData(3,:);
psi4 = psiData(4,:);
psi5 = psiData(5,:);
psi6 = psiData(6,:);
psi7 = psiData(7,:);
psi8 = psiData(8,:);
psi = @(eta) psi1(eta(1)+1)*psi2(eta(2)+1)*psi3(eta(3)+1)*psi4(eta(4)+1)*psi5(eta(5)+1)*psi6(eta(6)+1)*psi7(eta(7)+1)*psi8(eta(8)+1);
psis = {@(x) psi1(x+1),@(x) psi2(x+1),@(x) psi3(x+1),@(x) psi4(x+1),@(x) psi5(x+1) ,@(x) psi6(x+1) ,@(x) psi7(x+1) ,@(x)psi8(x+1)};
end