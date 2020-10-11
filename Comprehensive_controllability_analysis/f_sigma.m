function sig = f_sigma(omega, sys)
N = length(omega);
[~,n] = size(sys);
sig = zeros(n,N);
for i = 1:N
    H = freqresp(sys,omega(i));
    [~,S,~] = svd(H);
    for j = 1:n
        sig(j,i) = S(j,j);
    end
end
