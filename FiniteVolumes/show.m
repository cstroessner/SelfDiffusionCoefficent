function show(coord, elements, newT, values, m)
% script for visualizing the solution as a piecewise linear function
% INPUT: coordinates ... coordinates of the element vertices
%        values ... values of the function in n degrees of freedom on 
%                   element (n=(m+1)*(m+2)/2) 
% 
% Jan Papez, March 2015


ne = length(elements(1,:));
[refcoordinates,triag] = reftriang(m);

values = full(values);

for tindex = 1:ne
    coordinates = coord(:,elements(1:3,tindex));
    
    Jloc = [coordinates(:,2)-coordinates(:,1), coordinates(:,3)-coordinates(:,1)];
    
    x = coordinates(:,1);
    loccoordinates= x(:,ones((m+1)*(m+2)/2,1),:) + Jloc*refcoordinates;
    % no edge displayed
    %         trisurf(triag,loccoordinates(1,:),loccoordinates(2,:),values(newT(:,tindex)),'facecolor','interp','EdgeColor','none'); hold on;
    % edges (even inside individual elements) displayed
    trisurf(triag,loccoordinates(1,:),loccoordinates(2,:),values(newT(:,tindex)),'facecolor','interp'); hold on;
end

axis auto;
hold off;

end

function [coordinates,triag] = reftriang(m)
% script for making triagulation on reference element

    n = (m+1)*(m+2)/2;  
    Z = zeros(2,n);

    i = 1;
    for k = 0:m
        for l = 0:(m-k)
            Z(:,i) = [k;l];
            i = i+1;
        end
    end
    
    coordinates = Z/m;
    
    triag = zeros(m^2,3);
    v = cumsum((m+1):-1:1)';
    index = [ones(1,m+1), (1+m*(m+1)/2)*ones(1,m-1)] + [0, cumsum(m:-1:1), cumsum(m-1:-1:1)];
  
       T = [v(1:end-1), v(1:end-1) - 1, v(2:end)];     
    for i = 1:m
        triag(index(i):(index(i+1)-1),:) = T(1:(m+1)-i,:) - (i-1)*ones((m+1)-i,3);
    end
    
        L = [v(2:end-1), v(1:end-2) - 1, v(2:end-1) - 1];
    for i = 1:m-1
        triag(index(m+i):(index(m+i+1)-1),:) = L(1:(m-i),:) - (i-1)*ones((m-i),3);
    end
    
end