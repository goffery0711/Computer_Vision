function [D, R, T] = disparity_map(scene_path)
% This function receives the path to a scene folder and calculates the
% disparity map of the included stereo image pair. Also, the Euclidean
% motion is returned as Rotation R and Translation T.
addpath(scene_path);
delimiterIn = '=';
C = importdata('calib.txt',delimiterIn);
cam1 = str2num(C.textdata{2,2});
Baseline = C.data(2);
im0 = single(imread('im0.png'));
im1 = single(imread('im1.png'));
% im0 is the image we see using our left eye and im1 the right eye
%% Dealing with gray image in this case
if size(im0,3) == 3
    im0 = mean(im0,3);
    im1 = mean(im1,3);
end
%% D
% set the size of block/window size
% halfwin = input('Half size of the block = ');

disp0 = pfmread(strcat(scene_path,'disp0.pfm'));
halfwin = round(sqrt(size(im0,1)/9));
dmax = ceil(max(disp0(:)));
hsize = halfwin-1;
[im0,im1] = do_log_filter(im0,im1,hsize);
D = BM(im0,im1,halfwin,dmax,'left');
clear disp0;

%% R,T
R = eye(3);
T = [0;Baseline/1000;0]; % meter
end
function D = BM(im0,im1,halfwin,dmax,template_is)
[H,W] = size(im0);
% block matching
% compute window size
win = 2 * halfwin - 1;
% only shift the window within dmax pixels
% dmax = input('Maximum disparity dmax = ');
% compute the difference between two images
imgDiff = zeros(H,W,dmax+1,'single');
e = zeros(H,W,'single');

% u = [1:halfwin,halfwin-1:-1:1];
% core = 1/(win*win)*(u'*u);
core = ones(win,win,'single');
c1 = triu(ones(win,win,'single'),halfwin-1);
c2 = tril(ones(win,win,'single'),-halfwin+1);
dcore = core-(c1+c2);
h = zeros(win,win,'single');
h(1:halfwin,:) = 1;
v = zeros(win,win,'single');
v(:,1:halfwin) = 1;

if template_is == 'left'
    im0 = im0(:,end:-1:1);
    im1 = im1(:,end:-1:1);
    wait = waitbar(0,'please wait');
    for i=0:dmax
        e(:,1:(W-i))=abs(im0(:,1:(W-i))- im1(:,(i+1):W));
        imgDiff(:,:,i+1) = conv2(e,dcore,'same').*conv2(e,h,'same').*conv2(e,v,'same');
        str=['processing...',num2str(i/dmax*100),'%'];
        waitbar(i/dmax,wait,str)
    end
    delete(wait);
    [~,d] = min(imgDiff,[],3);
    D = d - 1;
    D = D(:,end:-1:1);
elseif template_is == 'right'
    wait = waitbar(0,'please wait');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % core = ones(win,win,'single');
    % for i=0:dmax
    %     e(:,1:(W-i))=abs(im1(:,1:(W-i))- im0(:,(i+1):W));
    %     imgDiff(:,:,i+1) = conv2(e,core,'same');
    %     fprintf('%.2f %% finished \n',(i/dmax)*100);
    % end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i=0:dmax
        e(:,1:(W-i))=abs(im1(:,1:(W-i))- im0(:,(i+1):W));
        imgDiff(:,:,i+1) = conv2(e,dcore,'same').*conv2(e,h,'same').*conv2(e,v,'same');
        str=['processing...',num2str(i/dmax*100),'%'];
        waitbar(i/dmax,wait,str)
    end
    delete(wait);
    [~,d] = min(imgDiff,[],3);
    D = d - 1;
end
D = uint8(D);
end