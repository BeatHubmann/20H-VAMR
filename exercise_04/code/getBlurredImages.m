function blurred_images = getBlurredImages(image_pyramid, num_scales, sigma_0)
% Returns a collection of increasingly blurred images consisting of a stack
% of num_scales+3 images per octave. The images per octave are blurred with
% a Gaussian with sigma=2^(s/num_scales)*sigma_0 where
% s = [-1, ..., num_scales+1].
% IN:   Cell containing pyramid of images downsampled by a factor of
%       2^o, o = [0, ..., num_octaves-1]: image_pyramid [1 x num_octaves]
% IN:   Scalar indicating number of scales per octave: num_scales
% IN:   Scalar indicating base level sigma for blurring: sigma_0
% OUT:  Cell containing cells of blurred images:
%       blurred_images [1 x num_octaves]

% extract number of octaves
num_octaves = size(image_pyramid, 2);

% set total number of blurred images per octave
num_images = num_scales + 3;

% set up top level octave cell array
blurred_images = cell(1, num_octaves);

% iterate over octaves
for i = 1:num_octaves
    % set up lower level blurred image cell array per octave
    blurred_images{i} = cell(1, num_images);
    for j = 1:num_images
       % Gaussian scaling factor s = [-1, ..., num_scales+1]
       s = j - 2;
       % apply 2-D Gaussian filter with sigma=2^(s/num_scales)*sigma_0
       blurred_images{i}{j} = imgaussfilt(image_pyramid{i}, ...
                                          2.^(s/num_scales)*sigma_0);
    end
end
end
