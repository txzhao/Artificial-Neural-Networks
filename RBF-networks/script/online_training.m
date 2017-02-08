%% data of sin(2x)
patterns = (0 : 0.1 : 2*pi)';
targets = sin2x(patterns);

%% simple case given units
units = 80;
fun = 'x2';
eta = [1.5, 0.0005];
[m, var, Iter, F] = makerbf(patterns, units);
Iter = [0, 20, 10000];
residual = diter(patterns, m, var, Iter, F, units, fun, eta, 0);

%% tests units for given residual value
while (1)
    if residual < 0.01
        residual = diter(patterns, m, var, Iter, F, units, fun, eta);
        break;
    end
    units = units + 1;
    [m, var, Iter, F] = makerbf(patterns, units);
    residual = diter(patterns, m, var, Iter, F, units, fun, eta, 0);
end