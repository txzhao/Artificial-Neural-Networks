%% initial
clear;
[xtrain ytrain]=readxy('ballist', 2, 2);
[xtest ytest]=readxy('balltest', 2, 2);

LOWPASS = 0;
units = 20;
singlewinner = 1;
limx = [-0.5 1.5];
limy = [-0.5 1.5];

% lowpass input during training
% para: [passband freq, stopband freq, passband ripple, stopband attenuation]
if LOWPASS == 1
    para = 100;
    xtrain_low = lowpass(xtrain, para);
%     ytrain_low = lowpass(ytrain, para);
    ytrain_low = ytrain;
end

% display input data before and after filtering
% figure
% subplot(1,2,1)
% plotdata2(0, xtrain);
% xlim([limx(1) limx(2)]);
% ylim([limy(1) limy(2)]);
% subplot(1,2,2)
% plotdata2(0, xtrain_low);
% xlim([limx(1) limx(2)]);
% ylim([limy(1) limy(2)]);

if LOWPASS == 1
    data = xtrain_low;
else
    data = xtrain;
end

vqinit;
emiterb

%% calculate matrix phi
Phi = calcPhi(xtrain, m, var);
if LOWPASS == 1
    d1 = ytrain_low(:, 1);
    d2 = ytrain_low(:, 2);
else
    d1 = ytrain(:, 1); 
    d2 = ytrain(:, 2);
end
dtest1 = ytest(:, 1);
dtest2 = ytest(:, 2);

%% calculate weight and approximation
w1 = Phi\d1;
w2 = Phi\d2;

% approximation of training data
y1 = Phi*w1;
y2 = Phi*w2;

% approximation of test data
Phitest = calcPhi(xtest,m,var);
ytest1 = Phitest*w1;
ytest2 = Phitest*w2;

%% plot
figure
subplot(2, 2, 1)
xyplot(d1,y1,'train1');
subplot(2, 2, 2)
xyplot(d2,y2,'train2');
subplot(2, 2, 3)
xyplot(dtest1,ytest1,'test1');
subplot(2, 2, 4)
xyplot(dtest2,ytest2,'test2');
