function p = verify_dmap(D, G)
% This function calculates the PSNR of a given disparity map and the ground
% truth. The value range of both is normalized to [0,255].
D = double(D);
mse = mean((D(:) - G(:)).^2);
p = 10 * log10((255 * 255)/mse);
end

