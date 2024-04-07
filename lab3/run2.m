N = 1000:1000:8000;
n = length(N);
vtime_direct = ones(1,n); 
for i = 1:n
	[~,~,~,vtime_direct(i),~,~] = solve_direct(N(i));
end
plot_direct(N,vtime_direct);