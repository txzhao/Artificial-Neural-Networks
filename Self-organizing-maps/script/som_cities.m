% initial
clear;
cities;
w = rand(10, 2);
epochs = 80;
eta = 0.2;

for i = 1 : epochs
    % updata neighborhood
    neighbor = round(2.5 * exp(-i/10));
    
    % update learning rate
%     eta = 0.2 * exp(-(i - 1)/10);
    
    for a = 1 : size(city, 1)
        I = [];
        p = repmat(city(a, :), size(w, 1), 1);
        
        % compute similarity between input and weight
        sim = sum((p - w).^ 2, 2);
        [~, index] = min(sim);
        
        % find index of neighbors
        imin = index - neighbor;
        imax = index + neighbor;
        if index - neighbor < 1
            imin = 1;
            I = (index - neighbor + size(w, 1)) : size(w, 1);
        end
        if index + neighbor > size(w, 1)
           imax = size(w, 1);
           I = 1 : (index + neighbor - size(w, 1));
        end
        I = [I, imin : imax];
        
        % update weights of the winners
        w(I, :) = w(I, :) + eta * (repmat(city(a, :), size(I, 2), 1) - w(I, :));
    end
end

% calculate winning output node
pos = zeros(size(city, 1), 1);
for a = 1 : size(city, 1)
    p = repmat(city(a, :), size(w, 1), 1);
    sim = sum((p - w).^ 2, 2);
    [~, index] = min(sim);
    pos(a) = index;
end

% print out result in natrual order
[dummy, order] = sort(pos);
order(end + 1) = order(1);
city_order = order'

% plot suggested tour graphically
tour = [w; w(1, :)];
plot(tour(:, 1), tour(:, 2), 'b-*', city(:, 1), city(:, 2), '+')
hold on
plot(city(order, 1), city(order, 2), 'g-')
    
    
    