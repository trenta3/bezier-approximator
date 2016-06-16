% Function to display an image with pixels

function DisplayImage (image)
hold on;
	x = y = [];
	for i = 1:size(image, 1)
		for j = 1:size(image, 2)
			if image(i, j) == 0
				x = [x; i];
				y = [y; j];
			endif
		endfor
	endfor
	plot(x, y, '.r');
hold off;
endfunction
