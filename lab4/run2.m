format long
f = @(x) x.^2 - 4.01;
a = 1;
b = 50;
max_iterations = 100;
ytolerance = 1e-12;
% [xsolution,ysolution,iterations,xtab,xdif] = bisection_method(a,b,max_iterations,ytolerance,f)
[xsolution,ysolution,iterations,xtab,xdif] = bisection_method(a,b,max_iterations,ytolerance,@impedance_magnitude)
assert(abs(ysolution) < ytolerance)