function X = Normalize(X,M)


%%%%%%%%%%%  

% U = M*X;
% q = sqrt(sum(X.*U,1));

q = norm_vectors(X,M);

NN = size(X,1);
nn = size(X,2);

for i = 1:nn
    if q(i) < 10^(-15)
        X(:,i) = rand(NN,1)-0.5;
        q(i) = norm_vectors(X(:,i),M)
    end
end

X = X*diag(1./q);




end


