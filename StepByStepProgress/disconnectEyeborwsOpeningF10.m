function binary_clean_face_img = disconnectEyeborwsOpeningF10(BW,n)
% Description:

BWInv = BW == 0;
SE = ones(3); % Structuring Element

% First Erosion
BErode = imerode(BWInv,SE);

% Erosion n times
for i=1:n
    BErode = imerode(BErode,SE);
end

% First Dilation
BDilate = imdilate(BErode,SE);

% Dilation n times
for i=1:n
    BDilate = imdilate(BDilate,SE);
end

% Return to original binary image
binary_clean_face_img = BDilate == 0;

% Fill the holes left in the face
binary_clean_face_img = imfill(binary_clean_face_img,'holes');

end