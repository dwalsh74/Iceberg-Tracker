clear all
close all

%Specify Coordinates
xStart = 10000;
xWidth = 3000;
yStart = 5800;
yHeight = 3000;

i1 = imread('LC08_L1TP_002027_20190614_20190620_01_T1_B8.TIF');
i2 = imread('LC08_L1TP_002027_20190614_20190620_01_T1_B10.TIF');
i3 = imread('LC08_L1TP_002027_20190614_20190620_01_T1_B11.TIF');
i4 = imread('LC08_L1TP_002027_20190614_20190620_01_T1_BQA.TIF');

i1Cropped = imcrop(i1,[xStart yStart xWidth yHeight]);
figure;
imshow(i1Cropped);
imwrite(i1Cropped,'H:\Term 7\7854\DesignProject\MATLAB_Files\Im1\B8Crop.tif')
% saveas(gcf, 'H:\Term 7\7854\DesignProject\MATLAB_Files\Im1\B8Crop', 'tiffn')
% 
i2Cropped = imcrop(i2,[xStart/2 yStart/2 xWidth/2 yHeight/2]);
figure;
imshow(i2Cropped);
imwrite(i2Cropped,'H:\Term 7\7854\DesignProject\MATLAB_Files\Im1\B10Crop.tif')
% saveas(gcf, 'H:\Term 7\7854\DesignProject\MATLAB_Files\Im1\B10Crop', 'tiffn')
% 
i3Cropped = imcrop(i3,[xStart/2 yStart/2 xWidth/2 yHeight/2]);
figure;
imshow(i3Cropped);
imwrite(i3Cropped,'H:\Term 7\7854\DesignProject\MATLAB_Files\Im1\B11Crop.tif')
% saveas(gcf, 'H:\Term 7\7854\DesignProject\MATLAB_Files\Im1\B11Crop', 'tiffn')

i4Cropped = imcrop(i4,[xStart/2 yStart/2 xWidth/2 yHeight/2]);
figure;
imshow(i4Cropped);
imwrite(i4Cropped,'H:\Term 7\7854\DesignProject\MATLAB_Files\Im1\BQACrop.tif')
% saveas(gcf, 'H:\Term 7\7854\DesignProject\MATLAB_Files\Im1\BQACrop', 'tiffn')