function img_undistorted = undistortImage(img, K, D)
% Remove lens distortion from given image
% IN:   Distorted source image
% IN:   Camera matrix
% IN:   Distortion coefficients
% OUT:  Undistorted image

[height, width] = size(img); % Get image dimensions
num_pixels = height * width;

[X, Y] = meshgrid(1:width, 1:height); % Set up meshgrid to define pixels
pixels = [X(:)-1, Y(:)-1, ones(num_pixels, 1)]'; % Pixel matrix zero-based [3 x num_pixels]
pixels_normalized = K^(-1) * pixels; % Normalize pixels
pixels_normalized = pixels_normalized(1:2, :); % Remove z coordinate
pixels_normalized_distorted = distortPoints(pixels_normalized, D); % Distort normalized pixels
pixels_normalized_distorted = [pixels_normalized_distorted;
                               ones(1, num_pixels)]; % Augment z coordinate
pixels_distorted = K * pixels_normalized_distorted; % Reverse normalization
pixels_distorted = pixels_distorted(1:2, :); % Remove z coordinate augmentation
pixels_distorted_integer = round(pixels_distorted); % Round pixel coordinates to nearest integer values
pixel_grayscales = img(height*pixels_distorted_integer(1, :) + pixels_distorted_integer(2, :)); % Read out pixel greyscale values at coordinates
img_undistorted = uint8(reshape(pixel_grayscales, [height, width])); % Reshape pixel values into image shape, convert to 256-bit
end