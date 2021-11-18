%% function that computes the length of an edge

function[out] = length_edge(A, B)

x_B = B(1, 1);
x_A = A(1, 1);
y_B = B(2, 1);
y_A = A(2, 1);

out = sqrt((x_B - x_A)^2 + (y_B - y_A)^2);

end