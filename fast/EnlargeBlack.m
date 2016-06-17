
function newimage = EnlargeBlack(image)
	newimage = image;
	for i = 1:size(image, 1)
		for j = 1:size(image, 2)
			
			if image(i,j) == 0
				for h = -3:3
					for k = -3:3
						if i-h < 1 || i-h > size(image, 1) || j-k < 1 || j-k > size(image, 2)
							a = 0;
						else
							if sum(([i-h, j-k] - [i, j]).^2) <= 3
								newimage(i-h, j-k) = 0;
							endif
						endif
					endfor
				endfor
			endif
			
		endfor
	endfor
endfunction
