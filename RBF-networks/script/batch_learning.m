%% data of sin(2x)
% patterns = (0 : 0.1 : 2*pi)';
% targets = sin2x(patterns);

%% data of square(2x)
patterns = (0 : 0.1 : 2*pi)';
targets = square(2*patterns);

%% simple case given units
units = 6;
[m, var] = makerbf(patterns, units);  % initialize center position and variance
Phi = calcPhi(patterns, m, var);
w = (Phi'*Phi)\(Phi'*targets);
y = Phi*w;
% rbfplot1(patterns, y, targets, units)

%% tests units for given residual value
while (1)
    if max(abs(targets-y)) < 0.01
        rbfplot1(patterns, y, targets, units)
        break;
    end
    units = units + 1;
    [m, var] = makerbf(patterns, units);
    Phi = calcPhi(patterns, m, var);
    w = (Phi'*Phi)\(Phi'*targets);
    y = Phi*w;
end