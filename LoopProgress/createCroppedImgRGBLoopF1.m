function [marked_face_img, cropped_img] = createCroppedImgRGBLoopF1(I)
% Purpose: This function is creating 2 images from an RGB image I.
% The first is the marked face image - with yellow bounding box around the
% face. The second is the cropped image that contains only the face.
% Given Arguments: I = RGB input image.
% Return Variable: 
% 1) marked_face_img = The image with the bounding box aroung the face.
% 2) cropped_img = The cropped image that contains only the face.

% Create faceDetector object to recognize the face in the image I
faceDetector = vision.CascadeObjectDetector();
% Recognize the face and compute bounding box
bbox = step(faceDetector, I);
% Mark the face - creating images with marked face
marked_face_img = insertShape(I, 'Rectangle', bbox);

if size(bbox, 1) == 1 % If the face was successfully detected in the image I
    % Expand the bounding box for cropping ((x,y) = left up point)
    bbox(1) = bbox(1) - 20; % Decrease x coordinate
    bbox(2) = bbox(2) - 30; % Decrease y coordinate
    bbox(3) = bbox(3) + 50; % Increase width
    bbox(4) = bbox(4) + 50; % Increase height
    % Cropping the face from the image
    cropped_img = imcrop(I,bbox);
else % Fail to detect a face in image I
    marked_face_img = zeros(size(I));
    cropped_img = zeros(size(I));
end % if

end % function