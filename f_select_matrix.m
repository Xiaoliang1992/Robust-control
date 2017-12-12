function sels = f_select_matrix(iy,n)
N = length(iy);
sels = zeros(N,n);
for i = 1:N
    sels(i,iy(i)) = 1;
end