
function mm = inner_product(U,M,V)

if isempty(M)
    mm = sum(conj(U).*V,1);
else
    mm = sum(conj(U).*(M*V),1);
end

end





