function [V, original_Runge, original_sine, interpolated_Runge, interpolated_sine] = zadanie1()
% Rozmiar tablic komórkowych (cell arrays) V, interpolated_Runge, interpolated_sine: [1,4].
% V{i} zawiera macierz Vandermonde wyznaczoną dla liczby węzłów interpolacji równej N(i)
% original_Runge - wektor wierszowy zawierający wartości funkcji Runge dla wektora x_fine=linspace(-1, 1, 1000)
% original_sine - wektor wierszowy zawierający wartości funkcji sinus dla wektora x_fine
% interpolated_Runge{i} stanowi wierszowy wektor wartości funkcji interpolującej 
%       wyznaczonej dla funkcji Runge (wielomian stopnia N(i)-1) w punktach x_fine
% interpolated_sine{i} stanowi wierszowy wektor wartości funkcji interpolującej
%       wyznaczonej dla funkcji sinus (wielomian stopnia N(i)-1) w punktach x_fine
	N = 4:4:16;
	x_fine = linspace(-1, 1, 1000);


	original_Runge = 1 ./ (1 + 25 * x_fine.^2);
	V = cell(1, length(N));
	interpolated_Runge = cell(1, length(N));

	f = figure;
	subplot(2,1,1);
	plot(x_fine, original_Runge);
	hold on;
	for i = 1:length(N)
		V{i} = vandermonde_matrix(N(i));% macierz Vandermonde
		% węzły interpolacji
		x_coarse = linspace(-1,1,N(i));
		% wartości funkcji interpolowanej w węzłach interpolacji
		y_coarse = 1 ./ (1 + 25 * x_coarse.^2);
		% współczynniki wielomianu interpolującego
		c_runge = V{i} \ y_coarse';

		interpolated_Runge{i} = polyval(flipud(c_runge), x_fine); % interpolacja
		plot(x_fine, interpolated_Runge{i}, '--');
	end
	title('Interpolacja funkcji Rungego');
	xlabel('x');
	ylabel('f(x)');
	legend('Oryginalna funkcja', 'N = 4', 'N = 8', 'N = 12', 'N = 16');
	hold off


	original_sine = sin(2 * pi * x_fine);
	interpolated_sine = cell(1, length(N));

	subplot(2,1,2);
	plot(x_fine, original_sine);
	hold on;
	for i = 1:length(N)
		% węzły interpolacji
		x_coarse = linspace(-1,1,N(i));
		% wartości funkcji interpolowanej w węzłach interpolacji
		y_coarse = sin(2 * pi * x_coarse);
		% współczynniki wielomianu interpolującego
		c_sine = V{i} \ y_coarse';

		interpolated_sine{i} = polyval(flipud(c_sine), x_fine);
		plot(x_fine, interpolated_sine{i}, '--');
	end
	title('Interpolacja funkcji sinus');
	xlabel('x');
	ylabel('f(x)');
	legend('Oryginalna funkcja', 'N = 4', 'N = 8', 'N = 12', 'N = 16');
	hold off
	exportgraphics(f, 'zadanie1.png', 'Resolution', 300);
end
	
function V = vandermonde_matrix(N)
	% Generuje macierz Vandermonde dla N równomiernie rozmieszczonych w przedziale [-1, 1] węzłów interpolacji
	x_coarse = linspace(-1,1,N);
	V = zeros(N,N);
	for i = 1:N
		for j = 1:N
			V(i,j) = x_coarse(i)^(j-1);
		end
	end
end