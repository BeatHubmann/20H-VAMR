function cube_points = generateCube(pos_x, pos_y, side_length, C_T_W, K)
% Generates a set of points representing the corners of a cube anchored at
% the given position in the image pane
% IN:   x-coordinate of anchor point in world reference
% IN:   y-coordinate of anchor point in world reference
% IN:   Side length of cube in m
% IN:   Transformation matrix world->camera reference
% IN:   Camera calibration matrix
% OUT:  Array containing cube corner points

[X, Y, Z] = meshgrid(0:1, 0:1, -1:0); % Meshgrid for cube in world coordinates
P_W = [pos_x + X(:)*side_length, pos_y + Y(:)*side_length, 0 + Z(:)*side_length, ones(8, 1)]'; % Scale and translate cube to desired position, augment by ones
P_C = C_T_W * P_W; % Transform cube to camera reference
P_C = P_C(1:3, :); % Remove augmentation
cube_points = projectPoints(P_C, K); % Project to image pane
end
