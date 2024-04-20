function velocity_delta = rocket_velocity(t)
	if t <= 0
		error('Error: time must be greater than 0.');
	end
	% velocity_delta - różnica pomiędzy prędkością rakiety w czasie t oraz zadaną prędkością M
	% t - czas od rozpoczęcia lotu rakiety dla którego ma być wyznaczona prędkość rakiety
	M = 750; % [m/s]
	g = 1.622;
	m0 = 150000;
	u = 2000;
	q = 2700;
	
	v = u * log(m0 / (m0 - q * t)) - g * t;
	velocity_delta = v - M;
end
	