% initial
clear;
votes;mpparty;mpsex;mpdistrict;
w = rand(100, 31);
epochs = 100;
eta = 0.2;

% create output grids
[x, y] = meshgrid(1 : 10, 1 : 10);
xpos = reshape(x, 1, 100);
ypos = reshape(y, 1, 100);
mand = pdist2([xpos' ypos'], [xpos' ypos'], 'cityblock');

for i = 1 : epochs
    % updata neighbor
    neighbor = round(6 * exp(-i/8));
    
    % update learning rate
%     eta = 0.2 * exp(-(i - 1)/5);
    
    for a = 1 : size(Votes, 1)
        p = repmat(Votes(a, :), size(w, 1), 1);
        
        % compute similarity between input and weight
        sim = sum((p - w).^ 2, 2);
        [~, index] = min(sim);
        
        % find index of neighbors
        I = find(mand(index, :) <= neighbor);
        
        % update weights of the winners
        w(I, :) = w(I, :) + eta * (repmat(Votes(a, :), size(I, 2), 1) - w(I, :));
    end
end

% calculate winning output node
pos = zeros(size(Votes, 1), 1);
for i = 1 : size(Votes, 1)
    p = repmat(Votes(i, :), size(w, 1), 1);
    sim = sum((p - w).^ 2, 2);
    [~, index] = min(sim);
    pos(i) = index;
end
a = ones(1, 100)*350;
a(pos) = 1 : 349;

% % print out result in natrual order
% [dummy, order] = sort(pos);
% mpnames(order)'

% display results
% influence of party
figure(1)
colormap([0 0 0; 0 0 1; 0 1 1; 1 0 1; 1 0 0; 0 1 0; 1 1 1; 1 1 0])
p = [Mpparty; 0];
image(p(reshape(a, 10, 10)) + 1);

% influence of gender
figure(2)
colormap([0 0 0; 0 0 1; 0 1 1; 1 0 1; 1 0 0; 0 1 0; 1 1 1; 1 1 0])
p = [Mpsex; 0];
image(p(reshape(a, 10, 10)) + 1);

% influence of district
figure(3)
colormap([0 0 0; 0 0 1; 0 1 1; 1 0 1; 1 0 0; 0 1 0; 1 1 1; 1 1 0;
    0 0 0.5; 0 0.5 1; 0.5 1 1; 1 0.5 1; 1 0 0.5; 0 1 0.5; 0.5 1 1; 1 1 0.5;
    0 0.5 0; 0.5 0 1; 0 0.3 1; 1 0.4 1; 1 0.6 0; 0.8 1 0; 0.4 1 1; 1 0.3 0.4;
    0.3 0.5 0; 0.5 0.3 1; 0.4 0.3 1; 1 0.4 0.8; 1 0.6 0.7; 0.8 1 0.2; 0.4 1 0.6; 0.4 0.3 0.4])
p = [Mpdistrict; 0];
image(p(reshape(a, 10, 10)) + 1);

% histgram
figure(4)
for ii = 1 : 100
    kk = find(pos == ii);
    num_w(ii, 1) = size(kk, 1);
end
bar(1:100, num_w);
title('Votes of MPs     Number of MPs in the Weight Space');
xlabel('Weights');
ylabel('Number of Amimals');
grid on;

% histgram in 3D
figure(5)
for ii = 1 : 100
    num_w_3dbar(xpos(ii), ypos(ii)) = num_w(ii, 1);
end
bar3(num_w_3dbar);