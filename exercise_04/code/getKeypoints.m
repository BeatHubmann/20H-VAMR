function kpt_candidates = getKeypoints(DoGs, contrast_threshold)
% Finds keypoint candidates in DoGs.
% IN:   Cell containing stacks of Difference of Gaussians:
%       DoGs [1 x num_octaves]
% IN:   Scalar contrast treshold:   contrast_treshold
% OUT:  Cell containing stacks of keypoint candidates:
%       DoGs [1 x num_octaves]

    % extract number of octaves
    num_octaves = size(DoGs, 2);

    % set up top level octave cell array
    kpt_candidates = cell(1, num_octaves);
    
    for i = 1:num_octaves
        % get the DoGs for the current octave
        DoG_stack = DoGs{i};
        % use imdilate() from the Image Processing Toolbox to find maxima
        DoG_maxima = imdilate(DoG_stack, ones(3, 3, 3));
        % build stack of keypoints based on DoG_max status and threshold
        kpt_stack = (DoG_stack == DoG_maxima)...
                  & (DoG_stack > contrast_threshold);
        % flatten bottom and top cover of kpt stack as we don't want those
        kpt_stack(:, :, 1) = false;
        kpt_stack(:, :, end) = false;
        kpt_candidates{i} = kpt_stack;
    end
end
