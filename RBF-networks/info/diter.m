function residual = diter(x, m, var, Iter, F, units, fun, eta, verbose)
% Function approximation with gaussian RBF
% Do iterative improvement according to the delta rule

% Input:
% x	: data training vector
% units : number of RBF units
% m	: vector of RBF positions
% var	: vector of RBF variances
% Iter	: array with iter, itersub, itermax
% F	: array with fmin, fmax
% fun: name of the mapping
% eta: learning rate 
% verbose: sign of plotting - 0: no plot, 1: plot

clf
hold on

global w;
iter = Iter(1);
itersub = Iter(2);
itermax = Iter(3);
fmin = F(1);
fmax = F(2);
if (nargin < 9) 
    verbose = 1; 
end

Phi = calcPhi(x, m, var);
f = feval(fun, x);
y = x;
alg = 'Stochastic';
iterstart = iter;
iterstop = iter + itermax;
psum = zeros(1, itermax/itersub);
Eta = eta(1);
while iter < iterstop
  substop = iter + itersub;
  esum = 0;
  while iter < substop
      iter = iter + 1;
      rx = fmin + (fmax - fmin)*rand;
      rphi = gauss(rx, m, var);
      ry = rphi'*w;
      err = feval(fun, rx) - ry;
      w = w + Eta*err*rphi;
      esum = esum + sqrt(sum(err.*err));
%       print(sqrt(sum(err.*err)))
      if size(eta, 1) > 1 && sqrt(sum(err.*err)) < 1.2
          Eta = eta(2);
      else
          Eta = eta(1);
      end
  end
  psum((iter - iterstart)/itersub) = esum;

y = Phi*w;

if verbose == 1
    subplot(3, 1, 1); plot(iterstart + 1 : itersub : iterstop, log(psum));
    title(['RBF-units = ' int2str(units) ', ' alg ': log(error vs iter)']);
    subplot(3, 1, 2); plot(x, y, x, f); title('Function y and desired y');
    subplot(3, 1, 3); plot(x, f - y);
    title(['Residual, max = ' num2str(max(abs(f - y)))]);
    pause(0);
end

end
iter = iterstop;

y = Phi*w;

if verbose == 1
    subplot(3, 1, 1); plot(iterstart + 1 : itersub : iterstop, log(psum));
    title(['RBF-units = ' int2str(units) ', ' alg ': log(error vs iter)']);
    subplot(3, 1, 2); plot(x, y, x, f);title('Function y and desired y');
    subplot(3, 1, 3); plot(x, f - y);

    title(['Residual, max= ' num2str(max(abs(f - y)))]);
end

residual = max(abs(f - y));
%Find the actual output by using the calculated weight vector

end