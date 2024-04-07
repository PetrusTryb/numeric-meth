function [A,b,M,bm,x,err_norm,time,iterations,index_number] = solve_Jacobi(N)
	% A - macierz z równania macierzowego A * x = b
	% b - wektor prawej strony równania macierzowego A * x = b
	% M - macierz pomocnicza opisana w instrukcji do Laboratorium 3 – sprawdź wzór (5) w instrukcji, który definiuje M jako M_J.
	% bm - wektor pomocniczy opisany w instrukcji do Laboratorium 3 – sprawdź wzór (5) w instrukcji, który definiuje bm jako b_{mJ}.
	% x - rozwiązanie równania macierzowego
	% err_norm - norma błędu residualnego wyznaczona dla rozwiązania x; err_norm = norm(A*x-b)
	% time - czas wyznaczenia rozwiązania x
	% iterations - liczba iteracji wykonana w procesie iteracyjnym metody Jacobiego
	% index_number - Twój numer indeksu
	index_number = 193557;
	L1 = mod(index_number, 10);
	[A,b] = generate_matrix(N, L1);
	M = -1 * (diag(diag(A))\(tril(A, -1) + triu(A, 1)));
	bm = diag(diag(A))\b;
	x = ones(N, 1);
	iterations = 0;
	err_norm = 1;
	tic;
	while err_norm >= 1e-12 && iterations < 1000
		x = M * x + bm;
		err_norm = norm(A * x - b);
		iterations = iterations + 1;
	end; time = toc;
end	