function DoGs = getDoGs(blurred_images)
% Returns a collection of Difference of Gaussians between each neighbouring
% image pair in the collection of blurred images per octave.
% IN:   A cell containing stacks of blurred images:
%       blurred_images [1 x num_octaves]
% OUT:  Cell containing stacks of Difference of Gaussians:
%       DoGs [1 x num_octaves]
    
    % extract number of octaves
    num_octaves = size(blurred_images, 2);

    % set total number of DoGs per octave
    num_DoGs = size(blurred_images{1}, 3) - 1;

    % set up top level octave cell array
    DoGs = cell(1, num_octaves);
    
     % iterate over octaves
    for i = 1:num_octaves
        % set up lower level blurred image cell array per octave
        DoGs{i} = zeros([size(blurred_images{i}, 1:2) num_DoGs]);
        for j = 1:num_DoGs
           % calculate difference to next higher Gaussian-blurred image
           DoGs{i}(:, :, j) = abs(blurred_images{i}(:, :, j)...
                                 -blurred_images{i}(:, :, j+1));
        end
    end
end