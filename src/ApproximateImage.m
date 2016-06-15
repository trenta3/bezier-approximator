% @input: imgname is the name (a string) of the image file to approximate
%         n is the degree of the Bèzier curves to be used in approximating
% @output: bezcurves is the matrix in which, in every row there is a bèzier curve approximating
%                    the given image at the required precision

% TODO: the function is not yet complete
function [bezcurves] = ApproximateImage (imgname, n)
	% We first load the given image and store it in a matrix
	% ACHTUNG: Currently the program only works with black and white images, not with grey-scale ones
	image = imread(imgname);
	
	% delta is the parameter such that if the bettering is lower than delta then we add a curve
	delta = 1.0;
	% lstep is the maximum change in largeness of curve per step
	lstep = 1.5;
	% astep is the maximum change in position of control point of the curve per step
	astep = 3.0;
	% generatenumber is the number of generated curves at every step
	generatenumber = 500;
	
	% Following is a pseudo-code description of the program
	% WHILE few blacks aren't covered:
	%       IF the solution doesn't better in the step:
	%                ADD random chosen curve
	%       PERFORM STEP
	% ADJUST found curves (fine-tuning) for bettering the whole picture
	%
	% where step is the following function:
	% ON current curve DO
	%       FOR i = 1:500
	%               g' = g + rand * __
	%               CALCULATE fit on set of curves (g' <-- g)
	%       IF exists j such that Fit(g_j') < Fit(g)
	%               SUBSTITUTE g_j' FOR g

	% We create the set of bèzier curves
	curves = [];
	% The initial fit should be rather high or otherwise we can't see the betterings
	prevfit = curfit = 1e80; 
	newcurve = [];
	while ! AreBlacksCovered(image, mindist)
		if prevfit - curfit < delta
			% Save the last curve in the curves matrix
			curves = [curves; newcurve];
			% And generate a new Random Curve in the image
			newcurve = NewRandomCurve(image, mindist);
		endif
		trials = fitpoint = [];
		% Generate a lot of new little modified curves and calculate the fit for the set with each of these
		for i = 1:generatenumber
			trials(i, :) = newcurve + rand(1, 9) * [lstep, astep, astep, astep, astep, astep, astep, astep, astep];
			fitpoint(i) = CalculateFit(image, mindist, indbez, curves, trials(i, :));
		endfor
		% Search for the best fit in this set of curves
		[m, idx] = min(fitpoint);
		if m < curfit
			% If we found a better fit then substitute the curve for the new one
			newcurve = trials(idx, :);
			prevfit = curfit; curfit = fitpoint(idx);
		endif
	endwhile
	
	%% TODO: Adjustement steps for a better looking image
endfunction
