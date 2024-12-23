
function [Aem,Bem] = shift_value_matrices(K,A_shift,B_shift,A_pat,B_pat)

Ae = spfun(@exp,K(1)*A_shift.x + K(2)*A_shift.y + K(3)*A_shift.z);
Be = spfun(@exp,K(1)*B_shift.x + K(2)*B_shift.y + K(3)*B_shift.z);
%%%%%%
Ae_pat = (Ae~=0);
A_Ae_pat = A_pat - Ae_pat;
Aem = Ae + A_Ae_pat;

Be_pat = (Be~=0);
B_Be_pat = B_pat - Be_pat;
Bem = Be + B_Be_pat;


end