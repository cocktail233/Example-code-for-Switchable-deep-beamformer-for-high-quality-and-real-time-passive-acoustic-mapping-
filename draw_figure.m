clc
clear
close all

%%
EISRCB_path = 'imgs\EISRCB\';
DNN_path = 'imgs\DNN\';

trans_type = 3; % P4-1=1, L7-4=2, CL15-7=3

%%
if trans_type == 1
    x_range = [-10,0]; % the range for x axis of images
    z_range = [25,65]; % the range for z axis of images
elseif trans_type == 2
    x_range = [0,10]; % the range for x axis of images
    z_range = [40,60]; % the range for z axis of images    
elseif trans_type == 3
    x_range = [0,10]; % the range for x axis of images
    z_range = [20,30]; % the range for z axis of images    
end

%%
%-- load data
DNN_filename = [DNN_path, 'DNN_Img_Example.mat'];
EISRCB_filename = [EISRCB_path, 'EISRCB_Img_Example.mat']; 

load(DNN_filename);
load(EISRCB_filename);

%-- preprocess
EISRCB_Img = (EISRCB_Img + 1) / 2;
EISRCB_Img = EISRCB_Img / max(EISRCB_Img(:));
EISRCB_Img_dB = 10*log10(EISRCB_Img);

DNN_Img = (DNN_Img + 1) / 2;
DNN_Img = DNN_Img / max(DNN_Img(:));
DNN_Img_dB = 10*log10(DNN_Img);

[Nz, Nx] = size(DNN_Img);

%-- axis
if trans_type == 1 % P4-1
    dx = 0.3e-3 / 4;
    dz = 0.2e-3;
    x_axis = linspace(-Nx/2*dx,Nx/2*dx,Nx);
    z_axis = linspace(0,Nz*dz,Nz);
elseif trans_type == 2 % L7-4
    dx = 0.3e-3 / 4;
    dz = 0.1e-3;
    x_axis = linspace(-Nx/2*dx,Nx/2*dx,Nx);
    z_axis = linspace(0,Nz*dz,Nz) + 15e-3;        
elseif trans_type == 3 % CL15-7
    dx = 0.18e-3 / 4;
    dz = 0.08e-3;
    x_axis = linspace(-Nx/2*dx,Nx/2*dx,Nx);
    z_axis = linspace(0,Nz*dz,Nz) + 10e-3;       
end

%-- DNN
figure(1)
imagesc(x_axis*1e3,z_axis*1e3,DNN_Img_dB)
xlim(x_range)
ylim(z_range)
xlabel('x(mm)')
ylabel('z(mm)')
caxis([-20,0])
colorbar
colormap(jet)
set(gcf,'Position',[100 100 250 400]);

%-- EISRCB
figure(2)
imagesc(x_axis*1e3,z_axis*1e3,EISRCB_Img_dB)
xlim(x_range)
ylim(z_range)
xlabel('x(mm)')
ylabel('z(mm)')
caxis([-20,0])
colorbar
colormap(jet)
set(gcf,'Position',[500 100 250 400]);

