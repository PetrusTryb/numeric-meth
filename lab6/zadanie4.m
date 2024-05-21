function [country, source, degrees, x_coarse, x_fine, y_original, y_yearly, y_approximation, mse, msek] = zadanie4(energy)
	% Głównym celem tej funkcji jest wyznaczenie danych na potrzeby analizy dokładności aproksymacji wielomianowej.
	% 
	% energy - struktura danych wczytana z pliku energy.mat
	% country - [String] nazwa kraju
	% source  - [String] źródło energii
	% x_coarse - wartości x danych aproksymowanych
	% x_fine - wartości, w których wyznaczone zostaną wartości funkcji aproksymującej
	% y_original - dane wejściowe, czyli pomiary produkcji energii zawarte w wektorze energy.(country).(source).EnergyProduction
	% y_yearly - wektor danych rocznych
	% y_approximation - tablica komórkowa przechowująca wartości nmax funkcji aproksymujących dane roczne.
	%   - nmax = length(y_yearly)-1
	%   - y_approximation{i} stanowi aproksymację stopnia i
	%   - y_approximation{i} stanowi wartości funkcji aproksymującej w punktach x_fine
	% mse - wektor mający nmax wierszy: mse(i) zawiera wartość błędu średniokwadratowego obliczonego dla aproksymacji stopnia i.
	%   - mse liczony jest dla aproksymacji wyznaczonej dla wektora x_coarse
	% msek - wektor mający (nmax-1) wierszy: msek zawiera wartości błędów różnicowych zdefiniowanych w treści zadania 4
	%   - msek(i) porównuj aproksymacje wyznaczone dla i-tego oraz (i+1) stopnia wielomianu
	%   - msek liczony jest dla aproksymacji wyznaczonych dla wektora x_fine
	country = 'Poland';
	source = 'Solar';
	% Sprawdzenie dostępności danych
	if isfield(energy, country) && isfield(energy.(country), source)
		% Przygotowanie danych do aproksymacji
		y_original = energy.(country).(source).EnergyProduction;
		% Obliczenie danych rocznych
		n_years = floor(length(y_original) / 12);
		y_cut = y_original(end-12*n_years+1:end);
		y4sum = reshape(y_cut, [12 n_years]);
		y_yearly = sum(y4sum,1)';
		N = length(y_yearly);
		P = (N-1)*10+1;
		x_coarse = linspace(-1, 1, N)';
		x_fine = linspace(-1, 1, P)';
        degrees = floor(2:N/4:N);

		y_approximation = cell(N-1, 1)';
		mse = zeros(N-1, 1);
		msek = zeros(N-2, 1);
		% Pętla po wielomianach różnych stopni
		for i = 1:N-1
			p = my_polyfit(x_coarse, y_yearly, i);
			y_approximation{i} = polyval(p, x_fine);
			mse(i, 1) = mean((y_yearly - polyval(p, x_coarse)).^2);
			if i >= 2
				msek(i-1, 1) = mean((y_approximation{i} - previous).^2);
			end
			previous = y_approximation{i};
		end
		figure;
		subplot(3,1,1);
		plot(x_coarse, y_yearly, 'k', 'DisplayName', 'Original data');
		hold on;
		for i = 1:length(degrees)
			plot(x_fine, y_approximation{i}, 'DisplayName', ['Approximation degree: ', num2str(degrees(i))]);
		end
		title(['Approximation of energy production in ', country, ' from ', source]);
		legend('Location', 'northwest');
		xlabel('Date');
		ylabel('Energy production');
		subplot(3,1,2);
		semilogy(mse);
		xlabel('Polynomial degree');
		ylabel('MSE');
		title('Mean Squared Error for different polynomial degrees');
		subplot(3,1,3);
		semilogy(msek);
		xlabel('Polynomial degree');
		ylabel('MSE_K');
		title('Differential Mean Squared Error for different polynomial degrees');
		saveas(gcf, 'zadanie4.png');
	else
		disp(['Dane dla (country=', country, ') oraz (source=', source, ') nie są dostępne.']);
	end
end
function p = my_polyfit(x, y, deg)
	n = deg + 1;
	A = zeros(length(x), n);
	for i = 1:n
		A(:,i) = x.^(n-i);
	end
	p = (A'*A)\(A'*y);
end