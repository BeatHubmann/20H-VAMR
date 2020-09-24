function projected_points = projectPoints(points, K, D)
% Projects 3-D points from camera reference to 2-D image pane points
% IN:   N times 3-D point vectors to project [3 x N]
% IN:   Intrinsic camera parameter matrix K [3 x 3]
% IN:   Optional: Distortion coefficients D [2 x 1]
% OUT:  N times 2-D point vectors in image plane [2 x N]


% Normalize point coordinates
points(1, :) = points(1, :) ./ points(3, :); % Normalize x coordinates
points(2, :) = points(2, :) ./ points(3, :); % Normalize y coordinates


% Apply distortion coefficients if given as argument
if nargin == 3 % If third argument distortion coefficients D is given
    points = distortPoints(points, D); % Apply distortion
end


% Convert to discretized pixel coordinates
N = size(points, 2); % Number of points N given by second axis of points
points = [points; % Normalized (and distorted if D given) 3-D points in camera reference
          ones(1, N)]; % Augment by ones
projected_points = K * points; % Apply projection to image pane
projected_points = projected_points(1:2, :); % Remove augmentation
end