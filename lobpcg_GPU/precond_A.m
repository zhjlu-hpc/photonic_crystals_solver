
function Y = precond_A(X)

global ML MU

%ax =size(X)
%aml = size(ML)

  Y = MU*(ML*X);

%   Y = X;

end


