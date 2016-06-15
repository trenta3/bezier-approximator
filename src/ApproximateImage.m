% @input: imgname is the name (a string) of the image file to approximate
%         n is the degree of the Bèzier curves to be used in approximating
% @output: bezcurves is the matrix in which, in every row there is a bèzier curve approximating
%                    the given image at the required precision

function [bezcurves] = ApproximateImage (imgname, n)
	% We first load the given image and store it in a matrix
	% ACHTUNG: Currently the program only works with black and white images, not with grey-scales
	image = imread(imgname);
	
	% We create the set of bèzier curves
	curves = [];
	% Following is a pseudo-code description of the program
	% WHILE few blacks aren't covered:
	%       IF the solution doesn't better in 10 steps:
	%                ADD random chosen curve
	%       PERFORM step
	% ADJUST found curves (fine-tuning) for bettering the whole picture
	
	% Step is the following function:
	% ON current curve DO
	%       FOR i = 1:50
	%               g' = g + rand * __
	%               CALCULATE fit on set of curves (g <-- g')
	%       IF exists j such that Fit(g_j') < Fit(g)
	%               SUBSTITUTE g_j' FOR g
	
	% The fit function is computed in the following form
	% We have internal variables mindist, indbez for performance improving
	% FOR p \in image, p black DO
	%       distfromg = Dist(p, g')
	%       IF indbez(p) = g'
	%               
	%       fit += newdist
endfunction
