function [M,N,P,R,x_coarse,y_coarse,F_coarse,x_fine,y_fine,F_fine] = zadanie4()
	P = 20; % liczba unikalnych współrzędnych x punktów dla których będzie obliczana interpolacja
	R = 20; % liczba unikalnych współrzędnych y punktów dla których będzie obliczana interpolacja
	M = 7; % liczba węzłów interpolacji wzdłuż osi X (stopień wielomianu zmiennej x: M-1)
	N = 7; % liczba węzłów interpolacji wzdłuż osi Y (stopień wielomianu zmiennej y: N-1)
	
	% Generowanie węzłów interpolacji na płaszczyźnie
	x_coarse = linspace(0, 1, M);
	y_coarse = linspace(0, 1, N);
	[X_coarse, Y_coarse] = meshgrid(x_coarse, y_coarse);
	
	% Wyznaczenie wartości funkcji oryginalnej w węzłach
	F_coarse = sin(21*pi*X_coarse) .* cos(37*pi*Y_coarse);
	
	MN = M*N;
	xvec_coarse = reshape(X_coarse, MN, 1);
	yvec_coarse = reshape(Y_coarse, MN, 1);
	fvec_coarse = reshape(F_coarse, MN, 1);
	
	% Macierz Vandermonde'a dla interpolacji 2d
	V = zeros(M*N, M*N);
	for i = 0:(M-1)
		for j = 0:(N-1)
			V(:, i*N + j + 1) = xvec_coarse.^i .* yvec_coarse.^j;
		end
	end
	
	% Współczynniki wielomianu interpolacyjnego
	coeffs = V \ fvec_coarse;
	
	% Obliczanie wartości funkcji interpolującej na gęstszej siatce
	x_fine = linspace(0, 1, P);
	y_fine = linspace(0, 1, R);
	[X_fine, Y_fine] = meshgrid(x_fine, y_fine);
	
	F_fine = zeros(size(X_fine));
	% zadanie B: zdefiniuj obliczenia wartości wielomianu interpolującego. Rezultat obliczeń zapisz w zmiennej F_fine.
	for i = 0:(M-1)
		for j = 0:(N-1)
			F_fine = F_fine + coeffs(i*N + j + 1) * X_fine.^i .* Y_fine.^j;
		end
	end

	subplot(2,1,1);
	surf(x_coarse, y_coarse, F_coarse);
	title('Funkcja oryginalna w węzłach interpolacji');
	xlabel('x');
	ylabel('y');
	zlabel('f(x,y)');

	subplot(2,1,2);
	surf(x_fine, y_fine, F_fine);
	title('Funkcja interpolacyjna');
	xlabel('x');
	ylabel('y');
	zlabel('f(x,y)');
	saveas(gcf, 'zadanie4.png');
end