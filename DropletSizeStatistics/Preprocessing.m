%A scripts for acquiring parameters to be used in BatchCircleFinder.

%--------------------------------------------------------------------------
%IMAGE LOADING AND TYPE CONVERSION
%--------------------------------------------------------------------------
img = imread(''); %  Please fill in file name as 'xxxx.tif'.
if(size(img,3)==3)
    % Convert RGB to grayscale
    grayimg = rgb2gray(img);
else
    grayimg = img;
end

%--------------------------------------------------------------------------
%PRE-PROCESSING
%--------------------------------------------------------------------------
% Step #1: Contrast enhancement.
imshow(grayimg)
imcontrast %  Manually adjust contrast and remember the Max and Min.
%{
lowerlim = ; %  Please fill in the lower and upper limits that you choose 
upperlim = ; %  in the Adjust Contrast GUI.
contraimg = imadjust(grayimg, [lowerlim upperlim]/255, []);
%}

%--------Checkpoint--------
%{
figure
imshow(contraimg)
%}

%--------------------------------------------------------------------------
% Step #2: Edge detection using Canny method
%edgeimg = edge(contraimg, 'Canny'); %  edge detection. WARNING: output
                                     %  image format is LOGICAL.
%--------Checkpoint--------
%{
figure
imshow(edgeimg)
%}

%--------------------------------------------------------------------------
% Step #3: Blurring using Gaussian filter to reduce noise
%{
uint8img = im2uint8(edgeimg); % Convert from logical to uint8
blurimg = imgaussfilt(uint8img,0.5,'FilterSize',2);
%}
%  The second argument is Standard deviation of the Gaussian distribution,  
%  default value = 0.5; the Name-Value Pair 'FilterSize' specifies the size
%  of the filter, default value = 2 (square), you can change to another 
%  uint scalar or a 2-element vector [M N]

%--------Checkpoint--------
%{
figure
imshow(blurimg)
%}

%--------------------------------------------------------------------------
%DIAMETER RANGE MEASUREMENT
%--------------------------------------------------------------------------
%{
figure
imshow(blurimg)

d = drawline; %  Then DIRECTLY draw a line to the SMALLEST circle WANTED
              %  within one click.
pos = d.Position;
diffPos = diff(pos);
rawDiamtrPixelLlim = hypot(diffPos(1),diffPos(2))

hold on

d = drawline; %  Then DIRECTLY draw a line to the BIGGEST circle WANTED
              %  within one click.
pos = d.Position;
diffPos = diff(pos);
rawDiamtrPixelUlim = hypot(diffPos(1),diffPos(2))

hold off
%}
