function results = BatchCircleFinder(img)
%A batch circle finder script used in Image Batch Processor.

%--------------------------------------------------------------------------
%GLOBAL PARAMETERS
%--------------------------------------------------------------------------
%IMG      - Input image.
%RESULTS - A scalar structure with the processing results.
contralowerlim = 100; %  Please fill in values you've chosen in 
contraupperlim = 200; %  Preprocessing.m.
ContrastWindow = [contralowerlim contraupperlim]/255;
DiamtrPixelLlim = 12; %  Please fill in values; reference raw data were 
DiamtrPixelUlim = 800; %  measured in Preprocessing.m.
RadiusWindow = [DiamtrPixelLlim DiamtrPixelUlim]/2;
DeltaRadius = -2; %  Manual correction of the detected radius in pixels.
scalebarlength = 100; %  Please fill in physical length of scale bar, in
                      %  micrometers.
scalebarpixels = 20; %  Please fill in length of scale bar in pixels.
PixelperScalebar = scalebarpixels/scalebarlength;


%--------------------------------------------------------------------------
%IMAGE LOADING AND TYPE CONVERSION
%--------------------------------------------------------------------------
if(size(img,3)==3)
    grayimg = rgb2gray(img); %  Convert RGB to grayscale.
else
    grayimg = img;
end

%--------------------------------------------------------------------------
%PRE-PROCESSING
%--------------------------------------------------------------------------
contraimg = imadjust(grayimg, ContrastWindow, []); %  Contrast enhancement.
edgeimg = edge(contraimg, 'canny'); %  Edge detection.
uint8img = im2uint8(edgeimg); %  Convert from logical to uint8
%blurimg = imgaussfilt(uint8img); %  Blurring
blurimg = imfilter(uint8img, ones(3)/9);
imshow(blurimg)
%--------------------------------------------------------------------------
%CIRCLE DETECTION
%--------------------------------------------------------------------------
[centers,rawradii] = imfindcircles(blurimg, RadiusWindow);
radii = rawradii + DeltaRadius;
circledimg = insertShape(img,'Circle',[centers radii],'LineWidth',2,...
    'Color','red', 'Opacity',0.1);

%--------------------------------------------------------------------------
%DATA EXPORTATION
%--------------------------------------------------------------------------
results.outputimg = circledimg;
results.radius = radii/PixelperScalebar;

%  (OPTIONAL) Data export to excel
%  NOT FINISHED!
%{
T = table(radii);
[filepath,name,ext] = fileparts();
writetable(T,append(name, '.xlsx'),'Sheet','droplet diameter')
%}

%--------------------------------------------------------------------------
