# Computer Vision Challenge

## Overview 

This project aims at calculating a disparity map based on two rectified stereo images and showing its corresponding 3D image.

## Approach to achieve this goal :

Block matching based on SAD. We apply multi-window by using variable convolution kernels.

## Sofetware
 
MATLAB 

## Input fotmat

The inputs each picture should be placed separately in the same folder. The names of the folders are motorcycle, playground,
sword and terrace. Each folder contains such files, i.e. calib.txt, disp0.pfm, im0.png and im1.png.

## Structure 

The main function is called challenge.m, where you can set the inital values of the parameters.  During the implementation of 
challenge.m, it will call the functions disparity_map.m, pfmread.m, verify_dmap.m and plot_3D in turn.

The do_log_filter.m is used for filtering the image with Laplace of Gaussian.
The pfmread.m is a function, that reads pfm file into double precision.
The function plot_3D.m can display the image into 3 dimension with disparity map as the tired dimension.

## Operating procedures

First, run start_gui.m in Matlab. Then select an image in the pull-down menu. Click the buttons in turn to get the desired result.

## Unittest

Before using the test.m, please operate the challenge.m. Then run the test.m to check the functions variables and psnr. After 
running the challeng.m, we will storage all the variables from challeng.m in vars.mat, then for the test part the variables from 
challenge.m can be used.