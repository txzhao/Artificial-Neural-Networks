function output = lowpass(input, para, verbose)
if (nargin < 3)
    verbose = 0;
end

num = [(para/2)/(1+para/2) (para/2)/(1+para/2)];
den = [1 (para/2 - 1)/(para/2 + 1)];
output = filter(num, den, input);

if verbose == 1
    fvtool(num, den)
end

end
