
clear all
close all
clc

cd code

%%  Introduction
% The purpose of assignment 4 is to use modified nodal analysis to simulate
% the two circuits given to me. 


%% Part 1 Introduction 
% For part 1 I created the G and C by performing modified nodal analysis on 
% the circuit given in figure 1 of the assignment.  The next objective was
% to sweep the input voltage from -10V to 10V and plot the output voltage 
% and the voltage at node 3.  The next objective was to plot the gain of 
% the circuit in dB as a function of angular frequency.  The final objective
% was to plot the input voltage and output voltage in the time 
% and frequency domain for the following input voltage signals. 
% 
% A. A step that transitions from 0 to 1 at 0.03s. 
% 
% B. A sin(2(pi)f t) function with f = 1/(0.03) 1/s. Try a few other
% frequencies. Comment. 
% 
% C. A Gaussian pulse with a magnitude of 1, std dev. of 0.03s and 
% a delay of 0.1s.



%% Part 1 Figures and Command Line Outputs

cd part1

part1

cd ..   


%% Part 1 Conclusion
% When looking at the gain as a function of angular frequency, it can be 
% concluded that the circuit is a low pass filter. With a low pass filter,
% you would expect low frequencies to be transmitted and high frequencies
% to be attenuated. All the plots generated for part one are as expected. 
% When looking at the DC sweep both the output voltage and the voltage
% at node 3 increase linearly with the input voltage, which makes sense 
% because the circuit is linear.


%% Part 2 Introduction 
% For part 2 I created the G and C by performing modified nodal analysis 
% on the circuit given in figure 2 of the assignment where In=0.001*randn()
% and Cn=0.00001.  The next objective was to plot the input voltage
% and output voltage in the time and frequency domain for a Gaussian
% pulse input voltage. 3 Plots of the output voltage with different
% values of Cn were created. Final 3 Plots of the output voltage with 
% different time steps were created.

%% Part 2 Figures and Command Line Outputs

cd part2

part2

cd ..   


%% Part 2 Conclusion
%  The results of part two are as expected. When a capacitor (Cn) and 
%  current source (In) were added to the circuit in parallel with
%  R3 thermal noise was visible in the output signal frequency and 
%  time domain representation. When the value of Cn has increased the 
%  bandwidth of the noise was seen to decrease. One of the effects of 
%  increasing the time step is that the output signal becomes more
%  distorted. This means to perform the best analysis a small time
%  step should be used. Another effect of increasing the time step is 
%  that the current of In changes less frequently meaning less
%  thermal noise is visible.   

%% How part 3 would be implemented 
% The first step would be to add the none linear parts of the circuit 
% into a matrix called B so that the final equation for the circuit 
% can be written in the form
%  
% $$ C\frac{dV}{dt}+G\widehat{V}+\widehat{B}(\widehat{V})=\widehat{F}(t) $$
% 
% Next, you need to form the Jacobian (J)  which is the partial derivative 
% of each of the equations in the B matrix with respect to the variables 
% in the V matrix.  
% 
% Next, rearrange the equation and put the matrix in the form as shown below
% 
% $$ \left (  \frac{\widehat{C}}{\Delta t}+\widehat{G}\right ) \widehat{V_{n}}-\frac{C}{\Delta t}\widehat{V_{n-1}}-\widehat{B}(\widehat{V})-\widehat{F}(t) =0$$
% 
% Using the above equation, the Jacobian, and Newton Raphson method the 
% voltage at each time step can be solved for. The plot of the output 
% and input signal in the time and frequency domain are given below 
% for a sin wave. 
 

%% Part 3 Figures and Command Line Outputs

cd part3

part3

cd ..   



%% Conclusion
% Overall Assignment 4 was a success. I was able to complete every 
% objective and my results matched my expectation. 