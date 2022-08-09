function binary_perimeter_img = createPerimeterFaceImgF11(I)
% Purpose: 
% Given Arguments: 
% Return Variable: 

% Starting massage
fprintf('[STEP-11] Searching the face perimeter pixels...\n');

SE = ones(3); % Structuring Element

% Dilated image
dilated_I = imdilate(I,SE);
% The substruction image 
binary_perimeter_img = abs(dilated_I - I);

% Display the binary perimeter face only
figure('Name','Step 11: Only face perimeter rotated');
imshow(binary_perimeter_img);
title('Only face perimeter - outPerim2');

% Ending massage
fprintf('[STEP-11] Perimeter image was successfully created.\n');

end