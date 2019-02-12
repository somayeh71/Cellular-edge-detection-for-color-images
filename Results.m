function [Mean_MSE,Mean_PSNR] = Results( I,J )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

squaredErrorImage = (double(I) - double(J)) .^ 2;
[rows, columns] = size(I);
MSE = sum(sum(squaredErrorImage)) / (rows * columns);
PSNR = 10 * log10( 256^2 / MSE);

Mean_MSE=(MSE(:,:,1)+MSE(:,:,2)+MSE(:,:,3))/3 ;
Mean_PSNR=(PSNR(:,:,1)+PSNR(:,:,2)+PSNR(:,:,3))/3;




%  [r,c,d] = size(MSE);

% if d==1
%     MSE, PSNR;
% end
%     
% if d~=1
%     Mean_MSE=(MSE(:,:,1)+MSE(:,:,2)+MSE(:,:,3))/3 ;
%     Mean_PSNR=(PSNR(:,:,1)+PSNR(:,:,2)+PSNR(:,:,3))/3;
%     Mean_MSE,Mean_PSNR;
% end
%      
  

end

