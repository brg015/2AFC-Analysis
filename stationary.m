function [dist] = stationary(p)
% For a valid transition probability matrix of a Markov chain, p,
% stationary(p) will output the stationary distribution of p. As of
% 2012/09/11, this function has only been tested for irreducible Markov
% chains.
% Created by Zachary Abzug on 2012/09/11

if ndims(p) ~= 2;
    error('p is not a 2D matrix');
    return;
end

if size(p, 1) ~= size(p, 2);
    error('p is not square');
    return;
end

if (sum(p, 2) ~= ones(size(p, 2), 1));
    error('Rows of p do not add up to 1');
    return;
end

tf = isequal(p<0, zeros(size(p)));

if tf ~= 1;
    error('Negative number found in p');
    return;
end

A = p - eye(size(p));
A(:, end) = 1;
piplus = inv(A);
dist = piplus(end, :);

end