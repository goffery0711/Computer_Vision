function [im0,im1] = do_log_filter(im0,im1,hsize)
% Laplacian of Gaussian filter
sigma = 0.5;
h = zeros(hsize,hsize);
% h1 = fspecial('log', hsize, sigma);
for x = -(hsize-1)/2:(hsize-1)/2
    for y = -(hsize-1)/2:(hsize-1)/2
        h(x+(hsize-1)/2+1,y+(hsize-1)/2+1) = ((x^2+y^2-2*sigma^2)/sigma^4)*exp(-(x^2+y^2)/2*sigma^2);
    end
end
h = h - sum(h(:))/hsize^2;
im0 = single(conv2(im0,h,'same'));
im1 = single(conv2(im1,h,'same'));
end