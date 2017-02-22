%% define input patterns
clear;
units = 100;
patterns = 300;
bias = 0;
P = sgn(randn(units, patterns) + bias);

%% calculate weight and update patterns
err = [];
ratio = 0;
ns = zeros(1, patterns);
for i = 1 : patterns
    p = P(:, 1 : i);
    w = (p*p')/size(p, 1);
    
    % remove self-connections
    w = w - diag(diag(w));
    
    % random flipping
    N = size(p, 1)*size(p, 2);
    pe = reshape(flip(reshape(p, 1, N), round(ratio*N)), size(p, 1), size(p, 2));
    pc1 = patRecal(pe, w, 10);
    
    % calculate error rate
    err = [err size(find((pc1 - p) ~= 0), 1)/(size(pc1, 1)*size(pc1, 2))];
    
    % network stability
    for j = 1 : i
        if rank(pc1(:, j) - p(:, j)) == 0
            ns(i) = ns(i) + 1;
        end
    end
    ns(i) = ns(i) / i;
end

%% plot
% error vs. number of patterns
figure(1)
plot(1 : patterns, err)
title('error vs. number of patterns');
xlabel('number of patterns');
ylabel('error');

figure(2)
plot(1 : patterns, ns)
title('stability');
xlabel('number of learning patterns');
ylabel('number of stable patterns');


