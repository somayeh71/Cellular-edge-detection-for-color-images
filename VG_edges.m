%function [VG_edges, VA_edges, ED_edges ] = VG_edges( I1 )
function [VG_edges ] = VG_edges( I1 )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

R = double(I1(:,:,1));
G = double(I1(:,:,2));
B = double(I1(:,:,3));
I_size = size(I1(:,:,1));

%%We use the Vector Gradient Edge Detectors proposed in the paper.  So we
%%take a 3x3 mask and go throughout the entire image to find E_vg and S_vg
%%at each pixel.

%%First find E_vg, the Euclidean distance operator, which for each center
%%pixel is equal to the maximum of the Euclidean distances between each
%%point on the edge of the mask and the center point.
%%Obviously we cannot apply this mask at the outer boundary of the image,
%%so we leave E_vg as 0 for these points.
E_vg = zeros(I_size(1),I_size(2));
for y=2:(I_size(1)-1)
    for x=2:(I_size(2)-1)
        for i=-1:1
            for j=-1:1
                ED = sqrt((R(y+i,x+j)-R(y,x))^2 + (G(y+i,x+j)-G(y,x))^2 + (B(y+i,x+j)-B(y,x))^2);
                if ED > E_vg(y,x)
                    E_vg(y,x) = ED;
                end
            end
        end
    end
end

%%Run the results in E_vg through a threshold to get a nice image of the
%%edges found by Euclidean distance alone.
ED_thresh = 45.0;
ED_edges = zeros(I_size(1),I_size(2));
for y=1:I_size(1)
    for x=1:I_size(2)
        if E_vg(y,x) > ED_thresh
            ED_edges(y,x) = 255;
        end
    end
end
%figure('Name','ED_edges')

% imshow(ED_edges);


%%Now find S_vg, the Vector Angle operator, which for each center pixel is
%%equal to the maximum Vector Angle between each point on the edge of the
%%mask and the center point.
%%Obviously we cannot apply this mask at the outer boundary of the image,
%%so we leave S_vg as 0 for these points.
S_vg = zeros(I_size(1),I_size(2));
for y=2:(I_size(1)-1)
    for x=2:(I_size(2)-1)
        for i=-1:1
            for j=-1:1
                v1_dot_v2 = R(y+i,x+j)*R(y,x)+G(y+i,x+j)*G(y,x)+B(y+i,x+j)*B(y,x);
                norm_v1 = sqrt(R(y+i,x+j)^2 + G(y+i,x+j)^2 + B(y+i,x+j)^2);
                norm_v2 = sqrt(R(y,x)^2 + G(y,x)^2 + B(y,x)^2);
                if norm_v1 == 0 || norm_v2 == 0
                    VA = 1;
                else
                    VA = sqrt(1 - ((v1_dot_v2)/(norm_v1*norm_v2))^2);
                end
                if VA > S_vg(y,x)
                    S_vg(y,x) = VA;
                end
            end
        end
    end
end

%%Run the results in S_vg through a threshold to get a nice image of the
%%edges found by Vector Angle alone.
VA_thresh = 0.075;
VA_edges = zeros(I_size(1),I_size(2));
for y=1:I_size(1)
    for x=1:I_size(2)
        if S_vg(y,x) > VA_thresh
            VA_edges(y,x) = 255;
        end
    end
end
%figure('name','VA_edges');
%imshow(VA_edges);


%%Now we finally use the saturation-based combination of E_vg and S_vg for
%%our fully-featured edge detector.
%%NOTE: This particular edge detector runs VERY VERY slow, thanks to all
%%the looping and comparisons at each pixel.

%%First calculate the Saturation from the RGB values using the following
%%equation: S = (max(R,G,B) - min(R,G,B)) / max(R,G,B)
S = zeros(I_size(1),I_size(2));
for y=1:I_size(1)
    for x=1:I_size(2)
        the_max = max([R(y,x) G(y,x) B(y,x)]);
        if the_max == 0
            S(y,x) = 0;
        else
            S(y,x) = (the_max - min([R(y,x) G(y,x) B(y,x)]))/the_max;
        end
    end
end

%%Now, at each point we calculate C_vg as detailed below.
%%Slope and Offset are the two values which can be experimentally changed
%to affect the results of the edge detector.
slope_var = 75.0;
offset_var = 0.10;
C_vg = zeros(I_size(1),I_size(2));

for y=2:(I_size(1)-1)
    for x=2:(I_size(2)-1)
        for i=-1:1
            for j=-1:1
                %%First calculate Euclidean Distance and normalize it
                ED = sqrt((R(y+i,x+j)-R(y,x))^2 + (G(y+i,x+j)-G(y,x))^2 + (B(y+i,x+j)-B(y,x))^2);
                ED = ED/(255*sqrt(3));
                
                %%Then calculate Vector Angle
                v1_dot_v2 = R(y+i,x+j)*R(y,x)+G(y+i,x+j)*G(y,x)+B(y+i,x+j)*B(y,x);
                norm_v1 = sqrt(R(y+i,x+j)^2 + G(y+i,x+j)^2 + B(y+i,x+j)^2);
                norm_v2 = sqrt(R(y,x)^2 + G(y,x)^2 + B(y,x)^2);
                if norm_v1 == 0 | norm_v2 == 0
                    VA = 1;
                else
                    VA = sqrt(1 - ((v1_dot_v2)/(norm_v1*norm_v2))^2);
                end
                
                %%Now calculate the tradeoff function based on saturation
                sigmoid1 = 1/(1+exp(-slope_var*(S(y,x)-offset_var)));
                sigmoid2 = 1/(1+exp(-slope_var*(S(y+i,x+j)-offset_var)));
                rho = sqrt(sigmoid1*sigmoid2);
                
                %%Finally, calculate the saturation based combination of
                %%the Vector Gradient and see if it is the maximum one
                %%found so far.
                VG = rho*VA + (1-rho)*ED;
                if VG > C_vg(y,x)
                    C_vg(y,x) = VG;
                end
            end
        end
    end
end

%%Run the results in C_vg through a threshold to get a nice image of the
%%edges found by our saturation based combination of the Vector Gradient.
VG_thresh = 0.075;
VG_edges = zeros(I_size(1),I_size(2));
for y=1:I_size(1)
    for x=1:I_size(2)
        if C_vg(y,x) > VG_thresh
            VG_edges(y,x) = 255;
        end
    end
end


end

