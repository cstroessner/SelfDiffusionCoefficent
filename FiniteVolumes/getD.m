function D = getD(v,p)
% computes the constant coefficient matrix D
D = zeros(2);
for i = 1:2
    for j = 1:2
        for k = 1:numel(p)
            D(i,j) = D(i,j) + p(k)*v{k}(i)*v{k}(j);
            %TODO check whether we need a rescaled set of vectors v here
        end
    end
end
end
