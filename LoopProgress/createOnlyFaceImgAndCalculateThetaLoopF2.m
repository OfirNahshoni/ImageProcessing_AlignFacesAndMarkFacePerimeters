function [only_face_img, theta] = createOnlyFaceImgAndCalculateThetaLoopF2(BW, area_limits_vector)
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

% Properties of the given binary image
props_bw = regionprops('table',BW,'Orientation');

% Filter the binary image from all objects, except the face
only_face_img = bwareafilt(logical(BW),area_limits_vector);

if sum(only_face_img(:)) > 0 % If filtering succeeded
    props_only_face = regionprops(only_face_img,'Orientation');
    theta = props_only_face.Orientation;
    if theta < 0
        theta = theta + 90;
    else
        theta = theta - 90;
    end % if theta
else
    theta = max(props_bw.Orientation);
end % if sum

end % function