
function [Ys,rho] = Rayleigh_Ritz_vector_no_mask(As,Bs, eigNum, activeNum,activeMask,k)



if strcmpi(class(As),'gpuArray')

    As = gather(As);
    Bs = gather(Bs);

    eigNum = gather(eigNum);
    activeNum = gather(activeNum);
    activeMask = gather(activeMask);
    k = gather(k);
    
end



I0 = true(1,eigNum);
if k == 1
    II = [I0,activeMask];
else
    II = [I0,activeMask,activeMask,];
end
As = As(II,II);
Bs = Bs(II,II);




[Y,Lam] = eig(full(As),full(Bs));


Lam = real(Lam);

Lam = diag(Lam);

%ROW0 = [abs(Lam), [1:size(As,1)]'];

ROW0 = [Lam, [1:size(As,1)]'];

ROW = sortrows(ROW0,1);

index = ROW([1:eigNum],2);
rho = Lam(index);

%
Ys = Y(:,index);

%pause

% if k == 1
%     Ys.X = Y([1:eigNum],index);
%     Ys.W = Y([eigNum + 1 : eigNum + activeNum],index);
% else
%     Ys.X = Y([1:eigNum],index);
%     Ys.W = Y([eigNum + 1 : eigNum + activeNum],index);
%     Ys.P = Y([eigNum + activeNum + 1 : eigNum + 2*activeNum],index);
% end


if strcmpi(class(As),'gpuArray')
    
    Ys = gpuArray(Ys);
    rho = gpuArray(rho);
    
end




end














