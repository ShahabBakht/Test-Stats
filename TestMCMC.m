%% Simulate data
% y = theta * s + e;
% e ~ N(0,1)
% prior probablity of theta: theta ~ N(0,3)

s = 1*rand(10,1);
y = (-2*s) + randn(10,1);


%% Metropolis Hasting
radii = 1;

theta0 = rand;
p0 = normpdf(theta0,0,3);
FF = (theta0 * 1*rand(1000,1)) + randn(1000,1);
LL0 = prod(arrayfun(@(t) sum((FF<(t + 2)) & (FF >= (t - 2)))/length(FF),y));
p0_post = LL0 * p0;

theta_hat(1) = theta0;
p_post(1) = p0_post;

for iter = 1:1e4
theta_propos = normrnd(theta_hat(iter),.1);
p = normpdf(theta_propos,0,3);
FF = (theta_propos * 1*rand(1000,1)) + randn(1000,1);
LL = prod(arrayfun(@(t) sum((FF<(t + radii)) & (FF >= (t - radii)))/length(FF),y));
p_post(iter+1) = LL * p;

if p_post(iter+1) > p_post(iter)
    theta_hat(iter+1) = theta_propos;
elseif p_post(iter+1) == 0
    theta_hat(iter+1) = theta_hat(iter);
else
    if rand > p_post(iter+1)/p_post(iter)
        theta_hat(iter+1) = theta_propos;
    else
        theta_hat(iter+1) = theta_hat(iter);
    end
end

end
    








