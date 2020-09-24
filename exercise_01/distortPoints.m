function distorted_points = distortPoints(points, D)
% Distort 2-D point vectors on image plane by lens distortion D
% IN:   N times 2-D point vectors to distort points [N x 2]
% IN:   Distortion coefficient vector D [2 x 1]
% OUT:  N times 2-D point vectors distorted by D [N x 2]

k_1 = D(1); % Extract distortion coefficient 1
k_2 = D(2); % Extract distortion coefficient 2

r_sq = points(1, :).^2 + points(2, :).^2; % Calculate component-wise radial component
distort_fact = (1 + k_1*r_sq + k_2*r_sq.^2); % Caculate component-wise distortion factor
distorted_points(1, :) = distort_fact .* points(1, :); % Apply distortion factor pointwise
distorted_points(2, :) = distort_fact .* points(2, :); % Apply distortion factor pointwise