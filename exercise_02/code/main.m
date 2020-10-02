% Vision Algorithms for Mobile Robotics
% Exercise 02 - PnP
% Beat Hubmann

close all;
clear all;

% Load parameters and inputs ----------------------------------------------
% Camera intrinsics
K = load('../data/K.txt'); % Calibration matrix [3 x 3]

% Load corner points 3-D world reference coordinates: 
p_W_corners = load('../data/p_W_corners.txt');  % 3-D point coordinate matrix [n x 3]
p_W_corners = 0.01 * p_W_corners; % Convert cm -> m

% Establish number of points we're dealing with:
num_corners = size(p_W_corners, 1); % n = 12 (in this exercise)

% Load detected corner points projected 2-D coordinates:
detected_corners = load('../data/detected_corners.txt'); % nn rows of 2-D point coordinates [nn x (n*2)]
% Establish number of images we're dealing with:
num_images = size(detected_corners, 1); % nn = 210 (in this exercise)


% Set up data structures for composing movie later on:
transl = zeros(num_images, 3);
quats = zeros(num_images, 4);

% Iterate over images and find camera poses using DLT
for img_index=1:num_images
    % Calculate M with DLT:
    points_2d = reshape(detected_corners(img_index, :), 2, num_corners)'; % cols of 2-D points coordinates [n x 2]
    M = estimatePoseDLT(points_2d, p_W_corners, K); % Apply DLT
    
    % Obtain building blocks for movie generation:
    C_R_W = M(:, 1:3); % M = [C_R_W | C_t_W]
    C_t_W = M(:, 4);  % M = [C_R_W | C_t_W]
    W_R_C = C_R_W'; % Invert rotation matrix
    W_t_C = -W_R_C * C_t_W; % Invert translation
    quats(img_index, :) = rotMatrix2Quat(W_R_C); % Convert to quaternions and record
    transl(img_index, :) = W_t_C; % Record
    
    % Test functionality & precision for first image by plotting:
    if (img_index == 1) 
        % Reproject points:
        points_reprojected = reprojectPoints(p_W_corners, M, K); % Use M to project original 3-D points next to points_2d
        % Read image:
        filename = ['img_', sprintf('%04d', img_index), '.jpg']; % Format image index into filename
        img = imread(['../data/images_undistorted/', filename]); % Read image
        % Plot image:
        figure(img_index);
        imshow(img);
        hold on;
        plot(points_2d(:, 1), points_2d(:, 2), 'b o'); % Original
        plot(points_reprojected(:, 1), points_reprojected(:, 2), 'r +'); % Reprojected
        legend('Original points', 'Reprojected points');
        hold off;
    end
end

% Generate movie:
fps = 30; % 30 frames per second
plotTrajectory3D(fps, transl', quats', p_W_corners');


