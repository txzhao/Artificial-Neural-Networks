function [Hout, Out] = fwdpass(patterns, W, V)
Hin = W * [patterns; ones(1, size(patterns, 2))];
Hout = [2 ./ (1 + exp(-Hin)) - 1; ones(1, size(patterns, 2))];
Oin = V * Hout;
Out = 2 ./ (1 + exp(-Oin)) - 1;
end