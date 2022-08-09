%% Main file - Final Project

% Project Name: AMPF = Align Mark Perimter Faces in Video frames
% By: Ofir Nahshoni
% Course: Image Processing and Computer Vision
% Language & IDE: MATLAB

% Main Topics:
% 1) Operations on binary images
% 2) Geometric transformations


%% Pre-Processing - make new video with only the detected face frames

% Reading the video at the adderss file_path
video_read_path = 'images_and_videos\VideoJasmin3.mp4';
new_file_name = 'newVideo.avi';

% Reading and counting the amount of frames in the video file
num_of_frames = buildVideoAndCountNumOfFramesF0(video_read_path, new_file_name);


%% Filter the undetected faces frames that had not filtered in Pre-Processing

[frames_arr,final_video_file_path,final_num_of_frames] = createFramesArr(new_file_name);

% Start of processing step of step by step

%% Cycle 1 Step 1 - choose frame to run the algorithm on it
% ---------------------Start of Cycle 1--------------------

% Decision of user which frame to get
prompt = ['Hello, there are ' num2str(final_num_of_frames) ...
            ' frames in the video.\n' ...
            'Type the serial number of the frame that you want: '];

% Get input from user (integer - serial number of a frame)
serial_num_of_frame = input(prompt);

% Function to create the image represents the chosen frame - F1
[selected_frame,frames_arr] = createFramesArrAndFindSpecificFrameF1(final_video_file_path,frames_arr,serial_num_of_frame,final_num_of_frames);

% Display the chosen frame
figure('Name','Step 1: Input frame from video');
imshow(selected_frame);
title(['The frame you selected is number: ',num2str(serial_num_of_frame)]);


%% Cycle 1 step 2 - face recognition and marking in the selected frame

% Function to create the marked and the cropped face images - F2
[marked_face_img, cropped_img] = createMarkedAndCroppedImgsF2(selected_frame);


%% Cycle 1 step 3 - create gray scale image of the original frame and guess threshold

% Function to choose value to threshold for the frame based on histogram - F3
[gray_scale_img,threshold_my_guess,threshold_matlab_func] = createGrayScaleImgAndDisplayHistogramF3(cropped_img);


%% Cycle 1 step 4 - create 2 optional binary images to choose

% Function to compute the create binary images and display them - F4
[binary_my_guess_img, binary_matlab_func_img] = createBinaryImgsAndDisplayF4(gray_scale_img, threshold_my_guess, threshold_matlab_func);


%% Cycle 1 step 5 - find the horizontal angle of the face
% ---------------------End of Cycle 1--------------------

% Check if threshold that was entered in Step 3 is legal value (positive
% number)
if threshold_my_guess > 0
    % Choose binary image to work with and calculate the areas of all objects
    [num_of_chosen_binary_img, binary_chosen_img] = chooseBinaryImgAndDisplayAreasObjs(binary_my_guess_img, binary_matlab_func_img);
    % Limits to filter
    lower_limit_area = 12000;
    upper_limit_area = 15000;
    % Function to create only face image and calculate theta - F5
    [only_face_img, theta] = createOnlyFaceImgAndCalculateThetaF5(binary_chosen_img, lower_limit_area, upper_limit_area);
else
    theta = 0;
    fprintf('[STEP-5]h cannot filtering the image.\n');
end % if threshold_my_guess

fprintf(['Calculated theta is ' num2str(theta) '\n']);


%% Cycle 2 step 6 - rotate the original RGB image by theta

% Function to rotate the image - F6
rotated_img = createRotatedImgAndDisplayF6(selected_frame, theta);


%% Cycle 2 step 7 - detect face in the rotated original RGB image

% Function to detect the face in the rotated image - F7
[original_face_aligned_img, bbox] = createmarkedFaceAlignedImgAndDisplayF7(rotated_img);


%% Cycle 2 step 8 - create only face aligned RGB image

% Function to crop the rotated RGB image - F8
cropped_aligned_img = createCroppedRotatedImgF8(rotated_img, bbox);


%% Cycle 2 step 9 - fill the holes in the binary image

% Choosing the binary image to work with - by the threshold specified
while 1
    % Choose binary image to work with
    prompt = 'Please press 1 to my guess threshold or 2 to matlab threshold: ';
    x = input(prompt); % 1 or 2 - specify the threshold
    if x == 1
        threshold = threshold_my_guess;
        break
    elseif x == 2
        threshold = threshold_matlab_func;
        break
    else
        fprintf('Wrong input, please try again.\n');
    end % if x
end % while

if sum(cropped_aligned_img(:)) > 0 % if steps 7 & 8 failed
    % Function to convert the cropped rotated image into binary image - F9
    [binary_rotated_only_face_img, binary_no_holes_img] = createBinaryImgAndFillHolesF9(cropped_aligned_img, threshold, lower_limit_area, upper_limit_area);
else
    % Function to convert the cropped rotated image into binary image - F9
    [binary_rotated_only_face_img, binary_no_holes_img] = createBinaryImgAndFillHolesF9(rotated_img, threshold, lower_limit_area, upper_limit_area);
end % if sum(cropped_aligned_img)

props_rotated_img = regionprops(binary_rotated_only_face_img,'Orientation');
theta_rotated_img = props_rotated_img.Orientation;
fprintf(['The theta after rotation is ' num2str(theta_rotated_img) '\n']);


%% Cycle 2 step 10 - disconnect eyebrows with opening method and fill holes

% Input for how much time doing opening
prompt = 'Please enter number of times that you want to do opening to the frame: ';
n = input(prompt);

% Function to disconnect eyebrows
binary_clean_face_img = disconnectEyeborwsOpeningF10(binary_no_holes_img,n);

p = regionprops(binary_clean_face_img,'MinorAxisLength','MajorAxisLength');
minor_axis = p.MinorAxisLength;
major_axis = p.MajorAxisLength;
% Measurement for mark face perimeter
ratio_major_minor = minor_axis/major_axis;

fprintf(['MinorAxisLength = ' num2str(minor_axis) '\n']);
fprintf(['MajorAxisLength = ' num2str(major_axis) '\n']);


props_clean_face_img = regionprops(binary_clean_face_img,'Area');

if isempty(props_clean_face_img) % if a is empty string
    fprintf(['Final area = ' num2str(0) '\n']);
else
    a = props_clean_face_img.Area;
    fprintf(['Final area = ' num2str(a) '\n']);
end % if props_clean_face_img


%% Cycle 2 steps 11 and 12 - find perimeter of the face

if sum(cropped_aligned_img(:)) == 0 % if steps 7 & 8 failed
    % Function to find the image with face perimeter only
    binary_perimeter_img = createPerimeterFaceImgF11(binary_clean_face_img);
    % Function to showing the output image
    markFacePerimeterAndDisplayF12(serial_num_of_frame, binary_perimeter_img, rotated_img);
else
    % Function to find the image with face perimeter only
    binary_perimeter_img = createPerimeterFaceImgF11(binary_clean_face_img);
    % Function to showing the output image
    markFacePerimeterAndDisplayF12(serial_num_of_frame, binary_perimeter_img, cropped_aligned_img);
end % if sum(cropped_aligned_img)

% End of processing step of step by step