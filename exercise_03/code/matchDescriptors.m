function matches = matchDescriptors(...
    query_descriptors, database_descriptors, lambda)
% Uses the Sum of Squared Differences (SSD) to return a row vector
% indicating which unique database descriptor best matches a given query
% descriptor with a tunable matching hyperparameter lambda.
% IN:   Array of Q query descriptor column vectors of length M:
%       query_descriptors [M x Q]
% IN:   Array of D query descriptor column vectors of length M:
%       database_descriptors [M x D]
% IN:   Scalar matching cutoff hyperparameter: lambda
% OUT:  1-D matrix whose i-th coefficient is either the index of the
%       database descriptor which matches the query descriptor or
%       zero if there is no database descriptor with SSD < lambda * min(SSD) 
%       for the i-th query descriptor. No two non-zero elements of matches 
%       are equal.

% use pdist2() from the Statistics and Machine Learning Toolbox to calculate
% the SSD between the query_descriptors and database_descriptors
% remark: pdist2 works on rows of its argument matrices => need transpose
[D, I] = pdist2(database_descriptors', query_descriptors', ...
               'euclidean', 'Smallest', 1);

% remove zero distances
non_zero_D = D(D~=0);

% find minimum distance
min_non_zero_D = min(non_zero_D, [], 'all');

% only keep matches above matching treshold
I(D >= lambda * min_non_zero_D) = false;

% make matches unique and fill into otherwise zeroed result array
[~, ia, ~] = unique(I, 'stable');
matches = zeros(size(I));
matches(ia) = I(ia);
end
