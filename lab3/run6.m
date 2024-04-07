load("filtr_dielektryczny.mat")

tic;
r = A\b;
time = toc;
err_norm = norm(A*r - b);
fprintf("Metoda bezpośrednia\n");
fprintf("Norma błędu residualnego: %.20f\n", err_norm);
fprintf("Czas: %f\n", time);

M = -1 * (diag(diag(A))\(tril(A, -1) + triu(A, 1)));
bm = diag(diag(A))\b;
x = ones(length(b), 1);
iterations = 0;
err_norm = 1;
tic;
while err_norm >= 1e-12 && iterations < 1000
	x = M * x + bm;
	err_norm = norm(A * x - b);
	iterations = iterations + 1;
end; time = toc;
fprintf("Metoda Jacobiego\n");
fprintf("Norma błędu residualnego: %.20f\n", err_norm);
fprintf("Czas: %f\n", time);

M = -1 * ((tril(A, -1) + diag(diag(A))) \ triu(A, 1));
bm = (tril(A, -1) + diag(diag(A))) \ b;
x = ones(length(b), 1);
iterations = 0;
err_norm = 1;
tic;
while err_norm >= 1e-12 && iterations < 1000
	x = M * x + bm;
	err_norm = norm(A * x - b);
	iterations = iterations + 1;
end; time = toc;
fprintf("Metoda Gaussa-Seidla\n");
fprintf("Norma błędu residualnego: %.20f\n", err_norm);
fprintf("Czas: %f\n", time);
