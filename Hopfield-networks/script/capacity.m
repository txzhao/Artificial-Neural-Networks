%% define input patterns
clear;
pict;
P = [p1' p2' p3' p4' p5' p6' p7' p8' p9'];
p = P(:, [1 2 3 8]);

%% calculate weights and update patterns
% weight symmetric
w = (p*p')/size(p, 1);
   
%% recall stored patterns
pc1 = patRecal(p11', w, 100);
pc2 = patRecal(p22', w, 100);

%% plot
figure(1)
subplot(2, 2, 1)
vis(p11)
title('degraded version');
subplot(2, 2, 2)
vis(pc1)
title('complete version');
subplot(2, 2, 3)
vis(p22)
title('mixed version');
subplot(2, 2, 4)
vis(pc2)
title('complete version');

% error vs. number of patterns
figure(2)
err = [];
for i = 1 : 9
    pi = P(:, 1 : i);
    wi = (pi*pi')/size(pi, 1);    
    pi1 = patRecal(p11', wi, 10);
    err = [err size(find((pi1' - p1) ~= 0), 2)/size(pi1, 1)];
end

plot(1 : 9, err)
title('error vs. number of patterns');
xlabel('number of patterns');
ylabel('error');


