clear
clc
close all
I = imread('peppers_color.jpg');
I = imnoise(I,'salt & pepper',0.0005);
%VG COLOR EDGE DETECTOR
ImgVG_edge = VG_edges( I );
figure('Name','Result of( VD_edges) detector: ')
imshow(ImgVG_edge);

[mse_VD_edges,psnr_VD_edges]=Results(I,ImgVG_edge);%%%%%%%%%%%%%%%
message = sprintf('ImgVG_edge;\nThe mean square error is %.2f.\n The PSNR = %.4f\n',mse_VD_edges,psnr_VD_edges);
msgbox(message);


%CANNY COLOR EDGE DETECTOR
ImgColorCany=colorcanny(I);
figure('Name','Result of(color canny) detector: ')
imshow(ImgColorCany);

[mse_colorCany,psnr_colorCany]= Results(I,ImgColorCany);%%%%%%%%
message = sprintf('ImgColorCany:\nThe mean square error is %.2f.\n The PSNR = %.4f\n\n', mse_colorCany,psnr_colorCany);
msgbox(message);

%Cellular learning Automata  COLOR EDGE DETECTOR
[colorCED_average,colorCED_Luminance,Hue, saturation,value,colorCED_Combine ,colorCED_max] =colorCED( I );

[mse_colorCED_average,psnr_colorCED_average]=Results(I,colorCED_average);
message = sprintf('colorCED_average:\nThe mean square error is %.2f.\n The PSNR = %.4f\n\n',mse_colorCED_average,psnr_colorCED_average);
msgbox(message);

[mse_colorCED_Luminance,psnr_colorCED_Luminance]=Results(I,colorCED_Luminance);
message = sprintf('colorCED_Luminance:\nThe mean square error is %.2f.\n The PSNR = %.4f\n\n',mse_colorCED_Luminance,psnr_colorCED_Luminance);
msgbox(message);

[mse_Hue,psnr_Hue]=Results(I,Hue);
message = sprintf('Hue:\nThe mean square error is %.2f.\n The PSNR = %.4f\n\n',mse_Hue,psnr_Hue );
msgbox(message);


[mse_saturation,psnr_saturation]=Results(I,saturation);
message = sprintf('saturation:\nThe mean square error is %.2f.\n The PSNR = %.4f\n\n', mse_saturation,psnr_saturation);
msgbox(message);


[mse_value,psnr_calue]=Results(I,value);
message = sprintf('value:\nThe mean square error is %.2f.\n The PSNR = %.4f\n\n', mse_value,psnr_calue);
msgbox(message);

[mse_colorCED_Combine,psnr_colorCED_Combine]=Results(I,colorCED_Combine);
message = sprintf('colorCED_Combine:\nThe mean square error is %.2f.\n The PSNR = %.4f\n\n', mse_colorCED_Combine,psnr_colorCED_Combine);
msgbox(message);

[mse_colorCED_max,psnr_colorCED_max]=Results(I,colorCED_max);
message = sprintf('colorCED_max:\nThe mean square error is %.2f.\n The PSNR = %.4f\n\n', mse_colorCED_max,psnr_colorCED_max);
msgbox(message);






