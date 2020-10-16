function scores = shi_tomasi(img, patch_size)
% Calculates the Shi-Tomasi score for feature detection on given image
% IN:   Grayscale imput image: img [h x w]
% IN:   Scalar size of square patch in one dimension, odd number: patch_size
% OUT:  Corner response function values of img: scores [h x w]

% assemble Sobel filter
sobel = [1, 2, 1]' * [-1, 0, 1];

% img free of noise => apply Sobel filter without smoothing,
% obtain image first partial derivatives
Ix = conv2(img, sobel, 'valid');
Iy = conv2(img, sobel', 'valid');

% obtain pixel-wise products of gradients
Ixx = Ix .^ 2;
Iyy = Iy .^ 2;
Ixy = Ix .* Iy;

% assemble box filter
box = ones(patch_size, patch_size);

% apply box filter
sum_Ixx = conv2(Ixx, box, 'valid');
sum_Iyy = conv2(Iyy, box, 'valid');
sum_Ixy = conv2(Ixy, box, 'valid');

% Shi-Tomasi: R = min(lambda1, lambda2) > treshold
% to find lower eigenvalue pixel-wise, use that
% for M = [M11 M12]
%         [M21 M22]
% lambda1, lambda2 = ((M11+M22)+-sqrt((M11-M22).^2 + 4*M12.^2))/2
% where lambda1 >= lambda2
scores = ((sum_Ixx+sum_Iyy) - sqrt((sum_Ixx-sum_Iyy).^2 + 4*sum_Ixy.^2))/2;

% set negative scores to zero
scores(scores<0) = 0;

% pad score array to make sure score is returned for each pixel
patch_radius = floor(patch_size / 2);
padsize = [1+patch_radius 1+patch_radius];
scores = padarray(scores, padsize);






