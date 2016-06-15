% @input: image is the image matrix, with black and white pixels
%         mindist is the matrix that carries the minimum distances from black points
%                 to the nearest bèzier curve in the set
% @ouput: curve is a row matrix with the coordinates of the newly generated curve

% We proceed finding a place with some black pixels in an image (at least four in a nine square)
% and placing there the initial point of the curve. Other points are spread in a little area randomly
% according to the maxspread variables for width and spatial dispersion
% If there are none places that we like we signal this situation, and we choose the first point at random
% TODO: Now the first point is chosen at random.
function [curve] = NewRandomCurve (image, mindist)
	% lspread is the maximal dispersion of width in the curve
	lspread = 1.5;
	% aspread is the maximal dispersion of spatial points in the curve
	aspread = 8.0;
	
	P0 = rand(1, 2) .* size(image);
	P1 = P0 + rand(1, 2) * aspread;
	P2 = P0 + rand(1, 2) * aspread;
	P3 = P0 + rand(1, 2) * aspread;
	L = rand(1) * lspread;
	
	curve = [L, P0(1, 1), P1(1, 1), P2(1, 1), P3(1, 1), P0(1, 2), P1(1, 2), P2(1, 2), P3(1, 2)];
endfunction
