% We test the DistanceFromPoint.m function with various curves and points

eps = 0.1;

% We first test the distance on some lines
lines = [
	0, 1, 2, 8, 3;
	0, 2, -5, -7, 10;
	0, 21, 17, 0, 17;
	0, 18, -2, 18, -12;
];

points = [
	8, 3;
	1, 0;
	-2, 12;
	9, 1;
];

for i = 1:size(lines,1)
	% We know how to calculate the distance from the line between point P and Q
	% Let L(t) = tP + (1-t)Q. Then the t at which we have the minimum distance is
	% t = (R-Q)*(P-Q) / (P-Q)*(P-Q). We can then proceed to calculate the distance
	t = ((points(i, 1) - lines(i, 4)) * (lines(i, 2) - lines(i, 4)) + (points(i, 2) - lines(i, 5)) * (lines(i, 3) - lines(i, 5))) / ((lines(i, 2) - lines(i, 4))^2 + (lines(i, 3) - lines(i, 5))^2);
	if t > 1
		t = 1;
	elseif t < 0
		t = 0;
	endif
	% And now we calculate the minimal point and the distance
	lx = t * lines(i, 2) + (1 - t) * lines(i, 4);
	ly = t * lines(i, 3) + (1 - t) * lines(i, 5);
	d = (lx - points(i, 1))^2 + (ly - points(i, 2))^2;
	[bd, bx, by] = DistanceFromPoint(lines(i, :), points(i, :), eps);
	% We now check if the distance is accurate enought
	printf("Real distance: %g, Real point: %g, %g | Calculated distance: %g, Calculated point: %g, %g\n", d, lx, ly, bd, bx, by);
	if abs(bd - d) > eps
		printf("ERROR TEST NOT PASSED: %g > %g\n", abs(bd - d), eps);
	endif
endfor
