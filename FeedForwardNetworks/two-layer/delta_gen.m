function [Out, Hout, W, V, error] = delta_gen(input, output)
epochs = 200;
eta = 0.05;
alpha = 0.9;
hidden = 3;
W = rand(hidden, size(input, 1) + 1);
V = rand(size(output, 1), hidden + 1);
dW = zeros(size(W));
dV = zeros(size(V));
error = zeros(1, epochs);

for i = 1 : epochs
    [Hout, Out] = fwdpass(input, W, V);
    [delta_o, delta_h] = backpass(output, Hout, Out, V);
    [W, V, dW, dV] = w_update(input, Hout, delta_h, delta_o, W, V,...
        dW, dV, alpha, eta);
    error(i) = sum(sum(abs(sign(Out) - output)./2));
end

figure()
plot(1 : epochs, error, 'r-o');
xlabel('epochs');
ylabel('error');

end
