clear all
close all

% i1 = imread('LC08_L1TP_002027_20190614_20190620_01_T1_B8.TIF');
i1 = imread('B8Crop.tif');
adjPanchroImage = imadjust(i1);
outputImage = adjPanchroImage;
% i2 = imread('LC08_L1TP_002027_20190614_20190620_01_T1_B11.tif');
i2 = imread('B11Crop.tif');
i2c = imadjust(i2);
% i3 = imread('LC08_L1TP_002027_20190614_20190620_01_T1_BQA.tif');
i3 = imread('BQACrop.tif');
i3c = imadjust(i3);

figure;
imshow(i3);
title('Cloud Layer');

figure;
imshow(i3c);
title('Cloud Layer');

%% Filter Land Using Thermal Imagery
%Canny edge detection on thermal image
edgeTest = edge(i2c,'Canny');

% Dilate image with a disk-shaped structuring element of radius 3
SE = strel('disk',3);
dilated = imdilate(edgeTest,SE);

figure;
imshow(dilated);
title('Thermal Mask');

% Invert binary image to create a mask of all land mass in the image
inverted = 1 - dilated;

% Remove bodies of water below specified size
thermalMask = bwareaopen(inverted, 100000);

% Create a mask of clouds in the image
% cloudMask = i3c > 20000;
cloudMask = i3 > 4000;

% Resize masks to match higher resolution band-8 image 
newSize = size(adjPanchroImage);
thermalMask = imresize(thermalMask,newSize);
cloudMask = imresize(cloudMask,newSize);

[x,y] = size(adjPanchroImage);
for i = 1:x    
    for j = 1:y       
        if thermalMask(i,j) == 0
            adjPanchroImage(i,j) = 0;
        elseif cloudMask(i,j) == 1
            adjPanchroImage(i,j) = 0;
        end
    end
end

figure;
imshow(thermalMask);
title('Thermal Mask');

figure;
imshow(cloudMask);
title('Cloud Mask');

figure;
imshow(adjPanchroImage);
title('Masks Applied');

%% Iceberg Identification

% Create a mask of high intensity pixels
iceBergMask = adjPanchroImage > 55000;
figure;
imshow(iceBergMask);
title('Potential Icebergs');

% Remove objects below specified size
iceBergMask = bwareaopen(iceBergMask, 3);
figure;
imshow(iceBergMask);
title('Identified Icebergs');

% Create a circle around all identified icebergs
SE2 = strel('disk',25);
IDMask = imdilate(iceBergMask,SE2);
figure;
imshow(IDMask);
title('ID Mask');

% Trace boundaries of Expanded Icebergs
IDMask = edge(IDMask);
SE3 = strel('disk',5);
IDMask = imdilate(IDMask,SE3);
figure;
imshow(IDMask)
title('Circles');

% Convert the original image to color
colorImage = cat(3, outputImage, outputImage, outputImage);

[x,y] = size(outputImage);
for i = 1:x    
    for j = 1:y       
        if IDMask(i,j) == 1
            colorImage(i,j,:) = [65500,0,0];
        end
    end
end

figure;
imshow(colorImage);



% Get Size of Potential Iceberg Objects
% cc = bwconncomp(iceBergMask)
% labeled = labelmatrix(cc);
% stats = regionprops(cc,'Area','BoundingBox')
% stats(1).area
% RGB_label = label2rgb(labeled, @copper, 'c', 'shuffle');
% figure;
% imshow(RGB_label,'InitialMagnification','fit');

% Get Size of Potential Iceberg Objects

cc = bwconncomp(iceBergMask)
stats = regionprops(cc,'Area','Centroid');

numBergs = size(stats);
for i = 1:numBergs(1)
    % #######ADD IF ELSEIFS HERE FOR CLASS SIZES########%
%     if stats(i).Area > whatever
      textLocation = [stats(i).Centroid(1)+ 35,stats(i).Centroid(2)];
      colorImage = insertText(colorImage,textLocation,'Class A','FontSize',48,'BoxColor','Red');
% end
end

figure;
imshow(colorImage);
