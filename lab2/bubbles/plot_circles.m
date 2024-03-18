function plot_circles(a,circles,index_number)
	figure;
	hold on;
	axis equal;
	axis([0 a 0 a]);
	if mod(index_number,2)==0
		for i=1:size(circles,1)
			plot_circle(circles(i,3),circles(i,1),circles(i,2));
			%pause(0.1);
		end
	else
		for i=1:size(circles,2)
			plot_circle(circles(1,i),circles(2,i),circles(3,i));
			%pause(0.1);
		end
	end
	hold off;
end