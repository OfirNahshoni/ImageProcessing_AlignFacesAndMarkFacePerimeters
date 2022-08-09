function [frames_arr,final_video_file_path,final_num_of_frames] = createFramesArr(file_path)
% Function to create a collection (cell) to all frames in given video.
% In addition this function creates new file with only detected faces.

% Initialize the final number of frames
final_num_of_frames = 0;
% Define name of final video file
final_video_file_path = 'final_new_video.avi';
% Create Video Reader object
video_reader = VideoReader(file_path);
video_writer = VideoWriter(final_video_file_path);
% Create Face Detector to delete the images undetected
faceDetector = vision.CascadeObjectDetector();

while hasFrame(video_reader)
    video_frame = readFrame(video_reader);
    bbox = step(faceDetector, video_frame);
    % If one face only detected, write to new video file
    if size(bbox, 1) == 1
        final_num_of_frames = final_num_of_frames + 1;
        open(video_writer);
        writeVideo(video_writer,video_frame);
    end
end

% Build collection for all frames in new video
frames_arr = cell(1,final_num_of_frames);

end