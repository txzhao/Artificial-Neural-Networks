function [delta_o, delta_h] = backpass(targets, Hout, Out, V)
delta_o = (Out - targets) .* ((1 + Out) .* (1 - Out)) * 0.5;
delta_h = (V' * delta_o) .* ((1 + Hout) .* (1 - Hout)) * 0.5;
hidden = size(delta_h, 1) - 1;
delta_h = delta_h(1 : hidden, :);

end