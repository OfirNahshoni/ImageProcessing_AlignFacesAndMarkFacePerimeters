function [selected_frame,frames_arr] = createFramesArrAndFindSpecificFrameF1(file_path,frames_arr,serial_num_of_frame,num_of_frames)
% Purpose: This function is reading the video, create an array of frames,
% and find the requested frame, specified by serial_num_of_frame.
% Given Arguments:
% 1) file_path = The path to the video file to read from.
% 2) serial_num_of_frame = The serial number of the frame in the array.
% 3) num_of_frames = Number of frames in the video file.
% Return Variable: 
% 1) selected_frame = The image represents the selected frame.
% 2) framesArr = The array contains all the frames from the video file.

% Starting massage
fprintf('[STEP-1] Starting: creating frames array and searching specific frame process...\n');

% Create Video Reader object
video_reader = VideoReader(file_path);

% Run the input video on the Video Player
for i=1:num_of_frames
    video_frame = readFrame(video_reader);
    frames_arr{i} = video_frame;
end

% Save the output image - the specified frame that was chosen by the user
selected_frame = frames_arr{serial_num_of_frame};

% End success massage
fprintf(['[STEP-1] Finished: creating frames array and searching ' ...
            'specific frame process was successfully finished.\n']);

end