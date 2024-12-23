
function AX = operatorAs(X)

global As Bs BsT alpha inX

AX = As*X + 1*alpha*(BsT*(Bs*X));

% inX = Bs*X;
% inX = BsT*inX;
% inX = alpha*inX;
% 
% AX = As*X;
% AX = AX + inX;

end
