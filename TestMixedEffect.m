%% Generate synthetic data

% subjects are different in the coefficients and intercept
% conditions are different in the noise variance
DATA(1,:) = 2*rand(10,1) - 1;
DATA(2,:) = 1 * DATA(1,:) - .1; % subject 1 - condition 1
DATA(3,:) = 2*rand(10,1) - 1;
DATA(4,:) = .5 * DATA(3,:) - 1; % subject 2 - condition 1
DATA(5,:) = 2*rand(10,1) - 1;
DATA(6,:) = 1 * DATA(5,:) - .1; % subject 1 - condition 2
DATA(7,:) = 2*rand(10,1) - 1;
DATA(8,:) = .5 * DATA(7,:) - 1; % subject 2 - condition 2

% adding noise
DATA(2,:) = DATA(2,:) + normrnd(zeros(1,10),.1*ones(1,10));
DATA(4,:) = DATA(4,:) + normrnd(zeros(1,10),.1*ones(1,10));
DATA(6,:) = DATA(6,:) + normrnd(zeros(1,10),.5*ones(1,10));
DATA(8,:) = DATA(8,:) + normrnd(zeros(1,10),.5*ones(1,10));


%% group subjects togehter - different variables for different conditions
% (X1,Y1,C1): condition one, (X2,Y2,C2): condition two
X1 = [DATA(1,:),DATA(3,:)];X2 = [DATA(5,:),DATA(7,:)];
Y1 = [DATA(2,:),DATA(4,:)];Y2 = [DATA(6,:),DATA(8,:)];
C1 = [zeros(1,10),ones(1,10)];C2 = [zeros(1,10),ones(1,10)];

%% fit mixed-effect linear model to two conditions
tbl1 = table(X1',Y1',C1','VariableNames',{'X','Y','Subject'});
lme1 = fitlme(tbl1,'Y~X+(X-1|Subject)+(1|Subject)');

tbl2 = table(X2',Y2',C2','VariableNames',{'X','Y','Subject'});
lme2 = fitlme(tbl2,'Y~X+(X-1|Subject)+(1|Subject)');

