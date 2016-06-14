% We test the DistanceFromPoint.m function with various curves and points

eps = 0.1;

% We first test the distance on some lines
lines = [
	0, -1.5, 1.5, 0, 0;
	0, 1, 2, 8, 3;
	0, 2, -5, -7, 10;
	0, 21, 17, 0, 17;
	0, 18, -2, 18, -12;
];

curves = [];
% We convert lines to 3-deg bezier curves
for i = 1:size(lines,1)
	curves(i, :) = [lines(i, 1), (lines(i, 2)*[3 2 1 0] + lines(i, 3)*[0 1 2 3])./3, (lines(i, 4)*[3 2 1 0] + lines(i, 5)*[0 1 2 3])./3];
endfor

points = [
	0, 1;
	8, 3;
	1, 0;
	-2, 12;
	9, 1;
];

for i = 1:size(lines,1)
	% We know how to calculate the distance from the line between point P and Q
	% Let L(t) = tP + (1-t)Q. Then the t at which we have the minimum distance is
	% t = (R-Q)*(P-Q) / (P-Q)*(P-Q). We can then proceed to calculate the distance
	P = [lines(i, 2), lines(i, 4)];
	Q = [lines(i, 3), lines(i, 5)];
	R = points(i, :);
	t = sum((R - Q) .* (P - Q)) / sum((P - Q) .* (P - Q));
	if t > 1
		t = 1;
	elseif t < 0
		t = 0;
	endif
	% And now we calculate the minimal point and the distance
	l = t * P + (1 - t) * Q;
	d = sum((l - R).^2);
	[bd, bp] = DistanceFromPoint(curves(i, :), points(i, :), eps);
	% We now check if the distance is accurate enought
	printf("Real distance: %g, Real point: %g, %g | Calculated distance: %g, Calculated point: %g, %g\n", d, l(1, 1), l(1, 2), bd, bp(1, 1), bp(1, 2));
	if abs(bd - d) > eps
		printf("ERROR TEST NOT PASSED: %g > %g\n", abs(bd - d), eps);
	endif
endfor
