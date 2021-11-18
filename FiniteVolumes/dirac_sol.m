function [position_close_center, index] = dirac_sol()

global meshdata

dist = zeros(length(meshdata.center_element(1, :)), 1);
%% find the center elements that is close to the center of the domain
for ii = 1 : length(meshdata.center_element(1, :))
    
    dist(ii) = length_edge(meshdata.center_element(:, ii), meshdata.center_mesh);

end

[toto, index] = min(dist);

position_close_center = meshdata.center_element(:, index);

end