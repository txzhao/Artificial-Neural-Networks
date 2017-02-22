%% define input patterns
clear;
pict;
p = [p1' p2' p3'];
pd = p22';
pc = pd;
epochs = 4000;

%% calculate weights and update patterns
w = (p*p')/size(p, 1);
% w = normrnd(0, 1, size(p, 1), size(p, 1));
% w = 0.5*(w + w');

E = zeros(1, epochs);
for i = 1 : epochs
    index = randi([1 size(pc, 1)]);
    pc(index, :) = sgn(w(index, :)*pc);
    E(i) = -diag(pc'*w*pc);
end

%% plot
% pattern completion
figure(1)
subplot(1, 3, 1)
vis(pd)
title('degraded version');
subplot(1, 3, 2)
vis(pc)
title(sprintf('complete version, iteration = %d', epochs));
subplot(1, 3, 3)
vis(p3)
title('pattern 3');

% energy changes
figure(2)
plot(1 : epochs, E)
title('energy vs. epochs');
xlabel('epochs');
ylabel('energy');