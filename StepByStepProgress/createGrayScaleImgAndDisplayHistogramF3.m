function [gray_scale_img,threshold_my_guess,threshold_matlab_func] = createGrayScaleImgAndDisplayHistogramF3(I)
% Purpose: This function helps the user to decide on the right value
% to threshold, based on looking on the histogram.
% Given Arguments: I = RGB input image.
% Return Variable: No variables.

% Starting massage
fprintf('[STEP-3] Starting creating the gray scale image...\n');

% Check if detect the face
if sum(I(:)) > 0
    % Create gray scale image
    gray_scale_img = rgb2gray(I);
    
    % Figure display gray scale and histogram
    figure('Name','Display the gray scale image and her histogram');
    subplot(1,2,1); imshow(gray_scale_img);
    title('Gray scale image - GC');
    subplot(1,2,2); histogram(gray_scale_img);
    title('Histogram of gray Jasmin');
    xlabel('f - gray scale value');
    ylabel('h(f)');
    
    % Get input from user to guess the threshold
    prompt = ['Look at the histogram of the gray scale image ' ...
                'write your guess to threshold value: '];
    threshold_my_guess = input(prompt);
    
    % Compute threshold value with matlab function
    threshold_matlab_func = graythresh(gray_scale_img) * 255;
    
    % Ending massage
    fprintf('[STEP-3] Ending creating the gray scale process...\n');
else
    gray_scale_img = zeros(size(I));
    threshold_my_guess = 0;
    threshold_matlab_func = 0;
    fprintf('[STEP-3] Cannot create gray scale image.\n');
end

end