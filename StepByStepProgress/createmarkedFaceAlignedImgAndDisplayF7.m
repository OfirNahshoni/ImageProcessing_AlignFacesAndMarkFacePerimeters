function [original_face_aligned_img, bbox] = createmarkedFaceAlignedImgAndDisplayF7(I)
% Purpose: 
% Given Arguments: 
% Return Variable: 

% Starting massage
fprintf('[STEP-7] Searching the face in the image...\n');

% Create faceDetector object
faceDetector = vision.CascadeObjectDetector();
% Create bounding box
bbox = step(faceDetector, I);
% Mark the face with a rectangle
original_face_aligned_img = insertShape(I,'Rectangle',bbox);

if sum(original_face_aligned_img(:)) > 0 && size(bbox,1) == 1
    % Display face rotated RGB image with the face detected
    figure('Name','Step 7: Detected face of rotated RGB image');
    imshow(original_face_aligned_img);
    title('Detected face in rotated image - faceRotated');
    % Ending massage
    fprintf('[STEP-7] Marking the face process was successfully ended.\n');
else
    original_face_aligned_img = zeros(size(I));
    fprintf('[STEP-7] Cannot create face aligned image.\n');
end

end