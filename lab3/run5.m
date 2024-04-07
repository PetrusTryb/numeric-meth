N=1000:1000:8000;
n = length(N);
vtime_Jacobi = zeros(1,n);
vtime_Gauss_Seidel = zeros(1,n);
viterations_Jacobi = zeros(1,n);
viterations_Gauss_Seidel = zeros(1,n);
for i=1:n
	[~,~,~,~,~,~,vtime_Jacobi(i),viterations_Jacobi(i)] = solve_Jacobi(N(i));
	[~,~,~,~,~,~,vtime_Gauss_Seidel(i),viterations_Gauss_Seidel(i)] = solve_Gauss_Seidel(N(i));
	waitbar(i/n);
end
waitbar(1);
plot_problem_5(N,vtime_Jacobi,vtime_Gauss_Seidel,viterations_Jacobi,viterations_Gauss_Seidel);