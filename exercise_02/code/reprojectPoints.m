function [p_reprojected] = reprojectPoints(P, M, K)
% Reprojects given 3-D points using estimated projection matrix M and camer
% matrix K
% IN:   3-D point coordinate matrix P [n x 3]
% IN:   Estimated projection matrix M [3 x 4]
% IN:   Camera matrix K [3 x 3]
% OUT:  2-D projected point coordinate matrix [n x 2]

P = [P';
     ones(1, size(P, 1))]; % Transform P to homogenous coordinate matrix [4 x n]
p_reprojected = (K * M * P)'; % Apply M, P, then transpose to [n x 3]
p_reprojected(:, 1) = p_reprojected(:, 1) ./ p_reprojected(:, 3); % Normalize x
p_reprojected(:, 2) = p_reprojected(:, 2) ./ p_reprojected(:, 3); % Normalize y

p_reprojected = p_reprojected(:, 1:2); % Make 2-D

