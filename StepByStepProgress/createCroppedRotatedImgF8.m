function out = createCroppedRotatedImgF8(I, bbox)
% Purpose: 
% Given Arguments: 
% Return Variable: 

% Starting massage
fprintf('[STEP-8] Starting to crop the rotated image...\n');

if size(bbox,1) == 1
    % Resize Rectangle to crop ((x,y) = left up point)
    bbox(1) = bbox(1) - 20; % Decrease x coordinate
    bbox(2) = bbox(2) - 20; % Decrease y coordinate
    bbox(3) = bbox(3) + 50; % Increase width
    bbox(4) = bbox(4) + 40; % Increase height
    
    % Crop the rotated image
    out = imcrop(I,bbox);
    
    % Display rotated cropped RGB image in a figure
    figure('Name','Step 8: Rotated cropped RGB image');
    imshow(out);
    title('Rotated cropped RGB image');
    
    % Ending massage
    fprintf('[STEP-8] Rotated image was successfully cropped.\n');
else
    out = zeros(size(I));
    fprintf('[STEP-8] Cannot create cropped rotated image.\n');
end

end