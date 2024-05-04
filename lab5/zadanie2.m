function [nodes_Chebyshev, V, V2, original_Runge, interpolated_Runge, interpolated_Runge_Chebyshev] = zadanie2()
% nodes_Chebyshev - wektor wierszowy zawierający N=16 węzłów Czebyszewa drugiego rodzaju
% V - macierz Vandermonde obliczona dla 16 węzłów interpolacji rozmieszczonych równomiernie w przedziale [-1,1]
% V2 - macierz Vandermonde obliczona dla węzłów interpolacji zdefiniowanych w wektorze nodes_Chebyshev
% original_Runge - wektor wierszowy zawierający wartości funkcji Runge dla wektora x_fine=linspace(-1, 1, 1000)
% interpolated_Runge - wektor wierszowy wartości funkcji interpolującej określonej dla równomiernie rozmieszczonych węzłów interpolacji
% interpolated_Runge_Chebyshev - wektor wierszowy wartości funkcji interpolującej wyznaczonej
%       przy zastosowaniu 16 węzłów Czebyszewa zawartych w nodes_Chebyshev 
	N = 16;
	x_fine = linspace(-1, 1, 1000);
	nodes_Chebyshev = get_Chebyshev_nodes(N);

	V = vandermonde_matrix(N);
	V2 = vandermonde_matrix_Chebyshev(N, nodes_Chebyshev);
	original_Runge = 1 ./ (1 + 25 * x_fine.^2);

	x_coarse = linspace(-1,1,N);
	y_coarse = 1 ./ (1 + 25 * x_coarse.^2);
	c_runge = V \ y_coarse';
	interpolated_Runge = polyval(flipud(c_runge), x_fine);

	y_coarse_Chebyshev = 1 ./ (1 + 25 * nodes_Chebyshev.^2);
	c_runge_Chebyshev = V2 \ y_coarse_Chebyshev';
	interpolated_Runge_Chebyshev = polyval(flipud(c_runge_Chebyshev), x_fine);

	f = figure;
	subplot(2,1,1);
	plot(x_fine, original_Runge);
	hold on;
	plot(x_fine, interpolated_Runge);
	plot(x_coarse, y_coarse, 'o');
	title('Równomiernie rozmieszczone węzły interpolacji');
	xlabel('x');
	ylabel('f(x)');
	legend('Oryginalna funkcja', 'Interpolacja');
	hold off;

	subplot(2,1,2);
	plot(x_fine, original_Runge);
	hold on;
	plot(x_fine, interpolated_Runge_Chebyshev);
	plot(nodes_Chebyshev, y_coarse_Chebyshev, 'o');
	title('Węzły interpolacji Czebyszewa');
	xlabel('x');
	ylabel('f(x)');
	legend('Oryginalna funkcja', 'Interpolacja');
	hold off;
	exportgraphics(f, 'zadanie2.png', 'Resolution', 300);
end

function nodes = get_Chebyshev_nodes(N)
	% oblicza N węzłów Czebyszewa drugiego rodzaju
	nodes = cos(((0:N-1)+1)*pi/(N-1));
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

function V2 = vandermonde_matrix_Chebyshev(N, nodes)
	% Generuje macierz Vandermonde dla N węzłów interpolacji zdefiniowanych w wektorze nodes
	V2 = zeros(N,N);
	for i = 1:N
		for j = 1:N
			V2(i,j) = nodes(i)^(j-1);
		end
	end
end