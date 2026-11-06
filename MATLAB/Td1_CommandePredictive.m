clc
clear all
close all
num_sys=50;
denum_sys=[0.72 2.42 2.7 1]
num_d=1
denum_d=[0.72 2.42 2.7 1]
H_sysc=tf(num_sys,denum_sys)
H_dc=tf(num_d,denum_d)
Te=0.5
sys_d=c2d(H_sysc,Te)
pert_d=c2d(H_dc,Te)
Htf=[sys_d pert_d]
Hplant=ss(Htf)
mpcDesigner




