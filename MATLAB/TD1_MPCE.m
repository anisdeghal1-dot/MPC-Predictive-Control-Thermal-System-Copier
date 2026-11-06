clc
clear all
close all
load('model_simulink.mat', 'mpc1_1_C')
Hplant=mpc1_1_C.Model.Plant
Te=Hplant.Ts
range = generateExplicitRange(mpc1_1_C)
range.State.Min(:) = -10;
range.State.Max(:) = 20;
range.Reference.Min = -1;
range.Reference.Max = 21;
range.ManipulatedVariable.Min = -0.5;
range.ManipulatedVariable.Max = 1;
opt = generateExplicitOptions(mpc1_1_C)
opt.polyreduction = 2
mpc1E = generateExplicitMPC(mpc1_1_C,range)
save mpc1E

