function M = estimatePoseDLT(p, P, K)
% Uses the DLT algorithm to determine the camera pose from given projected
% 2-D points
% IN:   2-D projected point coordinate matrix p [n x 2]
% IN:   3-D point coordinate matrix P [n x 3]
% IN:   Camera matrix K [3 x 3]
% OUT:  Estimated projection matrix M [3 x 4]

% Establish number of points n we're dealing with:
num_points = size(p, 1); 

% Calibrate (i.e. normalize) 2-D point coordinates:
p_calibrated = K \ [p';
                    ones(1, size(p, 1))]; % [x,y,1]' = K^-1 * [u,v,1]'
                
% Build the Q matrix:
Q = zeros(2*num_points, 12); % Empty matrix [2*n x 12]
for i=1:num_points
    A = [eye(2), -p_calibrated(1:2,i)];
    Q(2*i-1:2*i, :) = kron(A, [P(i,:), 1]);
end

% Find least-squares solution of Q*M = 0 using SVD:
[U, S, V] = svd(Q); % Perform singular value decomposition
M = V(:, end); % Pick eigenvector of smallest eigenvalue of Q'Q

% Reshape eigenvector M into [3 x 4] matrix:
M = reshape(M, 4, 3)'; % col-major: first reshape into [4 x 3], then transpose

% Ensure the z-component of recovered translation is positive:
if M(3, 4) < 0 % if t_z = M_34 is negative
    M = -M; % reflect M
end



% Extract rotation matrix:
R = M(:, 1:3);

% Find orthogonal true rotation matrix R_tilde in SO(3) closest to R
% ref. (constrained) Procrustes problem
[U, S, V] = svd(R);
R_tilde = U * V';

% Recover scale factor alpha:
alpha = norm(R_tilde) / norm(R);

% Assemble final projection matrix:
M = [R_tilde, alpha*M(:, 4)]; % M = [R_tilde | alpha*t]

% Assert correctness of M:
R = M(:,1:3);
assert(abs(1-det(R)) < 1e4*eps(min(1, abs(det(R))))); % Check det(R) = 1
RR_tol = ismembertol(eye(3), R'*R, 1e-4);
assert(all(RR_tol(:))); % Check R is orthogonal: R'R = unit matrix



