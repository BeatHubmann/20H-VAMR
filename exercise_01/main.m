% Vision Algorithms for Mobile Robotics
% Exercise 01 - Augmented reality wireframe cube
% Beat Hubmann


close all;
clear all;

% Load parameters:
% Camera intrinsics
K = load('./data/K.txt'); % Calibration matrix [3 x 3]
D = load('./data/D.txt'); % Distortion parameters [2 x 1] 
% Camera poses
poses = load('./data/poses.txt'); % Camera poses [N x 6], see problem statement


% Load test image
i = 1; % Image number
filename = ['img_', sprintf('%04d', i), '.jpg']; % Format image number into filename
img = imread(['./data/images/', filename]); % Read RGB image
img = rgb2gray(img); % Convert RGB to grayscale


% Set up checkerboard, see problem statement
square_size = 0.04; % Checkerboard square size 4cm
num_corners_x = 9; % Corners in horizontal direction
num_corners_y = 6; % Corners in vertical direction

[X, Y] =  meshgrid(0:num_corners_x-1, 0:num_corners_y-1); % 2-D grid coordinates
P_W_corners = square_size * [X(:) Y(:)]; % Rescale and shape into row vectors
P_W_corners = [P_W_corners'; % Transpose to column vectors,
               zeros(1, num_corners_x*num_corners_y)];  % Add z coordinate
           

% Obtain homogeneous transformation matrix C_T_W mapping world->camera
% for loaded test image
pose_vector = poses(i, :); % Pose vector of image i
C_T_W = poseVectorToTransformationMatrix(pose_vector); % Obtain C_T_W for pose vector


% Transform checkerboard corners world->camera using transformation matrix
P_W_corners = [P_W_corners; % 3-D checkerboard corners world
               ones(1, num_corners_x*num_corners_y);]; % Augment by ones
P_C_corners = C_T_W * P_W_corners; % Transform
P_C_corners = P_C_corners(1:3, :); % Remove augmentation


% Project checkerboard corners camera reference->image plane
projected_corners = projectPoints(P_C_corners, K, D);


% Show result
figure()
imshow(img);
hold on;
plot(projected_corners(1, :), projected_corners(2, :), 'r.');
hold off;

