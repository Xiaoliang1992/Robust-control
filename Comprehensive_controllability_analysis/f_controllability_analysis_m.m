%���ڼ�������Ը���״̬�����Ӱ��
% IN : G (ϵͳ), omega (��ɢƵ�ʵ�), size m*n��[������� �������]��
% OUT: omega(Ƶ��) res (��Ӧ���)
function [omega, res, condition_num, rga] = f_controllability_analysis_m(G, omega)
% Input-output contollability analysis
N = length(omega);
[m,n] = size(G);
if m < n
   t = m;
   n = t;
   m = n;
end
% omega = logspace(-2,-1,N);
res = zeros(m,N);
condition_num = zeros(1,N);
rga = zeros(1,N);
svd_value = zeros(1,n);
for i = 1:N
    H = freqresp(G,omega(i));
    rga(i) = sum(sum(abs(H.*(pinv(H))')));
    [U,S,~] = svd(H);
    for j = 1:n
        svd_value(j) = S(j,j);
    end
    U1 = U(:,1:n);
    for j = 1:n
        U1(:,j) = U1(:,j)*svd_value(j);
    end
    for j = 1:m
        res(j,i) = f_lpmax(U1(j,:)');
    end
    condition_num(i) = max(svd_value)/min(svd_value);
%     condition_num(i) = cond(H);
end
end


function ymax = f_lpmax(x)
ymax = sum(abs(x));
end