%HW_1 PART 1

%Take the everest expedition image and convert it to grayscale and then
%A double to work on it
img = imread('Everest_expedition.jpg');
img = rgb2gray(img);
img = double(img);

% Take the current plane, divide it by the plane it is, take the floor of
% that and then mod it by 2.
plane_1 = mod(floor(img/(2^0)),2);
plane_2 = mod(floor(img/(2^1)),2);
plane_3 = mod(floor(img/(2^2)),2);
plane_4 = mod(floor(img/(2^3)),2);
plane_5 = mod(floor(img/(2^4)),2);
plane_6 = mod(floor(img/(2^5)),2);
plane_7 = mod(floor(img/(2^6)),2);
plane_8 = mod(floor(img/(2^7)),2);

%Raise each plane to it's respective bit location

bit_0 = plane_1 * 2^0;
bit_1 = plane_2 * 2^1;
bit_2 = plane_3 * 2^2;
bit_3 = plane_4 * 2^3;
bit_4 = plane_5 * 2^4;
bit_5 = plane_6 * 2^5;
bit_6 = plane_7 * 2^6;
b = plane_8 * 2^7;

% set all 4 high bitplanse as zero
upper_plane = zeros(size(img));
upper_plane = imadd(upper_plane, bit_0);
upper_plane = imadd(upper_plane, bit_1);
upper_plane = imadd(upper_plane, bit_2);
upper_plane = imadd(upper_plane, bit_3);
upper_plane = uint8(upper_plane);

% set all 4 low bitplanse as zero
lower_plane = zeros(size(img));
lower_plane = imadd(lower_plane, bit_4);
lower_plane = imadd(lower_plane, bit_5);
lower_plane = imadd(lower_plane, bit_6);
lower_plane = imadd(lower_plane, c8);
lower_plane = uint8(lower_plane)
img = uint8(img);
figure;

%plot the image
subplot(1,3,1)
imshow(img), title('Grayscale Original Image');
subplot(1,3,3)
imshow(upper_plane), title('Removed Upper Bitplane');
subplot(1,3,2)
imshow(lower_plane), title('Removed Lower Bitplane');
