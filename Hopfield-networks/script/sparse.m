%% initialize input patterns
clear;
units = 300;
patterns = 100;
rho = 0.05;
itermax = 100;
Theta = 0 : 0.01 : 20;

%% calculate weights and update patterns
nc = zeros(1, size(Theta, 2));
epochs = 0;
for theta = Theta
    epochs = epochs + 1;
    X = [];
    for p = 1 : patterns
        x = zeros(units, 1);
        index = randperm(units, round(rho*units));
        x(index) = 1;
        X = [X x];
        X0 = X;
        
        w = (X - rho)*(X - rho)';
        % remove self-connections
        w = w - diag(diag(w));
        
        iter = 0;
        while(1)
            iter = iter + 1;
            x_prev = X;
            X = 0.5*sgn(w*X - theta) + 0.5;
            % if reach a stable fixpoint
            if rank(X - x_prev) == 0
                break;
            end
            % if too many iterations
            if iter >= itermax
                break;
            end
        end

        % count patterns stored
        if rank(X - X0) == 0
            continue;
        else
            nc(epochs) = p - 1;
            break;
        end
    end
end

plot(Theta, nc)