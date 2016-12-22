%% Simulate data
% y = theta * s + e;
% e ~ N(0,1)
% prior probablity of theta: theta ~ N(0,3)

s = 10*ones(10,1);
y = 2*s + randn(10,1);


%% Metropolis Hasting

theta0 = rand;
p0 = normpdf(theta0,0,3);
FF = theta0 * 10*ones(1000,1) + randn(1000,1);
LL0 = prod(arrayfun(@(t) sum((FF<(t + 2)) & (FF >= (t - 2)))/length(FF),y));

theta_propos = normrand(theta0,1);




