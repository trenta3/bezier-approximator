% @input: image is the image matrix, with black and white pixels
%         mindist is the matrix that carries the minimum distances from black points
%                 to the nearest bèzier curve in the set
% @ouput: curve is a row matrix with the coordinates of the newly generated curve

% We proceed finding a place with some black pixels in an image (at least four in a nine square)
% and placing there the initial point of the curve. Other points are spread in a little area randomly
% according to the maxspread variables for width and spatial dispersion
% If there are none places that we like we signal this situation, and we choose the first point at random
% TODO: Think a little smarter for finding black pixels
function [curve] = NewRandomCurve (image, mindist)
	% lspread is the maximal dispersion of width in the curve
	lspread = 1.5;
	% aspread is the maximal dispersion of spatial points in the curve
	aspread = 12.0;
	
	eps = 0.05;
	
	% We search for a region with black pixels (at least 5 in a 5x5 point space)
	for i = 1:size(image, 1)
		for j = 1:size(image, 2)
			if image(i, j) == 0 && mindist(i, j) > 1.1 * eps
				% If the pixel is black and its distance from a curve is more than the precision
				% We extract the matrix of pixels near it and we compute if ...
				lower = max([i-2, j-2], [0, 0]);
				upper = min([i+2, j+2], size(image));
				
				subimage = image(lower(1, 1):upper(1, 1), lower(1, 2):upper(1, 2));
				subdistance = mindist(lower(1, 1):upper(1, 1), lower(1, 2):upper(1, 2));
				if sum(sum(subimage == 0 & subdistance > 1.1 * eps)) > 5
					P0 = rand(1, 2) .* [5 5] + lower;
					P1 = P0 + (rand(1, 2) - 0.5) * aspread;
					P2 = P0 + (rand(1, 2) - 0.5) * aspread;
					P3 = P0 + (rand(1, 2) - 0.5) * aspread;
					L = rand(1) * lspread;
					
					curve = [L, P0(1, 1), P1(1, 1), P2(1, 1), P3(1, 1), P0(1, 2), P1(1, 2), P2(1, 2), P3(1, 2)];
					return;
				endif
			endif
		endfor
	endfor
	
	printf("\nNot enough black pixels for finding a curve...");
	P0 = rand(1, 2) .* size(image);
	P1 = P0 + (rand(1, 2) - 0.5) * aspread;
	P2 = P0 + (rand(1, 2) - 0.5) * aspread;
	P3 = P0 + (rand(1, 2) - 0.5) * aspread;
	L = rand(1) * lspread;
	
	curve = [L, P0(1, 1), P1(1, 1), P2(1, 1), P3(1, 1), P0(1, 2), P1(1, 2), P2(1, 2), P3(1, 2)];
endfunction
