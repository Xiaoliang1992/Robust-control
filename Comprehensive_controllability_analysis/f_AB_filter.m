function [A,B] = f_AB_filter(A,B)
[m,n] = size(A);
for i = 1:m
    for j = 1:n
        if abs(A(i,j)) < 1e-3;
            A(i,j) = 0;
        end
    end
end

[m,n] = size(B);
for i = 1:m
    for j = 1:n
        if abs(B(i,j)) < 1e-3;
            B(i,j) = 0;
        end
    end
end