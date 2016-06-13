% @input: curve is an array with parameter of a Fat Bèzier curve
%         point is an array with point coordinates
%         eps is the desidered precision: it is assured that the distance returned is
%             at most eps far from the real distance
% @output: d is the square of the distance between point and curve
%          p is an array with minimal point coordinates

function [d, p] = DistanceFromPoint (curve, point, eps)
	% That's the degree
	n = ((size(curve, 2) - 1) ./ 2) - 1;

	% We first check if the curve is flat enought
	curveness = 0;
	for i = 0:n
		% For each coefficient of the curve we compute its distance from the "right" coefficient (as if the curve was a line)
		ra = (curve(1, 2) * i + curve(1, n+2) * (n - i)) / n;
		rb = (curve(1, n+3) * i + curve(1, 2*n+3) * (n - i)) / n;
		curveness += (curve(1, i+2) - ra)^2 + (curve(1, n+i+3) - rb)^2;
	endfor
	if curveness <= eps^2 then
		% The curve is flat. We can stop the recursion and return the response for a line
		up = (p(1, 1) - curve(1, 2)) * (curve(1, 2+n) - curve(1, 2)) + (p(1, 2) - curve(1, 3+n)) * (curve(1, 2*n+3) - curve(1, 3+n));
		down = (curve(1, 2+n) - curve(1, 2))^2 + (curve(1, 2*n+3) - curve(1, 3+n))^2;
		t = up ./ down;
		if t <= 0 then
			t = 0;
		elsif t >= 1 then
			t = 1;
		endif
		% TODO: (P - l(t))*(P - l(t));
		dist = 
		[d, p] = [dist, [t*curve(1, 2+n)+(1-t)*curve(1,2), t*curve(1, 2*n+3)+(1-t)*curve(1,3+n)]];
	else
		% The curve is not flat, so we compute the two subcurves with de Casteljau algorithm and recurse
		alpha = beta = [];
		alpha(1, :) = curve(1, 2:(2+n));
		beta(1, :) = curve(1, (3+n):(2*n+3));
		for j = 1:n
			for i = 0:(n-j)
				alpha(j+1, i+1) = (alpha(j, i+1) + alpha(j, i+2))./2;
				beta(j+1, i+1) = (beta(j, i+1) + beta(j, i+2))./2;
			endfor
		endfor
		% So now the two curves are (control points)
		c1 = c2 = [];
		c1(1, 1) = c2(1, 1) = curve(1, 1);
		for i = 0:n
			c1(1, i+2) = alpha(i+1, 1);
			c1(1, n+3+i) = beta(i+1, 1);
			c2(1, i+2) = alpha(n-i+1, i+1);
			c2(1, n+3+i) = beta(n-i+1, i+1);
		endfor
		[d1, p1] = DistanceFromPoint(c1, point, eps);
		[d2, p2] = DistanceFromPoint(c2, point, eps);
		
		% And now we return the nearest point
		if d1 < d2 then
			[d, p] = [d1, p1];
		else
			[d, p] = [d2, p2];
		endif
	endif
endfunction
