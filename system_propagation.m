function F = system_propagation(Input, DOES, z, k, U)
    N = size(Input,1);
    F = zeros(N,N,length(z));
    
    % direct propagation
    F(:,:,1) = propagation(Input, z(1), k, U);
    for iter=1:length(z)-1
        F(:,:,iter+1) = propagation(F(:,:,iter).*DOES(:,:,iter), z(iter+1)-z(iter), k, U);
    end
end

