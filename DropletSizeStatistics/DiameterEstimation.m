%A script for diameter range estimation.

%--------------------------------------------------------------------------
%IMAGE LOADING AND TYPE CONVERSION
%--------------------------------------------------------------------------
img = imread('1.tif'); %  Please fill in file name as 'xxxx.tif'.
if(size(img,3)==3)
    % Convert RGB to grayscale
    grayimg = rgb2gray(img);
else
    grayimg = img;
end

%--------------------------------------------------------------------------
%DIAMETER RANGE MEASUREMENT
%--------------------------------------------------------------------------
figure
imshow(grayimg)

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
