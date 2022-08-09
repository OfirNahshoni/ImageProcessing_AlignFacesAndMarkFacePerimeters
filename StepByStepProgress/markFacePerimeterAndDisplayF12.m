function markFacePerimeterAndDisplayF12(serial_num_of_frame, binary_perimeter_img, rgb_img)

% Starting massage
fprintf('[STEP-12] Starting: mark face perimeter process starting...\n');

% Save the pixels of the frame in 2 vectors (rows,cols)
[xPerim,yPerim] = find(binary_perimeter_img);

% First figure - Display cropped images
figure('Name','Step 12: Display output image of the choosen frame'); 
imshow(rgb_img);
hold on;
plot(yPerim,xPerim,'r.');
title(['Output image for frame number ' num2str(serial_num_of_frame)]);

% Ending massage
fprintf('[STEP-12] Finished: mark face perimeter process was successfully finished.\n');

end % function