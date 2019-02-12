function [result] = colorcanny(colorimage)
% This function runs the Canny Edge Detector on the three separate channels
% of a color image and then returns a weighted combination of the
% results to provide a final image.


% high = 0.06;    %rather arbitrary, should be an input, this is almost equivalent to edge(image, 'canny', 0.16)
% low = 0.024;
[sy,sx] = size(colorimage);

colorimage = double(colorimage);
is_large = 0;
for x=1:sx
    for y=1:sy
        if colorimage(y,x,1) > 1
            is_large = 1;
            break;
        end
    end
    if is_large == 1
        break;
    end
end
if is_large == 1
    colorimage = colorimage/256;
end

% Uncomment to display each color channel separately
% Rimage = zeros(sy,sx,sc);
% Gimage = zeros(sy,sx,sc);
% Bimage = zeros(sy,sx,sc);
% Rimage(:,:,1) = colorimage(:,:,1);
% Gimage(:,:,2) = colorimage(:,:,2);
% Bimage(:,:,3) = colorimage(:,:,3);
% figure;
% imshow(Rimage);
% figure;
% imshow(Gimage);
% figure;
% imshow(Bimage);

% First perform the detection on a grayscale version for comparison
%grayimage = rgb2gray(colorimage);
%grayedges = canny(grayimage);
% figure;
% imshow(grayedges,[0 1]);
% return
% Now perform detection on each separate color channel
R = colorimage(:,:,1);
G = colorimage(:,:,2);
B = colorimage(:,:,3);

Redges=edge(R,'canny');
Gedges=edge(G,'canny');
Bedges=edge(B,'canny');
result = Redges | Gedges| Bedges;

%figure;
imshow(result,[0 1]);
end