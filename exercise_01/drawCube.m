function drawCube(cube_points, image)
% Draws given cube onto given image
% IN:   Array containing cube corners
% IN:   Image to draw on

figure()
imshow(image);
title('Undistorted image with cube');
hold on;

% bottom
line([cube_points(1, 1), cube_points(1, 2)], [cube_points(2, 1), cube_points(2, 2)], 'color', 'r', 'LineWidth', 2);
line([cube_points(1, 1), cube_points(1, 3)], [cube_points(2, 1), cube_points(2, 3)], 'color', 'r', 'LineWidth', 2);
line([cube_points(1, 2), cube_points(1, 4)], [cube_points(2, 2), cube_points(2, 4)], 'color', 'r', 'LineWidth', 2);
line([cube_points(1, 3), cube_points(1, 4)], [cube_points(2, 3), cube_points(2, 4)], 'color', 'r', 'LineWidth', 2);

% top
line([cube_points(1, 1+4), cube_points(1, 2+4)], [cube_points(2, 1+4), cube_points(2, 2+4)], 'color', 'r', 'LineWidth', 2);
line([cube_points(1, 1+4), cube_points(1, 3+4)], [cube_points(2, 1+4), cube_points(2, 3+4)], 'color', 'r', 'LineWidth', 2);
line([cube_points(1, 2+4), cube_points(1, 4+4)], [cube_points(2, 2+4), cube_points(2, 4+4)], 'color', 'r', 'LineWidth', 2);
line([cube_points(1, 3+4), cube_points(1, 4+4)], [cube_points(2, 3+4), cube_points(2, 4+4)], 'color', 'r', 'LineWidth', 2);
% vertical
line([cube_points(1, 1), cube_points(1, 1+4)], [cube_points(2, 1), cube_points(2, 1+4)], 'color', 'r', 'LineWidth', 2);
line([cube_points(1, 2), cube_points(1, 2+4)], [cube_points(2, 2), cube_points(2, 2+4)], 'color', 'r', 'LineWidth', 2);
line([cube_points(1, 3), cube_points(1, 3+4)], [cube_points(2, 3), cube_points(2, 3+4)], 'color', 'r', 'LineWidth', 2);
line([cube_points(1, 4), cube_points(1, 4+4)], [cube_points(2, 4), cube_points(2, 4+4)], 'color', 'r', 'LineWidth', 2);

hold off;
end