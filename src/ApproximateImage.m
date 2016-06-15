% @input: imgname is the name (a string) of the image file to approximate
%         n is the degree of the Bèzier curves to be used in approximating
% @output: bezcurves is the matrix in which, in every row there is a bèzier curve approximating
%                    the given image at the required precision

function [bezcurves] = ApproximateImage (imgname, n)
	% We first load the given image and store it in a matrix
	% ACHTUNG: Currently the program only works with black and white images, not with grey-scales
	image = imread(imgname);
	
	% delta is the parameter such that if the bettering is lower than delta then we add a curve
	delta = 1.0;
	
	% We create the set of bèzier curves
	curves = [];
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

	% The initial fit should be rather high or otherwise we can't see the betterings
	prevfit = curfit = 1e80; 
	newcurve = [];
	while ! AreBlacksCovered(image, curves)
		if prevfit - curfit < delta
			% Save the last curve in the curves matrix
			curves = [curves; newcurve];
			% And generate a new Random Curve in the image
			newcurve = NewRandomCurve(image);
		endif
		trials = fitpoint = [];
		% Generate a lot of new little modified curves and calculate the fit with each of these
		for i = 1:500
			trials(i, :) = newcurve + rand(1, 9) * [lstep, astep, astep, astep, astep, astep, astep, astep, astep];
			fitpoint(i) = CalculateFit(image, curves);
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
