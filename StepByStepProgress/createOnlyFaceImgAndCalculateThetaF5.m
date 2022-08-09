function [only_face_img, theta] = createOnlyFaceImgAndCalculateThetaF5(BW, lower_limit_area, upper_limit_area)
% Purpose: This function gets a binary image with multiple objects and
% filter all the objects that is not the face. The assumption is the face
% is the largest object in the image.
% Given Arguments:
% 1) BW = Binary input image.
% 2) lower_limit_area = The minimum area of object (lower limit).
% 3) upper_limit_area = The maximum area of object (upper limit).
% Return Variable: 
% 1) only_face_img = Binary image contains only the face.
% 2) theta = Required angle to rotate to align the face.

% Starting massage
fprintf('[STEP-5] Starting to filter the image...\n');

% Define vector of limits to the filter
limits = [lower_limit_area, upper_limit_area];

% Filter the irrelevant objects
only_face_img = bwareafilt(BW,limits);

if sum(only_face_img(:)) > 0
    % Display only face image in a figure
    figure('Name','Step 5: Not rotated binary only face image'); 
    imshow(only_face_img);
    title('Binary only face not rotated - bOnlyFace');
    
    % Compute the angle, theta, need to be rotated by
    props_only_face = regionprops(only_face_img,'Orientation');
    
    % Check if theta is greater than 90 degrees or not
    theta = props_only_face.Orientation;
    if theta < 0
        theta = theta + 90;
    else
        theta = theta - 90;
    end
    
    % Ending massage
    fprintf('[STEP-5] Filtering process was ended successfully.\n');
else
    theta = 0;
    fprintf('[STEP-5] Cannot filter the image and calculate theta.\n');
end

end