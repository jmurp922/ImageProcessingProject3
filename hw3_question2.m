%Problem 2 - James Murphy

%Load the 2 images
mercury = imread('Atlas-Mercury.png');
techno = imread('techno-trousers.png');

% Use the built in matlab function to do what was just hardcoded for
% comparison.

matlab_function = imhistmatch(mercury, techno);

%Turn the 2 images into  a double that can be operated on
mercury = double(mercury);
techno = double(techno);

%Grab the vector red
mercury_red = mercury(:,:,1);
techno_red = techno(:,:,1);

%Grab the vector for green
mercury_green = mercury(:,:,2);
techno_green = techno(:,:,2);

%Grab the vector for blue
mercury_blue = mercury(:,:,3);
techno_blue = techno(:,:,3);

%Take the mapped RGB values of mercury and techno and store it as
%individual RGB values
result_red = uint8(map_RGB(mercury_red,techno_red));
result_green = uint8(map_RGB(mercury_green, techno_green));
result_blue = uint8(map_RGB(mercury_blue, techno_blue));


%Convert those RGB Values into the resulting iamge
result_image = cat(3, result_red, result_green, result_blue);
result_image = uint8(result_image);


figure;
subplot(1,2,1)
imshow(matlab_function),title('MATLAB Histogram Function')
subplot(1,2,2)
imshow(result_image),title('Hard Coded Histogram')

compare = imsubtract(result_image, matlab_function);

function output = map_RGB(image_1, image_2)

    %Get the resulting histogram from image 1
    histogram_1 = get_histogram(image_1);
    %Get the resulting histogram from image 2
    histogram_2 = get_histogram(image_2);
    
    %Map the histogram to a table
    table = get_mapTable(histogram_1,histogram_2);
    
    output = map(image_1,table);
end



function img_output = map(img_input, table_input)
    [row, col, z] = size(img_input);
    
    for i = 1 : row
        for j = 1 : col
            %To take the output, take the inputted table in the function
            %and to get the value for i, j, take the 2, ((i, j) + 1)
            % store it into i, j
            img_output(i, j) = table_input(2, img_input(i,j)+1);
        end
    end
end

function hist_result = get_histogram(img_input)

    %Zero out the histogram from bits 2^1 to 2^8
    hist_result = zeros(2,256);
    
    %Take the double of the input
    img_input = double(img_input);
    
    %n a forloop, set each 'bit' from 1 to i as i - 1, so each position
    %is i - 1, so 0-255 for each position
    for i = 1:256
        hist_result(1, i) = i - 1;
    end
    
    % i is the row, j is the column iterate through the whole matrix
    % Get the dimensions by taking the size of the matrix.
    [row, col, z] = size(img_input);
    for i = 1:row
        for j = 1:col
            
            %get the value of the pixel at the current index i, j
            hist_value = img_input(i,j) + 1 ;
            
            %Increment each histogram value by 1
            hist_result(2, hist_value) = hist_result(2, hist_value) + 1;
        end
    end
    
    % Take the row * column to find the total num of pixels
    pixel_count = row*col;
    sum = 0;
    
    % In a loop from 2^1 -> 2^8
    for i = 1 : 256
        % Add sum with sum + the (2, i) value in the matrix for each pixel
        sum = sum + hist_result(2,i);
        
        %Take the ration of the sum divided by the total pixel count and
        %store it in it's 2, i pair
        
        hist_result(2,i) = sum / pixel_count;
        
    end   
end 

function table = get_mapTable(histogram_1, histogram_2)
    %Zero out table from 2 -> 256 (2^1 - 2^8)
    table = zeros(2, 256);
    
    %Map each i, j pairing to 1, i
    for i = 1:256
        table(1, i) = i;
    end
    
    for i = 1:256
        table(2,i) = find_clost(histogram_1(2,i),histogram_2);
    end
    
end

function pixval_output = find_clost(input, histogram)
    minimum = 100;
    pixval_output = 0;
    %From 2^1 -> 2^8 
    for i = 1 : 256
        %Take the absolute value of the (2, i) pair and subtract it from
        %the input incoming to the table
        difference = abs(histogram(2,i) - input);
        %Check if the difference value is smaller than the current minimum
        if difference < minimum
            %If the minimum is greater than the difference, swap the values
            minimum = difference;
            %Take the pixel value output and set it equal to the current
            %iteration in the histogram matrix
            
            pixval_output = histogram(1,i);
        end
    end
end