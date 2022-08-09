function rotated_img = createRotatedRGBImgLoopF3(I, theta)
% Purpose: 
% Given Arguments: 
% Return Variable: 

% Define geometric transformation matrix - rotate 
R = [cosd(theta) sind(theta) 0;
         -sind(theta) cosd(theta) 0;
         0 0 1];
% Implementing rotate geometric transformation to create output image
    tFormAffine = affine2d(R);

if theta ~= 0 % if theta != 0 -> negative or positive angle, but not zero
    
    affineObjectGray = affineOutputView(size(I),tFormAffine, ...
                                    'BoundsStyle','followOutput');
    rotated_img = imwarp(I,tFormAffine,'bilinear', ...
                        'OutputView',affineObjectGray);
else % if theta equals to zero it is failure -> doesnt rotate the image
    rotated_img = zeros(size(I));
end % if

end % function