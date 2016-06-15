% @input: image is the image matrix
%         mindist is the internal variable storing the minimum distances of points for the curve set of previous fit
%         indbez is the internal variable storing the index of the bezier curve attaining the minimum distance from point
%         curves is the current set of curves used to cover the image
%         newcurve is the newly added curve
% @ouput: fitvalue is a number that is the calculated fit value
%         newmindist is the new mindistance matrix associated with this new curve set
%         newindbez is the new indbez matrix

% TODO: Add the WHITE COVERAGE part of the function
% We iterate over black pixels and we compute the distance from our newest curve. We then compare it with
% the previous minimum to calculate the actual distance of the point from the curve set. We then sum up
% all this distances (they are all positive) and we also sum the white coverage coefficient (to be calculated)
function [fitvalue, newmindist, newindbez] = CalculateFit (image, mindist, indbez, curves, newcurve)
	% eps is the precision at which all math is done
	eps = 0.05;
	
	fitvalue = 0;
	newmindist = mindist; newindbez = indbez;
	for i = 1:size(image, 1)
		for j = 1:size(image, 2)
			% For every pixel in the image, we check its color
			if image(i, j) == 0
				% If the pixel is black we calculate the distance from the curve set
				distfromnewcurve = DistanceFromPoint (newcurve, [i, j], eps);
				if distfromnewcurve < mindist(i, j)
					% If the distance from the new curve is smaller than the other then we
					% record this information in the new distance matrix and curve bezier index
					newmindist = distfromnewcurve;
					newindbez = size(curves, 1) + 1;
				endif
				% We then add the min distance to the fitvalue
				fitvalue = fitvalue + min(distfromnewcurve, mindist(i, j));
			else
				% TODO: And for all white pixel we calculate the coverage
			endif
		endfor
	endfor
endfunction
