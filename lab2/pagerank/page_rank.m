function [numer_indeksu, Edges, I, B, A, b, r] = page_rank()
	numer_indeksu = 193557;
	L1 = mod(floor(numer_indeksu/10), 10);
	L2 = mod(floor(numer_indeksu/100), 10);
	Edges = [
		1,1,2,2,2,3,3,3,4,4,5,5,6,6,7,8,mod(L2, 7)+1;
		4,6,3,4,5,5,6,7,5,6,4,6,4,7,6,mod(L1, 7)+1,	8
	];
	I = speye(8);
	B = sparse(Edges(2,:), Edges(1,:), 1, 8, 8);
	A = spdiags(1./sum(B)', 0, 8, 8);
	d = 0.85;
	b = (1-d)/8 * ones(8, 1);
	M = I - d*B*A;
	r = M\b;
end