
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

Cn=0.00001;
% % Cn=0.0001;
%Cn=0.000001;

% V = [ V1; V2; V3; V4; V5; IL]
Vin=1;
G=zeros(6);
C=zeros(6);

%% V1
G(1,:)=[1 0 0 0 0 0]; % V1
C(1,:)=[0 0 0 0 0 0]; % V1

%% V2
G(2,:)=[(-1/R1) (1/R2+1/R1) 0 0 0 1]; 
C(2,:)=[-C1 +C1 0 0 0 0];

%% V3
G(3,:)=[0 0 1/R3 0 0 -1]; 
C(3,:)=[0 0 Cn 0 0 0]; 

%% V4
G(4,:)=[0 0 -1*alpha/R3 1 0 0]; 
C(4,:)=[0 0 0 0 0 0]; 

%% V5
G(5,:)=[0 0 0 -1/R4 (1/R4+1/RO) 0]; 
C(5,:)=[0 0 0 0 0 0];

%% V6
G(6,:)=[0 -1 1 0 0 0]; 
C(6,:)=[0 0 0 0 0 L1]; 




%% Part C gause


timesim=1; % sec
numsteps=1000;

f=1/0.03;

timestep=timesim/numsteps;

A=(C./timestep+G);

clear V

V(1:6,1)=[0;0;0;0;0;0];

t=linspace(0,timesim,numsteps);

Pulse=@(t) exp(-(t-0.1)^2/(2.*0.03^2));


%fplot(Pulse,[0 1])


for step=1:numsteps
    
    In=randn()*0.001;
    
    t=step*timestep;
    
    Vin=Pulse(t);
    
    F=[Vin; 0; -In; 0; 0; 0];
    
    B=C*V(1:6,step)./timestep+F;
    
    V(1:6,step+1)=A\B;
    

end

Yi = fft(V(1,:));
Yo = fft(V(5,:));

figure(17)
plot(linspace(-1/timestep*0.5,1/timestep*0.5,length(Yi)),fftshift(abs(Yi)))
title('Input Frequency Content: Gaussian Pulse')
xlabel('Frequency (Hz)')
ylabel('Power')

figure(18)
plot(linspace(-1/timestep*0.5,1/timestep*0.5,length(Yo)),fftshift(abs(Yo)))
title('Output Frequency Content: Gaussian Pulse')
xlabel('Frequency (Hz)')
ylabel('Power')
% 
% figure(5)
% plot(fftshift(log(abs(Yo./Yi))*20))
% xlim([487 514])
