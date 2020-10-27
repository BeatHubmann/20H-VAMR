% Vision Algorithms for Mobile Robotics
% Exercise 04 - Scale-Invariant Feature Transform
% Beat Hubmann, VAMR course team (derotatePatch.m, getImage.m),
% and Peter Kovesi (weightedhistc.m)

clf;
clear all;
close all;

% set up global parameters
num_scales = 3; % scales per octave
num_octaves = 5; % number of octaves
sigma_0 = 1.6; % base level sigma for Gaussian blurring
contrast_threshold = 0.04; % noise surpression treshold

% load sample images
image_file_1 = '../data/images/img_1.jpg';
image_file_2 = '../data/images/img_2.jpg';
rescale_factor = 0.2; % Rescaling of the original image for speed.

images = {getImage(image_file_1, rescale_factor),...
          getImage(image_file_2, rescale_factor)};

% set up data structures for final keypoints, image descriptors
kpt_locations = cell(1, 2);
descriptors = cell(1, 2);

% loop over sample image pair
for img_idx = 1:2
    % get image pyramid of size num_octaves
    image_pyramid = getImagePyramid(images{img_idx}, num_octaves);
    % get blurred images per octave, num_scales+3 blurred images each
    blurred_images = getBlurredImages(image_pyramid, num_scales, sigma_0);
    % get DoG per octave, num_scales+2 each
    DoGs = getDoGs(blurred_images);
    % get keypoints with non-maximum suppression,
    % discard low-contrast keypoints
    kpt_candidates = getKeypoints(DoGs, contrast_threshold);
    % get descriptors & final keypoints
    [kpt_locations{img_idx}, descriptors{img_idx}] = ...
        getFinalKeypointsDescriptors(blurred_images, kpt_candidates)
end

% match descriptors between the sample images using the Computer Vision Toolbox
index_pairs = matchFeatures(descriptors{1}, descriptors{2});

% retrieve the locations of the corresponding points for each image
matched_points_1 = kpt_locations{1}(index_pairs(:, 1), :);
matched_points_2 = kpt_locations{2}(index_pairs(:, 2), :);

% visualize the corresponding points using the Computer Vision Toolbox
figure;
showMatchedFeatures(images{1}, images{2}, ...
                    matched_points_1, matched_points_2);