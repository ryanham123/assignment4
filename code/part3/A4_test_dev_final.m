

clear all;
clc;

warning('off')
% Parameters
R1 = 1;
R2 = 2;
R3 = 10;
R4 = 0.1;
RO = 1000;
C1 = 0.25;
L1 = 0.2;
alpha = 100;
beta=5e6;
gamma=5e9;

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
C(3,:)=[0 0 0 0 0 0]; 

%% V4
G(4,:)=[0 0 -1*alpha/R3 1 0 0]; 
C(4,:)=[0 0 0 0 0 0]; 

%% V5
G(5,:)=[0 0 0 -1/R4 (1/R4+1/RO) 0]; 
C(5,:)=[0 0 0 0 0 0];

%% V6
G(6,:)=[0 -1 1 0 0 0]; 
C(6,:)=[0 0 0 0 0 L1]; 



%% Part A step response


timesim=1; % sec
numsteps=1000;

timestep=timesim/numsteps;

A=(C./timestep+G);

f=1/0.09;

V(1:6,1)=[0;0;0;0;0;0];
Vminus=V;

for step=1:numsteps

    t=step*timestep;
    
    Vin=sin(2*pi*f*t);
    
    F=[Vin; 0; 0; 0; 0; 0];
    

    numnewton=0;
    
    while(numnewton<150)
        
        I3=V(6);
        
        dv4=-2*beta*I3-3*gamma*I3.^2;
    
        J=[0,0,0,0,0,0;...
           0,0,0,0,0,0;...
           0,0,0,0,0,0;...
           0,0,dv4,0,0,0;...
           0,0,0,0,0,0;...
           0,0,0,0,0,0];
       
        B=[0; 0; 0; beta*I3.^2+gamma*I3.^3; 0; 0;];

        f_V=(C./timestep+G)*V-(C./timestep)*Vminus-F-B;
        
        H=C./timestep+G-J;
        
        dV=-inv(H)*f_V;
        
        V=V+dV;

        
        if(max(abs(dV))<5e-4)
            
            break;
            
        end
        
        numnewton=numnewton+1;
    
    end
    
    Vin_save(step)=V(1,1);
    Vout_save(step)=V(5,1);
    Vminus=V;
    
end

figure(3)
plot(linspace(0,timesim,numsteps),Vin_save)
title('Input Voltage: Step Response')
xlabel('Time (s)')
ylabel('Voltage (V)')


figure(4)
plot(linspace(0,timesim,numsteps),Vout_save)
title('Output Voltage: Step Response')
xlabel('Time (s)')
ylabel('Voltage (V)')

Yi = fft(Vin_save);
Yo = fft(Vout_save);

figure(5)
plot(linspace(-1/timestep*0.5,1/timestep*0.5,length(Yi)),fftshift(abs(Yi)))
title('Input Frequency Content: Step Response')
xlabel('Frequency (Hz)')
ylabel('Power')

figure(6)
plot(linspace(-1/timestep*0.5,1/timestep*0.5,length(Yo)),fftshift(abs(Yo)))
title('Output Frequency Content: Step Response')
xlabel('Frequency (Hz)')
ylabel('Power')




