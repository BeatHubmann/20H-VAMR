function scores = harris(img, patch_size, kappa)
% Calculates the Harris score for feature detection on given image
% IN:   Grayscale imput image: img [h x w]
% IN:   Scalar size of square patch in one dimension, odd number: patch_size
% IN:   Scalar 'magic number' hyperparameter in (0.04, 0.15): kappa
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

% Harris: R = det(M) - kappa*trace(M)^2
detM = sum_Ixx .* sum_Iyy - sum_Ixy .^ 2;
traceM = sum_Ixx + sum_Iyy;
scores = detM - kappa * traceM .^2;

% set negative scores to zero
scores(scores<0) = 0;

% pad score array to make sure score is returned for each pixel
patch_radius = floor(patch_size / 2);
padsize = [1+patch_radius 1+patch_radius];
scores = padarray(scores, padsize);
end
