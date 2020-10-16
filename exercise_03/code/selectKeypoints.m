function keypoints = selectKeypoints(scores, num, r)
% Selects the set amount highest scores as keypoints and performs non-maximum 
% supression of a (2r + 1)*(2r + 1) box around the current maximum.
% IN:   Array of scores to select from: scores [h x w]
% IN:   Scalar number of highest scores to select: num
% IN:   Surpression radius to for non-maxima surpression: r
% OUT:  2-D coordinate array of num keypoints: keypoints [2 x num]

% pad scores array to allow surpression box to reach every pixel
pad_scores = padarray(scores, [r r]);

% set up 2-D array to store results
keypoints = zeros(2, num);

% iterate num times over padded scores, find maximum each time,
% add maximum to keypont list, then surpress box centered on keypoint
for i = 1:num
    [~, ind] = max(pad_scores(:)); % linear index of maximum
    [row, col] = ind2sub(size(pad_scores), ind); % padded row, col of maximum
    keypoints(:, i) = [row - r;
                       col - r]; % correct keypoint for padding, save
    pad_scores(row-r:row+r, col-r:col+r) = false; % apply surpression box
end

