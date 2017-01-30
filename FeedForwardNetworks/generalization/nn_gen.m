function [Out, Hout, W, V, error] = nn_gen(input, output, n)
epochs = 1000;
eta = 0.05;
alpha = 0.9;
hidden = 6;
W = rand(hidden, size(input, 1) + 1);
V = rand(size(output, 1), hidden + 1);
dW = zeros(size(W));
dV = zeros(size(V));
error = zeros(1, epochs);
train_in = input(:, 1:n);
train_out = output(:, 1:n);
test_in = input(:, (n+1): size(input,2));
test_out = output(:, (n+1): size(output,2));

for i = 1 : epochs
    [tr_Hout, tr_Out] = fwdpass(train_in, W, V);
    [delta_o, delta_h] = backpass(train_out, tr_Hout, tr_Out, V);
    [W, V, dW, dV] = w_update(train_in, tr_Hout, delta_h, delta_o, W, V,...
        dW, dV, alpha, eta);
    [Hout, Out] = fwdpass(test_in, W, V);
%     error(i) = sum(sum(abs(sign(Out) - test_out)./2));
    error(i) = sum(sum(abs(Out - test_out)));
end

figure()
plot(1 : epochs, error, 'r-o');
xlabel('epochs');
ylabel('error');

end