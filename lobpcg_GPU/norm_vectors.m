
function aa = norm_vectors(X,M)

if isempty(M)
    
    aa = sqrt(sum(conj(X).*X,1));
    
else
    
    aa = sqrt(abs(sum(conj(X).*(M*X),1)));
    
end

end




