function plot_direct(N,vtime_direct)
    % N - wektor zawierający rozmiary macierzy dla których zmierzono czas obliczeń metody bezpośredniej
    % vtime_direct - czas obliczeń metody bezpośredniej dla kolejnych wartości N
	plot(N,vtime_direct,'-or');
	title('Czas rozwiązywania układu metodą bezpośrednią');
	xlabel('Rozmiar macierzy');
	ylabel('Czas obliczeń [s]');
end