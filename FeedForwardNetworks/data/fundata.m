clear;
x = [-5 : 1 : 5]';
y = x;
z = exp(-x .* x * 0.1) * exp(-y .* y * 0.1)' - 0.5;

% plot Gaussian function
mesh(x, y, z)

ndata = size(z, 1) * size(z, 2);
targets = reshape (z, 1, ndata);
[xx, yy] = meshgrid (x, y);
patterns = [reshape(xx, 1, ndata); reshape(yy, 1, ndata)];