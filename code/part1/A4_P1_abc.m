
close all;
clear all;
clc;

% Parameters
R1 = 1;
R2 = 2;
R3 = 10;
R4 = 0.1;
RO = 1000;
C1 = 0.25;
L1 = 0.2;
alpha = 100;

% V = [ V1; V2; V3; V4; V5; IL]
Vin=1;
G=zeros(6);
C=zeros(6);

% V1
G(1,:)=[1 0 0 0 0 0]; % V1
C(1,:)=[0 0 0 0 0 0]; % V1

% V2
G(2,:)=[(-1/R1) (1/R2+1/R1) 0 0 0 1]; 
C(2,:)=[-C1 +C1 0 0 0 0];

% V3
G(3,:)=[0 0 1/R3 0 0 -1]; 
C(3,:)=[0 0 0 0 0 0]; 

% V4
G(4,:)=[0 0 -1*alpha/R3 1 0 0]; 
C(4,:)=[0 0 0 0 0 0]; 

% V5
G(5,:)=[0 0 0 -1/R4 (1/R4+1/RO) 0]; 
C(5,:)=[0 0 0 0 0 0];

% V6
G(6,:)=[0 -1 1 0 0 0]; 
C(6,:)=[0 0 0 0 0 L1]; 




numsteps=100;
Data=zeros(3,numsteps);
Data(1,:)=linspace(-10,10,numsteps);
for ii=1:numsteps
    % omega=0 for DC
    F=[Data(1,ii); 0; 0; 0; 0; 0];
    V=G\F;
    Data(2,ii)=V(5);
    Data(3,ii)=V(3);
end

G

C

figure(1)
hold on;
plot(Data(1,:),Data(2,:));
plot(Data(1,:),Data(3,:));
hold off;
legend('V_O','V_3');
title('Voltage as a Function of Input Voltage');
ylabel('Voltage (V)');
xlabel('V_i (V)');




% Part c
numsteps=2000;
Data2=zeros(2,numsteps);
Data2(1,:)=linspace(0,500,numsteps);
Vin=1;
for ii=1:numsteps
    % omega=0 for DC
    omega=Data2(1,ii);
    F=[Vin; 0; 0; 0; 0; 0];
    V=(G+1j*omega*C)\F;
    Data2(2,ii)=V(5);
    %Data2(3,ii)=Data2(2,ii)/Data2(1,ii);
end

figure(2)
semilogx(Data2(1,:),20*log10(abs(Data2(2,:)./Vin)));
title('Gain as a Function of Angular Frequency');
legend('V_O/V_i');
ylabel('Gain (dB)')
xlabel('\omega (radians/s)');


