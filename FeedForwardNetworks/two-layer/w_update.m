function [W, V, dW, dV] = w_update(patterns, Hout, delta_h, delta_o, W, V,...
    dW, dV, alpha, eta)
patterns = [patterns; ones(1, size(patterns, 2))];
dW = (dW .* alpha) - (delta_h * patterns') .* (1 - alpha);
dV = (dV .* alpha) - (delta_o * Hout') .* (1 - alpha);
W = W + dW .* eta;
V = V + dV .* eta;
end