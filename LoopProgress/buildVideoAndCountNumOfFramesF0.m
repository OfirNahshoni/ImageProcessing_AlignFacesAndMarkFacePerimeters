function num_of_frames = buildVideoAndCountNumOfFramesF0(video_read_path, new_file_name)
% Purpose: The main goal of this function is that it takes an input video,
% given at the address video_read_path, and writes the frames only that
% were detected a face in it, by the faceDetector (using Viola and Jones
% algorithm to detect a face in image). Despite that, this filtering
% process doesn't act expectively as he should, because there are some
% frames that were remained  undected face in it. So there would be
% expected another filtering process like that...
% Given Arguments: 
% 1) video_read_path - Address of the original file
% 2) new_file_name - Address of the file which contains only frame who has
% frames that were detected a face in it, by the faceDetector
% Return Variable: num_of_frames - Integer, number of frames in video

% Starting massage
fprintf('[STEP-PreProcess] Starting: building new video and counting process...\n');

% Video objects
video_reader = VideoReader(video_read_path);
video_writer = VideoWriter(new_file_name);

% Amount of good frames - identify one face only
num_of_frames = 0;

% Create Face Detector to delete the images undetected
faceDetector = vision.CascadeObjectDetector();

while hasFrame(video_reader)
    % Read frame from video
    videoFrame = readFrame(video_reader);
    % Check if faceDetector detect a face in frame
    bbox = step(faceDetector, videoFrame);
    % If one face only detected, write to new video file
    if size(bbox, 1) == 1
        num_of_frames = num_of_frames + 1;
        open(video_writer);
        writeVideo(video_writer,videoFrame);
    end % if bbox
end % while

% Ending massage
fprintf(['[STEP-PreProcess] Finished: building new video and ' ...
            'counting process was successfully finished.\n']);
end % function