%% Computer Vision Challenge 2019
clear, clc, close all
% Group number:
group_number = 30;

% Group members:
members = {'Hangze Gao','Yansong Wu','Zhen Zhou','Yuetao Wu','Zibo Zhou'};

% Email-Address (from Moodle!):
mail = {'ge82hac@mytum.de','ge82kop@mytum.de','ge82haf@mytum.de','yuetao.wu@tum.de','zibo.zhou@tum.de'};

%% Start timer here
tic();


%% Disparity Map
% Specify path to scene folder containing img0 img1 and calib
scene_path = '/Users/goffery/Desktop/terrace/';
% 
% Calculate disparity map and Euclidean motion
[D, R, T] = disparity_map(scene_path);

%% Validation
% Specify path to ground truth disparity map
gt_path = scene_path;
%
% Load the ground truth
G = pfmread(strcat(gt_path,'disp0.pfm'));
% 
% Estimate the quality of the calculated disparity map
p = verify_dmap(D, G);

%% Stop timer here
elapsed_time = toc();


%% Print Results
% R, T, p, elapsed_time
fprintf('The rotation matrix R is \n');
disp(R);
fprintf('The displacement vector T is (meter)\n');
disp(T);
fprintf('The psnr between calculated disparity map and ground truth is %.4fdB \n',p);
fprintf('The elapsed time is %fs. \n',elapsed_time);

%% Display Disparity
figure,imshow([uint8(G),D],[]);
title(['Ground Truth and',32,'Disparity Map (',scene_path(1:end-1),')']), colormap('jet'), colorbar;

% save the results
% saveas(1,strcat(scene_path,['Disparity Map(',scene_path(1:end-1),')'],32,'psnr_',32,num2str(p),'dB.png'));

%% 3D plot
figure,plot_3D(D);
% saveas(2,strcat(scene_path,['Disparity Map(',scene_path(1:end-1),')'],32,'3D plot.png'));
save('var'); % save parameters for unittest