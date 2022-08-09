function [num_of_chosen_binary_img, binary_chosen_img] = chooseBinaryImgAndDisplayAreasObjs(BW1,BW2)
% Purpose: This function asks the user repeadetely to choose one binary
% image to work with and returns the number of the chosen image
% Given Arguments: 
% Return Variable: 

% Get only correct input from the user and define the output binary image
while 1
    % Get the selected binary image
    prompt = 'Enter 1 to take guess image or 2 to take matlab function image: ';
    num_of_chosen_binary_img = input(prompt);

    % Calculate the areas of all objects
    if num_of_chosen_binary_img == 1
        props_objects = regionprops('table',BW1,'Area');
%         disp(props_objects);
        binary_chosen_img = BW1;
        break
    elseif num_of_chosen_binary_img == 2
        props_objects = regionprops('table',BW2,'Area');
%         disp(props_objects);
        binary_chosen_img = BW2;
        break
    else
        fprintf('Wrong input, try again (enter 1 or 2)...\n');
    end
end

% The object with maximum area
fprintf('The object with maximum area is (after filter):\n');
max_area = max(props_objects{:,1});

disp(max_area);

end