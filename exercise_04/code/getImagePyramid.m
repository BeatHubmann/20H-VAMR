function image_pyramid = getImagePyramid(image, num_octaves)
% Returns a pyramid of stacked images of height num_octaves, where the
% base level consists of the argument image and each higher level image is
% resized to half the size of the next lower level's image.
% IN:   Array describing the base level image: image [w x h]
% IN:   Scalar describing the total pyramid height: num_octaves
% OUT:  Cell containing the pyramid of images:
%       image_pyramid [1 x num_octaves]

% Set up result data structure
image_pyramid = cell(1, num_octaves);

% Stack the pyramid, resizing by half at each level
for i = 1:num_octaves
    image_pyramid{i} = imresize(image, 0.5^(i-1));
end
end