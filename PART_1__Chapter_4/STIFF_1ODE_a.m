%% STIFF_1ODE_a.m
% Simple Stiff ODE problem: y'=-100y with y(0)=1;
% Analytic solution of the problem is y(t)=exp(-100t).
% EULER-Forward Method:
close all; clearvars
y0=1;               % Initial Condition
dt1=1.5e-2;      % Time step: 1st try
dt2=0.75e-2;    % Time step: 2nd try
tstart=0;           % Start of simulation 
tend=0.15;       % End of simulation time

t1=tstart:dt1:tend;    % Time space for 1st try
t2=tstart:dt2:tend;    % Time space for 2nd try

steps1=length(t1);     % 1st Iteration cycle 
f=@(y)(-100*y); 
y=[y0, zeros(1,steps1-1)];
h=dt1;
for ii=1:steps1-1
    y(ii+1)=y(ii)+f(y(ii))*h;
end
figure, plot(t1, y, 'bo-'); hold on
steps2=length(t2);     % 2nd Iteration cycle 
y=[y(1), zeros(1,steps2-1)];
h=dt2;
for ii=1:steps2-1
    y(ii+1)=y(ii)+f(y(ii))*h;
end
plot(t2, y, 'rd-')
Y=dsolve('Dy=-100*y', 'y(0)=1', 't');
YY=vectorize(Y);
t=t1; 
YY=eval(YY);
plot( t1, YY, 'k-', 'linewidth',1.5)
legend('EULER-forward: h=1.5e-2', 'EULER-forward: h=0.75e-2',...
'dsolve (solution)')
title('\it Solutions of Stiff Problem: $$ \frac{dy}{dt}=-100*y, y_0=1 $$', 'interpreter', 'latex')
xlabel('t'), ylabel 'y(t)'
xlim([0, .15])
%% RUNGE-KUTTA Method of 4th Order via SCRIPT
u(1)=1;      % IC: u(0)=1 starting at the index of 1
u=[u(1), zeros(1,steps2-1)];
for ii=1:steps2-1
k1=f(u(ii));
k2=f(u(ii)+h*k1(:,1)/2);
k3=f(u(ii)+h*k2(:,1)/2);
k4=f(u(ii)+h*k3(:,1));
u(ii+1)=u(ii)+h*(k1+2*k2+2*k3+k4)/6;
end
plot(t2, u, 'mp--', 'linewidth',1.0)
legend('EULER-forward: h=0.015', 'EULER-forward: h=0.0075',...
'dsolve (solution)', 'Runge-Kutta: h=0.0075'), grid on
hold off
