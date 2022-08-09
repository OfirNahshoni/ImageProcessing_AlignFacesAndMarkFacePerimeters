function [marked_face_img, cropped_img] = createMarkedAndCroppedImgsF2(I)
% Purpose: This function is creating 2 images from an RGB image I.
% The first is the marked face image - with yellow bounding box around the
% face. The second is the cropped image that contains only the face.
% Given Arguments: I = RGB input image.
% Return Variable: 
% 1) marked_face_img = The image with the bounding box aroung the face.
% 2) cropped_img = The cropped image that contains only the face.

% Starting massage
fprintf('[STEP-2] Starting marking face and cropping process...\n');

% Create faceDetector object to recognize the face in the image I
faceDetector = vision.CascadeObjectDetector();
% Recognize the face and compute bounding box
bbox = step(faceDetector, I);
% Mark the face - creating images with marked face
marked_face_img = insertShape(I, 'Rectangle', bbox);

if (isempty(bbox) == 0) && (size(bbox, 1) == 1) % Success
    % Expand the bounding box for cropping ((x,y) = left up point)
    bbox(1) = bbox(1) - 20; % Decrease x coordinate
    bbox(2) = bbox(2) - 30; % Decrease y coordinate
    bbox(3) = bbox(3) + 50; % Increase width
    bbox(4) = bbox(4) + 50; % Increase height
    % Cropping the face from the image
    cropped_img = imcrop(I,bbox);
    % Display bbox marking the face and cropped image
    figure('Name','Step 2: Detect face and mark with rectangle');
    subplot(1,2,1); imshow(marked_face_img);
    title('Marked face image');
    subplot(1,2,2); imshow(cropped_img);
    title('Cropped face image');
    % Ending massage
    fprintf('[STEP-2] Recognizing and cropping face were successfully done.\n');
else % Failure
    marked_face_img = zeros(size(I));
    cropped_img = zeros(size(I));
    fprintf('[STEP-2] Cannot create marked face and cropped images.\n');
end

end