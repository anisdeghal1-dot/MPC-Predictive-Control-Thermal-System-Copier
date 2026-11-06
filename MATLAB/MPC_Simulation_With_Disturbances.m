clc
close all
clear all
load variables.mat
%% create MPC controller object with sample time
mpc1 = mpc(Hplant_C, 0.5);
%% specify prediction horizon
mpc1.PredictionHorizon = 10;
%% specify control horizon
mpc1.ControlHorizon = 10;
%% specify nominal values for inputs and outputs
mpc1.Model.Nominal.U = [0;0];
mpc1.Model.Nominal.Y = 0;
%% specify constraints for MV and MV Rate
mpc1.MV(1).Min = 0;
mpc1.MV(1).Max = 0.6;
%% specify overall adjustment factor applied to weights
beta = 0.85214;
%% specify weights
mpc1.Weights.MV = 0*beta;
mpc1.Weights.MVRate = 0.1/beta;
mpc1.Weights.OV = 1*beta;
mpc1.Weights.ECR = 100000;
%% specify overall adjustment factor applied to estimation model gains
alpha = 10;
%% adjust default output disturbance model gains
setoutdist(mpc1, 'model', getoutdist(mpc1)*alpha);
%% adjust default measurement noise model gains
mpc1.Model.Noise = mpc1.Model.Noise/alpha;
%% specify simulation options
options = mpcsimopt();
options.OutputNoise = mpc1_ODSignal;
options.InputNoise = mpc1_LDSignal;
options.RefLookAhead = 'on';
options.MDLookAhead = 'off';
options.Constraints = 'off';
options.OpenLoop = 'off';
%% run simulation
sim(mpc1, 201, mpc1_RefSignal, mpc1_MDSignal, options);
[y,t,u]=sim(mpc1,201,mpc1_RefSignal,mpc1_MDSignal,options);
figure
subplot 311
plot(t,mpc1_RefSignal,t,y+mpc1_ODSignal,t,mpc1_ODSignal)
subplot 312
stairs(t,u)
hold on
stairs(t,mpc1_LDSignal)
hold off
subplot 313
plot(t,mpc1_MDSignal)
