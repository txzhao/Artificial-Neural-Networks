%% initial
data = read('cluster');
units = 5;
limx = [1 7];
limy = [1 7];
vqinit;
singlewinner = 1;   % 1: winner-take-all, 0: all to move

%% stepwise
while(1)
    m0 = m;
    var0 = var;
    vqstep;
    if (max(max(abs(m - m0))) <= 5*10^-3 && max(max(abs(var - var0))) <= 5*10^-3)
        break;
    end
    pause;
end

%% animation
% vqiter;