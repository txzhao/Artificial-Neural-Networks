function [X, iter] = patRecal(X, W, itermax)
iter = 0;
while(1)
    iter = iter + 1;
    X_prev = X;
    X = sgn(W*X);
    % if reach a stable fixpoint
    if rank(X - X_prev) == 0
        break;
    end
    % if too many iterations
    if nargin == 3 && iter >= itermax
        break;
    end
end