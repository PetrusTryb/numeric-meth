a = 1;
b = 60000;
ytolerance = 1e-12;
max_iterations = 100;

[n_bisection,ysolution_bisection,iterations_bisection,xtab_bisection,xdif_bisection] = bisection_method(a, b, max_iterations, ytolerance, @estimate_execution_time)
[n_secant,ysolution_secant,iterations_secant,xtab_secant,xdif_secant] = secant_method(a, b, max_iterations, ytolerance, @estimate_execution_time)

f = figure
subplot(2,1,1)
plot(xtab_bisection, 'r')
hold on
plot(xtab_secant, 'b')
title('Wartość kandydata na pierwiastek')
legend('Metoda bisekcji', 'Metoda siecznych', 'Location', 'SouthEast')
xlabel('iteracja')
ylabel('wartość')
hold off

subplot(2,1,2)
semilogy(xdif_bisection, 'r')
hold on
semilogy(xdif_secant, 'b')
title('Różnica pomiędzy kolejnymi przybliżeniami pierwiastka')
legend('Metoda bisekcji', 'Metoda siecznych')
xlabel('iteracja')
ylabel('wartość')
hold off

exportgraphics(f, 'graphs/8.png', 'Resolution', 800)