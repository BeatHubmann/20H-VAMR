function [kpt_locations, descriptors] = ...
        getFinalKeypointsDescriptors(blurred_images, kpt_candidates)
% Calculates final keypoints and their SIFT descriptors based on given 
% blurred images and their candidate keypoints.
% IN:   Cell containing stacks of blurred images:
%       blurred_images [1 x num_octaves]
% IN:   Cell containing stacks of keypoint candidates:
%       DoGs [1 x num_octaves]
% OUT:  Array containing final keypoints of the source image
% OUT:  Array containing descriptors of final keypoints of the source image
    
    % extract number of octaves
    num_octaves = size(blurred_images, 2);

    % set up Gaussian to scale norm of gradients using fspecial
    % from the Image Processing Toolbox
    gaussian = fspecial('gaussian', [16 16], 1.5*16);
    
    % iterate over octaves
    for i = 1:num_octaves
        % extract blurred images, keypoint candidates of current octave
        blurred_image_stack = blurred_images{i};
        kpt_stack = kpt_candidates{i}; 
        % extract linear indices of kpts and convert to x,y,z stack coords
        [x, y, z] = ind2sub(size(kpt_stack), find(kpt_stack));
        kpt_coordinates = horzcat(x, y, z)';
        % find layers in stack containing keypoints
        layers = unique(kpt_coordinates(3, :));
        % iterate over relevant layers
        for j = layers
            % extract current image and its size
            blurred_image = blurred_image_stack(i);
            [rows, cols] = size(blurred_image);
            % find gradient magnitude and direction of blurred_image
            % using imgradient() from the Image Processing Toolbox
            [Gmag, Gdir] = imgradient(blurred_image);
            
            
            % extract 16x16 patch around keypoints
            
            
            
            % divide 16x16 patch into 16 4x4 subpatches
            
            
            % weight subblock gradient according to scaled norm
            
            
            % calculate subblock orientation histogram
            
            
            
            % concatenate histograms into descriptor
           
            
            
        end
        
        
        
    end
    
    
    % normalize descriptors to unit norm
    
    
    
end
