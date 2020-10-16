function descriptors = describeKeypoints(img, keypoints, r)
% Returns a matrix of descriptive image patch vectors based on an 
% input image together with its corresponding keypoints.
% IN:   Grayscale imput image: img [h x w]
% IN:   2-D coordinate array of N keypoints: keypoints [2 x N]
% IN:   Scalar patch radius for keypoint descriptor patches: r
% OUT:  Matrix containing N keypoint descriptor patch 
%       vectors: descriptors [(2r+1)^2 x N]

% pad img array to allow square descriptor patches to reach every pixel
pad_img = padarray(img, [r r]);

% establish number of keypoints in play
N = size(keypoints, 2);

% set up 2-D array to store results
descriptors = zeros((2*r+1)^2, N);

% iterate over N keypoints, reshape their surrounding box with
% patch radius r into a column vector and save into output
for i = 1:N
    row = keypoints(1, i) + r; % keypoint i row corrected for padding
    col = keypoints(2, i) + r; % keypoint i col corrected for padding
    % reshape i-th descriptor patch into column vector of size [[%auto] x 1]
    descriptors(:, i) = reshape(pad_img(row-r:row+r, col-r:col+r), [], 1);
end