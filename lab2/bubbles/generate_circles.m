function [circles, index_number, circle_areas, rand_counts, counts_mean] = generate_circles(a, r_max, n_max)
	index_number = 193557; % numer Twojego indeksu
	L1 = mod(index_number, 10);
	rand_counts = zeros(1, n_max);
	if mod(L1,2) == 0
		circles = zeros(n_max, 3);
		for i = 1:n_max
			wouldOverlap = true;
			while wouldOverlap
				X = rand() * a;
				Y = rand() * a;
				R = rand() * r_max + 0.001;
				rand_counts(i) = rand_counts(i) + 1;
				
				if X-R < 0 || Y-R < 0 || X+R > a || Y+R > a
					continue;
				end

				wouldOverlap = false;
				if i > 1
					for j = 1:i-1
						if sqrt((X-circles(j, 1))^2 + (Y-circles(j, 2))^2) < R + circles(j, 3)
							wouldOverlap = true;
							break;
						end
					end
				end
			end
			circles(i, :) = [X, Y, R];
		end
	else
		circles = zeros(3, n_max);
		for i = 1:n_max
			wouldOverlap = true;
			while wouldOverlap
				X = rand() * a;
				Y = rand() * a;
				R = rand() * r_max + 0.001;
				rand_counts(i) = rand_counts(i) + 1;
				if X-R < 0 || Y-R < 0 || X+R > a || Y+R > a
					continue;
				end

				wouldOverlap = false;
				if i > 1
					for j = 1:i-1
						if sqrt((X-circles(2, j))^2 + (Y-circles(3, j))^2) < R + circles(1, j)
							wouldOverlap = true;
						end
					end
				end
			end
			circles(:, i) = [R, X, Y];
		end
	end
	L2 = mod(floor(index_number/10), 10);
	if mod(L1,2) == 0
		circle_areas = cumsum(pi * circles(:, 3).^2);
	else
		circle_areas = cumsum(pi * circles(1, :).^2);
	end
	if mod(L2,2) == mod(L1,2)
		circle_areas=circle_areas';
	end
	counts_mean = cumsum(rand_counts) ./ (1:n_max);
end	