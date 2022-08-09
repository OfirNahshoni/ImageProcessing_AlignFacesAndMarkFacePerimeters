function [binary_rotated_only_face_img, binary_no_holes_img] = createBinaryCroppedRotatedImgAndFillHolesLoopF5(rotated_img,cropped_img,bbox,threshold,limits_vector)
% Purpose: 
% Given Arguments: 
% 1) I = RGB image with aligned only face.
% 2) threshold = The threshold value that specifies the convertion
% 3) lower = The lower limit of the filter.
% 4) upper = The upper limit of the filter.
% Return Variable: 

if size(bbox,1) == 1 % if face was detected in the rotated image
    % Convert to binary image - rotated only face image
    BW = rgb2gray(cropped_img) > threshold;
    % Binary only face image (rotated)
    binary_rotated_only_face_img = bwareafilt(BW, limits_vector);

    if sum(binary_rotated_only_face_img(:)) == 0 % if filtering failed
        BW = rgb2gray(rotated_img) > threshold;
%         limits_vector = [50000 120000];
        binary_rotated_only_face_img = bwareafilt(BW, limits_vector);
        binary_no_holes_img = imfill(binary_rotated_only_face_img,'holes');
    else % if filtering succeeded
        % Fill the holes in the face
        binary_no_holes_img = imfill(binary_rotated_only_face_img,'holes');
    end % if sum

else % if face was not detected or at least 2 faces were detected in the rotated image
    BW = rgb2gray(rotated_img) > threshold;
    binary_rotated_only_face_img = bwareafilt(BW, limits_vector);
    binary_no_holes_img = imfill(binary_rotated_only_face_img,'holes');
end % if size of bbox



end % function