% im1 is a colorful picture with 3 channels
% D refers to the disparity
function plot_3D(D)
im1 = imread('im1.png');
I = ones(size(im1(:,:,1)));
Y = cumsum(I,2);
X = cumsum(I,1);
s = surf(X,Y,D,im1);
s.EdgeColor = 'none';
view(73.9,68.4);
title('3D plot');
end