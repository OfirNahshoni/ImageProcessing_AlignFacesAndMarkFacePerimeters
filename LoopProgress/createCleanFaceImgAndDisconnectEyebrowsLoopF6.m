function [binary_clean_face_img,props_clean_face] = createCleanFaceImgAndDisconnectEyebrowsLoopF6(BW,n)
% Purpose: 
% Given Arguments: 
% Return Variable: 

BWInv = BW == 0;
SE = ones(3); % Structuring Element

% First Erosion
BErode = imerode(BWInv,SE);

% Erosion n times
for i=1:n
    BErode = imerode(BErode,SE);
end % for Erosion

% First Dilation
BDilate = imdilate(BErode,SE);

% Dilation n times
for i=1:n
    BDilate = imdilate(BDilate,SE);
end % for Dilation

% Return to original binary image
binary_clean_face_img = BDilate == 0;
% Fill the holes left in the face
binary_clean_face_img = imfill(binary_clean_face_img,'holes');

% Find the theta of the clean face image
props_clean_face = regionprops('table',binary_clean_face_img,'Orientation','MinorAxisLength','MajorAxisLength');


end % function