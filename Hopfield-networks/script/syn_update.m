%% define input patterns
clear;
pict;
p = [p1' p2' p3'];

%% calculate weights and update patterns
% weight symmetric
w = (p*p')/size(p, 1);

% calculate energy
Ep = -diag(p'*w*p)
Ed1 = -diag(p11*w*p11')
Ed2 = -diag(p22*w*p22')

%% recall stored patterns
pd1 = patRecal(p11', w);
pd2 = patRecal(p22', w);

%% plot
figure(1)
subplot(1, 2, 1)
vis(p11)
title('degraded version');
subplot(1, 2, 2)
vis(pd1)
title('complete version');

figure(2)
subplot(1, 2, 1)
vis(p22)
title('mixed version');
subplot(1, 2, 2)
vis(pd2)
title('complete version');
