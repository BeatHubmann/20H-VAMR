function C_T_W = poseVectorToTransformationMatrix(pose_vector)
% Assembles transformation matrix world->camera reference from pose vector
% IN:   Pose vector (omega_x, omega_y, omega_z, t_x, t_y, t_z) [6 x 1]
% OUT:  Transformation matrix C_T_W [4 x 4]

omega = pose_vector(1:3); % Rotational part: axis-angle representation
t = pose_vector(4:6); % Translational part

% Assembling rotation matrix using Rodrigues' rotation formula
theta = norm(omega); % Magnitude of rotation about rotation axis k
k = omega/theta; % Rotation unit vector
k_x = k(1); % Unpacking k into components
k_y = k(2);
k_z = k(3);
K_cross = [   0, -k_z,  k_y;
            k_z,    0, -k_x;
           -k_y,  k_x,    0]; % Cross-product matrix for vector k
R = eye(3) + sin(theta)*K_cross + (1-cos(theta))*K_cross^2;

% Assembling transformation matrix using rotation and translation parts
C_T_W = eye(4); % Start with identity matrix
C_T_W(1:3, 1:3) = R; % Rotation section
C_T_W(1:3, 4) = t; % Translation section
end
