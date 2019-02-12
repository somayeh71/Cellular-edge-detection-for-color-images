
function [colorCED_average,colorCED_Luminance,h,Hue, saturation,value,colorCED_Combine,colorCED_max] = colorCED( I )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

IR = I(:,:,1);
IG = I(:,:,2);
IB = I(:,:,3);
[row,col,c] = size(I);

%---------------------------
%1. Extract the luminance or brightness information and apply a monochrome edge detection method

%use average of chanells and then edge detect them
average = (IR+IG+IB)/3;
colorCED_average = CLA_G_ED_final(average );
figure('name','color CED-average of channels-'), imshow(colorCED_average)

%use Luminance of chanells then edge detect them
Luminance = 0.299.*IR+0.587.*IG+0.114.*IB;
colorCED_Luminance = CLA_G_ED_final(Luminance );
figure('name','color CED-Luminance of channels-'), imshow(colorCED_Luminance)

% %use Vector Length of channels and then edge detect them %%%%%%%%hazff
% P=I;
% P;
% % VectorLength = sqrt((IR.^2)+(IG.^2)+(IB.^2));
% VectorLength=sqrt(sum(P.^2));
% VectorLength;
% colorCED_VectorLength = CLA_G_ED_final(VectorLength );
% figure('name','color colorCED_VectorLength of chanells-'), imshow(colorCED_VectorLength)
%------------------------------------------------------------------------------------------------------------------------------
% 2. Map RGB data into another color space and extract edges in one of the new color space bands.
% Example, HSV space, extract edges in hue or saturation band
HSV = rgb2hsv(I);

h = HSV(:,:,1);
s = HSV(:,:,2);
v = HSV(:,:,3);
h = uint8(255 *h);
s = uint8(255 *s);
v = uint8(255 *v);
% Display the images.
figure('name','HSV-')
subplot(2, 3, 1);
imshow(h, []);
title('Hue Image');
subplot(2, 3, 2);
imshow(s, []);
title('saturation Image');
subplot(2, 3, 3);
imshow(v, []);
title('Value Image');
%-----------------EDGEs--------------------
Hue = CLA_G_ED_final(h);
subplot(2, 3, 4);
imshow(Hue);
title('Hue Edge Image');

saturation = CLA_G_ED_final(s);
subplot(2, 3, 5);
imshow(saturation, []);
title('saturation Edge Image');

value = CLA_G_ED_final(v );
subplot(2, 3, 6);
imshow(value, []);
title('Value Edge Image');



%------------------------------------------------------------------------------------------------------------------------------
%3. Apply a monochrome edge detection method to each of the RGB bands separately and then combine the results into a composite image 

%edge on each chanells and combine them
JR = CLA_G_ED_final(IR );
JG = CLA_G_ED_final(IG );
JB = CLA_G_ED_final(IB );

% colorCED_Combine = size(I);
colorCED_Combine = zeros(size(I));
colorCED_Combine(:,:,1) =JR; %putting R resultant in result image
colorCED_Combine(:,:,2)= JG; %putting  G resultant in result image
colorCED_Combine(:,:,3)= JB; %putting B resultant in result image
figure('name','color CED-combine channels-'), imshow(colorCED_Combine)

%----------------------------------------------------------------------------------------------------------------------------------
%4. Apply a monochrome edge detection method to each of the RGB bands separately and then retain the maximum value at each location
colorCED_max = zeros(row,col);


for x=1:row
   for y=1:col
       % colorCED_max[i,j] = max(JR[i,j],JG[i,j],JB[i,j]);
       aa=JR(x,y);
       bb=JG(x,y);
       cc=JB(x,y);
       colorCED_max(x,y)= max([aa,bb,cc]);
      
    end
end

figure('name','color CED- max of each channels-'), imshow(colorCED_max)

%------------------------------------------------------------------------------------------------------------------------------------
% other possible methods
%5. Apply a monochrome edge detection method to each of the RGB bands separately and then use a linear combination of the three results at each location
%-------------------------------------------------------------------------------------------------------------------------------------------
%6. Consider RGB pixel vectors and find vector distance between adjacent pixels – an edge exceeds a minimum distance
%-----------------------------------------------------------------------------------------------------------------------------------------
%7. Find the minimum given by the following two equations in order to find edges in a multispectral images (Cervenka and Charvat): 

end

