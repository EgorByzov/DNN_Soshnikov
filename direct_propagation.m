function [ Fields ] = direct_propagation( First_Field, Propogations, DOES )
    N = size(First_Field,1);
    Fields = single(zeros(N,N,length(Propogations)+1,size(First_Field,3)));
    Fields(:,:,1,:) = First_Field;
    for iter=1:size(Fields,3)-1
        Fields(:,:,iter+1,:) = Propogations{iter}(bsxfun(@times,Fields(:,:,iter,:),DOES(:,:,iter)));
    end
end

