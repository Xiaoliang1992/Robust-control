function sig = f_sigma(omega, sys)
N = length(omega);
[m,n] = size(sys);
sig = zeros(n,N);
ns = min([m,n]);
for i = 1:N
    H = freqresp(sys,omega(i));
    [~,S,~] = svd(H);
    for j = 1:ns
        sig(j,i) = S(j,j);
    end
end
