% @input: image is the image matrix with zeros and ones
%         mindist is a matrix in which for every black pixel is recorded the mindistance from a bezier curve
% @output: res is a boolean value (true or false) saying if for us the black cells are covered enought

% NOTE: It would be better to have a more well-behaved criterium for it
% We are interested to see if the black pixels not really covered by a curve are "sparse"
% So we search for black uncovered blocks and we count the number of black uncovered pixel in a 5x5 neighbourhood
% If there are at most other two then the test is passed
function [res] = AreBlacksCovered (image, mindist)
	printf("\nEntering AreBlacksCovered..."); fflush(stdout);
	% eps is the tolerance of the math
	% NOTE: WARNING: ACHTUNG: It should be set globally
	eps = 0.1;
	
	for i = 1:size(image, 1)
		for j = 1:size(image, 2)
			if image(i, j) == 0 && mindist(i, j) > 1.1 * eps
				% If the pixel is black and its distance from a curve is more than the precision
				% We extract the matrix of pixels near it and we compute if ...
				lower = max([i-2, j-2], [0, 0]);
				upper = min([i+2, j+2], size(image));
				
				subimage = image(lower(1, 1):upper(1, 1), lower(1, 2):upper(1, 2));
				subdistance = mindist(lower(1, 1):upper(1, 1), lower(1, 2):upper(1, 2));
				if sum(sum(subimage == 0 & subdistance > 1.1 * eps)) > 3
					% If the number of wrong pixels is too high then we return false
					printf("\nConditions on black pixels not met..."); fflush(stdout);
					res = 0;
					return;
				endif
			endif
		endfor
	endfor
	% Else if the function didn't return before, we return true
	res = 1;
endfunction
