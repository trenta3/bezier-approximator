% @input: image is the image matrix
%         mindist is the internal variable storing the minimum distances of points for the curve set of previous fit
%         indbez is the internal variable storing the index of the bezier curve attaining the minimum distance from point
%         curves is the current set of curves used to cover the image
%         newcurve is the newly added curve
% @ouput: fitvalue is a number that is the calculated fit value
%         newmindist is the new mindistance matrix associated with this new curve set
%         newindbez is the new indbez matrix

% TODO: Better the white coverage part. I don't like it very much now
% IDEA: We could weight the contribute of every single white pixel with his distance from black pixels
% We iterate over black pixels and we compute the distance from our newest curve. We then compare it with
% the previous minimum to calculate the actual distance of the point from the curve set. We then sum up
% all this distances (they are all positive) and we also sum the white coverage coefficient
function [fitvalue, newmindist, newindbez] = CalculateFit (image, mindist, indbez, curves, newcurve)
	% eps is the precision at which all math is done
	eps = 0.05;
	
	fitvalue = 0;
	newmindist = mindist; newindbez = indbez;
	for i = 1:size(image, 1)
		for j = 1:size(image, 2)
			% For each pixel we calculate the distance from the curve set
			distfromnewcurve = DistanceFromPoint (newcurve, [i, j], eps);
			if distfromnewcurve < mindist(i, j)
				% If the distance from the new curve is smaller than the other then we
				% record this information in the new distance matrix and curve bezier index
				newmindist(i, j) = distfromnewcurve;
				newindbez(i, j) = size(curves, 1) + 1;
			endif
			
			if image(i, j) == 0
				% We then add the min distance to the fitvalue if the pixel is black
				fitvalue = fitvalue + newmindist(i, j);
			else
				% And for all white pixel that we cover we add one point 
				if newmindist(i, j) <= 1.1 * eps
					fitvalue = fitvalue + 1.0;
				endif
			endif
		endfor
	endfor
endfunction
