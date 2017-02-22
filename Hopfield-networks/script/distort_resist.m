%% define input patterns
clear;
pict;
p = [p1' p2' p3'];

%% calculate weights and update patterns
% weight symmetric
w = (p*p')/size(p, 1);

%% flip units randomly
ratio = 0.6;
p1dist = flip(p1, round(ratio*size(p1, 2)));
p2dist = flip(p2, round(ratio*size(p2, 2)));

%% recall stored patterns
pc1 = patRecal(p1dist', w, 100);
pc2 = patRecal(p2dist', w, 100);

%% plot
figure(1)
subplot(2, 2, 1)
vis(p1dist)
title(sprintf('degraded version, ratio = %.2f', ratio));
subplot(2, 2, 2)
vis(pc1)
title('complete version');
subplot(2, 2, 3)
vis(p2dist)
title(sprintf('mixed version, ratio = %.2f', ratio));
subplot(2, 2, 4)
vis(pc2)
title('complete version');

% error rate vs. noise ratio
figure(2)
err = [];
pe = p3;
for i = 0 : 0.01 : 1
    pdist = flip(pe, round(i*size(pe, 2)));
    pc = patRecal(pdist', w, 100);
    err = [err size(find((pc' - pe) ~= 0), 2)/size(pc, 1)];
end
plot(0 : 0.01 : 1, err)
title('p3-restoration: error vs. noise');
xlabel('noise ratio');
ylabel('error');