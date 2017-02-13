% initial
clear;
animals;
w = rand(100, 84);
epochs = 20;
eta = 0.2;

for i = 1 : epochs
    % updata neighbor
    neighbor = round(62 * exp(-i/4));
    
    % update learning rate
%     eta = 0.2 * exp(-(i - 1)/4);
    
    for a = 1 : size(props, 1)
        p = repmat(props(a, :), size(w, 1), 1);
        
        % compute similarity between input and weight
        sim = sum((p - w).^ 2, 2);
        [~, index] = min(sim);
        
        % find index of neighbors
        imin = index - neighbor;
        imax = index + neighbor;
        if index - neighbor < 1
            imin = 1;
        end
        if index + neighbor > size(w, 1)
           imax = size(w, 1);
        end
        I = imin : imax;
        
        % update weights of the winners
        w(I, :) = w(I, :) + eta * (repmat(props(a, :), size(I, 2), 1) - w(I, :));
    end
end

% calculate winning output node
pos = zeros(size(props, 1), 1);
for a = 1 : size(props, 1)
    p = repmat(props(a, :), size(w, 1), 1);
    sim = sum((p - w).^ 2, 2);
    [~, index] = min(sim);
    pos(a) = index;
end

% print out result in natrual order
[dummy, order] = sort(pos);
snames(order)'

% plot hist
b = zeros(1, 100);
for i = 1 : 100
    b(i) = length(find(pos == i));
end
bar(b)
title('index vs. number of animals');
xlabel('node index');
ylabel('number of animals');