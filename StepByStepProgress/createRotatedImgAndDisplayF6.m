function rotated_img = createRotatedImgAndDisplayF6(I, theta)
% Purpose: 
% Given Arguments: 
% Return Variable: 

% Starting massage
fprintf('[STEP-6] Starting to rotate the image...\n');

if theta ~= 0
    % Define geometric transformation matrix - rotate 
    R = [cosd(theta) sind(theta) 0;
         -sind(theta) cosd(theta) 0;
         0 0 1];

    % Implementing rotate geometric transformation to create output image
    tFormAffine = affine2d(R);
    affineObjectGray = affineOutputView(size(I),tFormAffine, ...
                                    'BoundsStyle','followOutput');
    rotated_img = imwarp(I,tFormAffine,'bilinear', ...
                        'OutputView',affineObjectGray);
    
    % Display rotated RGB image
    figure('Name','Step 6: Rotated original RGB image');
    imshow(rotated_img);
    title('Rotated RGB image');
    
    % Ending massage
    fprintf('[STEP-6] Rotating the image was successfully ended.\n');

else
    rotated_img = zeros(size(I));
    fprintf('[STEP-6] Cannot rotate the image.\n');
end


end