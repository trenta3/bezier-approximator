% @input: curve is an array with parameter of a Fat Bèzier curve
%         point is an array with point coordinates
%         eps is the desidered precision: it is assured that the distance returned is
%             at most eps far from the real distance
% @output: d is the square of the distance between point and curve
%          p is an array with minimal point coordinates

% We write it for third degree bezier curves
% l a_0 a_1 a_2 a_3 b_0 b_1 b_2 b_3
% 1 2   3   4   5   6   7   8   9
function [dist, minp] = DistanceFromPoint (curve, point, eps)
	% We first check if the curve is flat enought
	if sum((curve(1, 2:5) - (curve(1, 2)*[3 2 1 0] + curve(1, 5)*[0 1 2 3]) ./ 3).^2 + (curve(1, 6:9) - (curve(1, 6)*[3 2 1 0] + curve(1, 9)*[0 1 2 3]) ./3).^2 <= eps^2 * [1 1 1 1]) == 4
		% The curve is flat so we calculate the minimum
		Q = [curve(1, 5), curve(1, 9)];
		P = [curve(1, 2), curve(1, 6)];
		up = sum((point - Q) .* (P - Q));
		down = sum((P - Q).^2);
		t = up / down;
		if t <= 0
			t = 0;
		elseif t >= 1
			t = 1;
		endif
		
		% We calculate the points on the line
		minp = t*P + (1-t)*Q;
		dist = sum((minp - point).^2);
	else
		% The curve is not flat, we subdivide it recursively using de Casteljau algorithm
		mx = (curve(1, 3) + curve(1, 4))/2;
		my = (curve(1, 7) + curve(1, 8))/2;
		
		l1x = (curve(1, 2) + curve(1, 3))/2;
		l1y = (curve(1, 6) + curve(1, 7))/2;
		
		r2x = (curve(1, 4) + curve(1, 5))/2;
		r2y = (curve(1, 8) + curve(1, 9))/2;
		
		l2x = (l1x + mx)/2;
		l2y = (l1y + my)/2;
		
		r1x = (mx + r2x)/2;
		r1y = (my + r2y)/2;
		
		l3x = (l2x + r1x)/2;
		l3y = (l2y + r1y)/2;
		
		lcurve = [curve(1, 1), curve(1, 2), l1x, l2x, l3x, curve(1, 6), l1y, l2y, l3y];
		
		rcurve = [curve(1, 1), l3x, r1x, r2x, curve(1, 5), l3y, r1y, r2y, curve(1, 9)];
		
		printf("\nThe curve is not flat, we are dividing in %g, %g\n", l3x, l3y);
		disp(lcurve); disp(rcurve);
		sleep(10);
		
		% We then recurse over the two subcurves
		[ldist, lminp] = DistanceFromPoint (lcurve, point, eps);
		[rdist, rminp] = DistanceFromPoint (rcurve, point, eps);
		
		% And after recursing over the two subcurves we return the minimum of the two
		if ldist < rdist
			dist = ldist; minp = lminp;
		else
			dist = rdist; minp = rminp;
		endif
	endif
endfunction
