clear;
mid_A1 = -1.0;
mid_A2 = 0.3;
mid_B1 = 0.0;
mid_B2 = -0.1;
std_A = 0.2;
std_B = 0.3;

classA(1, :) = [randn(1, 50) .* std_A + mid_A1, randn(1, 50) .* std_A - mid_A1];
classA(2, :) = randn(1, 100) .* std_A + mid_A2;
classB(1, :) = randn(1, 100) .* std_B + mid_B1;
classB(2, :) = randn(1, 100) .* std_B + mid_B2;

patterns = [classA, classB];
targets = [ones(1, 100), -ones(1, 100)];
permute = randperm(200);
patterns = patterns(:, permute);
targets = targets(:, permute);

plot(patterns(1, find(targets>0)), ...
    patterns(2, find(targets>0)), '*', ...
    patterns(1, find(targets<0)), ...
    patterns(2, find(targets<0)), '+');