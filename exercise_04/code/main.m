% Vision Algorithms for Mobile Robotics
% Exercise 04 - Scale-Invariant Feature Transform
% Beat Hubmann, VAMR course team (derotatePatch.m, getImage.m),
% and Peter Kovesi (weightedhistc.m)

clear all;
close all;

% Set up global parameters
num_scales = 3; % Scales per octave
num_octaves = 5; % Number of octaves
sigma = 1.6; % Base sigma for difference of Gaussians (DoG)
contrast_threshold = 0.04; % Noise surpression treshold

% Load sample images
image_file_1 = '../data/images/img_1.jpg';
image_file_2 = '../data/images/img_2.jpg';
rescale_factor = 0.2; % Rescaling of the original image for speed.

images = {getImage(image_file_1, rescale_factor),...
          getImage(image_file_2, rescale_factor)};

% Set up data structures for final keypoints, image descriptors
kpt_locations = cell(1, 2);
descriptors = cell(1, 2);

% Loop over sample image pair
for img_idx = 1:2
    % Get image pyramid of size num_octaves
    image_pyramid = getImagePyramid(images{img_idx}, num_octaves);
    % Get blurred images per octave, num_scales+3 blurred images each
    blurred_images = getBlurredImages(image_pyramid, num_scales, sigma);
    % Get DoG per octave, num_scales+2 each
    diff_gaussians = getDoGs(blurred_images);
    % Get keypoints with non-maximum suppression, discard low-contrast keypoints
    kpt_candidates = getKeypoints(diff_gaussians, contrast_treshold);
    % Get descriptors & final keypoints, discard close-to-border keypoints
    [kpt_locations{img_idx}, descriptors{img_idx}] = ...
        getFinalKeypointsDescriptors(blurred_images, kpt_candidates)
end

% Match descriptors between the sample images using the Computer Vision Toolbox
index_pairs = matchFeatures(descriptors{1}, descriptors{2});

% Retrieve the locations of the corresponding points for each image
matched_points_1 = kpt_locations{1}(index_pairs(:, 1), :);
matched_points_2 = kpt_locations{2}(index_pairs(:, 2), :);

% Visualize the corresponding points using the Computer Vision Toolbox
figure;
showMatchedFeatures(images{1}, images{2}, ...
                    matched_points_1, matched_points_2);