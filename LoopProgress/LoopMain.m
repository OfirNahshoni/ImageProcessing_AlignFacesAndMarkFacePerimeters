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
fprintf(['Number of frames in new video is: ' num2str(num_of_frames) '\n']);


%% Filter the video one more time and create cell array in the correct frames

[frames_arr,final_video_file_path,final_num_of_frames] = createFramesArr(new_file_name);
fprintf(['Number of frames in final video is: ' num2str(final_num_of_frames) '\n']);

video_reader = VideoReader(final_video_file_path);
for i=1:final_num_of_frames
    video_frame = readFrame(video_reader);
    frames_arr{i} = video_frame;
end % for


%% Define all the variables to loop all frames

% Thresholds vector - guesses
thresholds_vector = 115:120;

% Limits vector to filter the binary image
areas_limits_vector = [12000 15000];


%% Define measurements as vectors/matrices:

% size(thresholds_vector,2) -> number of rows in the matrices
num_of_thresholds = size(thresholds_vector,2);
% Angle errors: if abs(theta_rotated_img - 90) < 1 success, else failure
angles_error_matrix = zeros(num_of_thresholds,final_num_of_frames);
% Minor axis length: if 110 <= Minor <= 119 success, else failure
minor_axis_length_matrix = zeros(num_of_thresholds,final_num_of_frames);
% Major axis length: if 160 <= Major <= 170 success, else failure
major_axis_length_matrix = zeros(num_of_thresholds,final_num_of_frames);
% Area of the face -> area of final object (clean face)
areas_final_face_matrix = zeros(num_of_thresholds,final_num_of_frames);
% Matrix that stores whether the rotation transformation was successful for
% each frame
rotation_results_matrix = zeros(num_of_thresholds,final_num_of_frames);
% Matrix that stores whether face perimeter were found successfully for
% each frame
face_perimeter_results_matrix = zeros(num_of_thresholds,final_num_of_frames);


%% Running all frames at once in a for loop

for t = 1:num_of_thresholds
    threshold = thresholds_vector(t);
    for f = 1:final_num_of_frames
         % Specific frame in video
        frame = frames_arr{f};

        % Step 1 - Create marked, cropped and binary images
        [marked_face_not_rotated, cropped_frame_not_rotated] = createCroppedImgRGBLoopF1(frame);
        % Create gray scale image only face not rotated
        cropped_gray_scale_frame = rgb2gray(cropped_frame_not_rotated);
        % Create binary image from the cropped gray scale image
        binary_img = cropped_gray_scale_frame > threshold;

        % Step 2 - Create only face image (binary image) and calculate theta (angle
        % to rotate by)
        [only_face_img, theta] = createOnlyFaceImgAndCalculateThetaLoopF2(binary_img, areas_limits_vector);

        % Step 3 - Rotate the frame by theta
        rotated_img = createRotatedRGBImgLoopF3(frame, theta);

        % Step 4 - Detect the face on the rotated image (aligned face RGB image)
        [original_face_aligned_img,bbox,cropped_face_aligned_img] = createmarkedFaceAlignedRGBImgLoopF4(rotated_img);

        % Step 5 - Convert the cropped aligned face RGB image
        [binary_rotated_only_face_img, binary_no_holes_img] = createBinaryCroppedRotatedImgAndFillHolesLoopF5(rotated_img,cropped_face_aligned_img,bbox,threshold,areas_limits_vector);
        
        % Step 6 - Create clean face image and disconnect eyebrows from the face perimeter
        [binary_clean_face_img,props_clean_face] = createCleanFaceImgAndDisconnectEyebrowsLoopF6(binary_no_holes_img,1);
        
        % Check if the clean face image was successfully done
        if isempty(props_clean_face)
            theta_rotated_img = 0;
            minor_axis_length_matrix(t,f) = 0;
            major_axis_length_matrix(t,f) = 0;
        else
            theta_rotated_img = props_clean_face.Orientation;
            minor_axis_length_matrix(t,f) = props_clean_face.MinorAxisLength;
            major_axis_length_matrix(t,f) = props_clean_face.MajorAxisLength;
        end % if props_clean_face

        if theta_rotated_img >= 0
            angles_error_matrix(t,f) = abs(theta_rotated_img - 90);
        else
            angles_error_matrix(t,f) = abs(theta_rotated_img + 90);
        end % if theta_rotated_img
        
        % Find the perimeter face image to diplay the output image
        face_perimeter_img = bwperim(binary_clean_face_img,8);
        [xPerim,yPerim] = find(face_perimeter_img);
        
        % Decide about success or failure of specific frame
        % The success of the rotation transformation
        if angles_error_matrix(t,f) < 2 % Success
            rotation_results_matrix(t,f) = 1;
        else % Failure
            rotation_results_matrix(t,f) = 0;
        end % if angle error
        % The success of finding face perimeter correctly
        if ((112 <= minor_axis_length_matrix(t,f)) && (minor_axis_length_matrix(t,f) <= 118)) && ((160 <= major_axis_length_matrix(t,f)) && (major_axis_length_matrix(t,f) <= 170))
            face_perimeter_results_matrix(t,f) = 1;
        else
            face_perimeter_results_matrix(t,f) = 0;
        end % if minor and major axis lengths

    end % for frames
end % for thresholds


%% Check the results

% Create a table of number of frames that were gived successful outputs
rotation_successes = zeros(num_of_thresholds,1); 
perimeter_successes = zeros(num_of_thresholds,1);

% Calculate the number of successes according to different values of
% thresholds between [115,120]
for i=1:num_of_thresholds
    rotation_successes(i) = sum(rotation_results_matrix(i,:));
    perimeter_successes(i) = sum(face_perimeter_results_matrix(i,:));
end % for

final_results = table(thresholds_vector',rotation_successes,perimeter_successes, ...
    'VariableNames',{'Thresholds','Number of rotated frames successfully','Number of maked face perimeter frames successfully'});

disp(final_results);