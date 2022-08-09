function [binary_rotated_only_face_img, binary_no_holes_img] = createBinaryImgAndFillHolesF9(I, threshold, lower, upper)
% Purpose: 
% Given Arguments: 
% 1) I = RGB image with aligned only face.
% 2) threshold = The threshold value that specifies the convertion
% 3) lower = The lower limit of the filter.
% 4) upper = The upper limit of the filter.
% Return Variable: 

fprintf('[STEP-9] Statring creating binary only face image and filling holes process...\n');

% Convert to binary image - rotated only face image
BW = rgb2gray(I) > threshold;
% Limits vector to filter the binary only face image
limits = [lower, upper];
% Binary only face image (rotated)
binary_rotated_only_face_img = bwareafilt(BW, limits);
% Fill the holes in the face
binary_no_holes_img = imfill(binary_rotated_only_face_img,'holes');

if sum(binary_rotated_only_face_img(:)) > 0
    % Display the binary images in a figure
    figure('Name','Step 9: Fill the holes in the rotated only face image');
    subplot(1,2,1); imshow(binary_rotated_only_face_img);
    title('Rotated only face binary image');
    subplot(1,2,2); imshow(binary_no_holes_img);
    title('No holes only aligned face');
    fprintf('[STEP-9] Creating binary only face and filling hiles was successfully finished.\n');
else
    fprintf('[STEP-9] Cannot create binary only face image.\n');
end

end