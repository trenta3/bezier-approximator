% Function to display a Bezier curve

function DisplayBezier (curve)
	t = linspace(0, 1, 1000);
	x = @(t) curve(1, 2)*t.^3 + 3*curve(1, 3)*t.^2.*(1-t) + 3*curve(1, 4)*t.*(1-t).^2 + curve(1, 5)*(1-t).^3;
	y = @(t) curve(1, 6)*t.^3 + 3*curve(1, 7)*t.^2.*(1-t) + 3*curve(1, 8)*t.*(1-t).^2 + curve(1, 9)*(1-t).^3;
	plot(x(t), y(t));
endfunction
