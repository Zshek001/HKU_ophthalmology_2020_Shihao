%A scripts for acquiring parameters to be used in the preprocessing part of BatchCircleFinder.

%--------------------------------------------------------------------------
%IMAGE LOADING AND TYPE CONVERSION
%--------------------------------------------------------------------------
img = imread(''); %  Please fill in file name as 'xxxx.tif'.
if(size(img,3)==3)
    % Convert RGB to grayscale.
    grayimg = rgb2gray(img);
else
    grayimg = img;
end

DiamtrPixelLlim = ; %  Please fill in diameter, measured in the
DiamtrPixelUlim = ; %  DiameterEstimation module.
RadiusWindow = [DiamtrPixelLlim DiamtrPixelUlim]/2;

%--------------------------------------------------------------------------
%PRE-PROCESSING
%--------------------------------------------------------------------------
% Step #1: Contrast enhancement.
imshow(grayimg)
imcontrast %  Manually adjust contrast and remember the Max and Min.
%{
lowerlim = ; %  Please fill in the lower and upper limits you choose 
upperlim = ; %  in the Adjust Contrast GUI.
contraimg = imadjust(grayimg, [lowerlim upperlim]/255, []);
%}

%--------Checkpoint--------
%{
figure
imshow(contraimg)
[centers,rawradii] = imfindcircles(contraimg, RadiusWindow);
viscircles(centers,rawradii);
%}

%--------------------------------------------------------------------------
% Step #2: Edge detection using 'log' method
%edgeimg = edge(contraimg, 'log'); %  edge detection. WARNING: output
                                   %  image format is LOGICAL.
%--------Checkpoint--------
%{
figure
imshow(edgeimg)
[centers,rawradii] = imfindcircles(edgeimg, RadiusWindow);
viscircles(centers,rawradii);
%}

%--------------------------------------------------------------------------
% (Optional)Step #3: Blurring using Gaussian filter to reduce noise
%{
uint8img = im2uint8(edgeimg); % Convert from logical to uint8
blurimg = imgaussfilt(uint8img,1,'FilterSize',7);
%}
%  The second argument is Standard deviation of the Gaussian distribution,  
%  default value = 0.5; the Name-Value Pair 'FilterSize' specifies the size
%  of the filter, default value = 2 (square), you can change to another 
%  uint scalar or a 2-element vector [M N].
%  2020-11-19 It turned out that this filter may be harmful to imfindcircle
%  proper functioning, though I don't know why.

%--------Checkpoint--------
%{
figure
imshow(blurimg)
[centers,rawradii] = imfindcircles(blurimg, RadiusWindow);
viscircles(centers,rawradii);
%}
