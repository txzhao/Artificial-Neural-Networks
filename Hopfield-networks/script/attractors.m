%% define input patterns
clear;
% test patterns
x1 = vm([0 0 1 0 1 0 0 1]);
x2 = vm([0 0 0 0 0 1 0 0]);
x3 = vm([0 1 1 0 0 1 0 1]);

% distorted input patterns
x1d = vm([1 0 1 0 1 0 0 1]);
x2d = vm([1 1 0 0 0 1 0 0]);
x3d = vm([1 1 1 0 1 1 0 1]);

% half-wrong input patterns
x1w = vm([1 1 1 0 1 0 1 0]);
x2w = vm([1 1 0 1 0 1 0 1]);
x3w = vm([1 0 1 0 1 1 0 0]);

X = [x1' x2' x3'];
Xd = [x1d' x2d' x3d'];
Xw = [x1w' x2w' x3w'];

%% calculate weights and update patterns
% weight symmetric
W = (X*X')/size(X, 1);

% calculate energy
Ex = -diag(X'*W*X)
Exd = -diag(Xd'*W*Xd)

tx = t0(X)

%% recall stored patterns
[Xd, iterd] = patRecal(Xd, W);
txd = t0(Xd)

%% attractors searching
epochs = 10;
x = (vm(abs(de2bi(0 : 2^size(X, 1) - 1, size(X, 1)))))';
x0 = x;
att = [];

x = patRecal(x, W);
for i = 1 : size(x, 2)
    if rank(x(:, i) - x0(:, i)) == 0
        att = [att, t0(x0(:, i))];
    end
end
    
%% half-wrong test
[Xw, iterm] = patRecal(Xw, W);
txw = t0(Xw)