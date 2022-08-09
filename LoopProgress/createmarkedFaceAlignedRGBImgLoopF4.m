function [original_face_aligned_img,bbox,cropped_face_aligned_img] = createmarkedFaceAlignedRGBImgLoopF4(I)
% Purpose: 
% Given Arguments: 
% Return Variable: 

% Create faceDetector object
faceDetector = vision.CascadeObjectDetector();
% Create bounding box
bbox = step(faceDetector, I);

if size(bbox,1) == 1 % if face was detected in the 
    % Mark the face with a rectangle
    original_face_aligned_img = insertShape(I,'Rectangle',bbox);
    % Resize Rectangle to crop ((x,y) = left up point)
    bbox(1) = bbox(1) - 20; % Decrease x coordinate
    bbox(2) = bbox(2) - 20; % Decrease y coordinate
    bbox(3) = bbox(3) + 50; % Increase width
    bbox(4) = bbox(4) + 50; % Increase height
    % Crop the rotated image
    cropped_face_aligned_img = imcrop(I,bbox);
else % if no face was detected or at least 2 faces were detected
    original_face_aligned_img = I;
    cropped_face_aligned_img = I;
    bbox = [];
end % if sum


end % function