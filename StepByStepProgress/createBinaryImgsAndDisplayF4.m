function [binary_img1, binary_img2] = createBinaryImgsAndDisplayF4(gray_scale_img, threshold1, threshold2)
% Purpose: This function is creating two binary images from gray scale, 
% by two thresholds that are given as an input.
% image - B1 with threshold1 and B2 with threshold2.
% Given Arguments: 
% Return Variable: 

% Starting massage
fprintf('[STEP-4] Starting creating the binary images...\n');

if threshold1 > 0 && threshold2 > 0 % Success
    % Creating the binary images
    binary_img1 = gray_scale_img > threshold1;
    binary_img2 = gray_scale_img > threshold2;
    
    % Display the binary images
    figure('Name','Display the binary images that were created');
    subplot(1,2,1); imshow(binary_img1);
    title(['Binary image user guess (threshold = ' num2str(threshold1) ')']);
    subplot(1,2,2); imshow(binary_img2);
    title(['Binary image with matlab function (threshold = ' num2str(threshold2) ')']);
    
    % End success massage
    fprintf('[STEP-4] Binary images were successfully created.\n');
else % Failure
    binary_img1 = zeros(size(gray_scale_img));
    binary_img2 = zeros(size(gray_scale_img));
    fprintf('[STEP-4] Cannot create binary images.\n');
end

end