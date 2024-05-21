function [country, source, degrees, x_coarse, x_fine, y_original, y_yearly, y_approximation, mse] = zadanie3(energy)
	% Głównym celem tej funkcji jest wyznaczenie aproksymacji rocznych danych o produkcji energii elektrycznej w wybranym kraju i z wybranego źródła energii.
	% Wybór kraju i źródła energii należy określić poprzez nadanie w tej funkcji wartości zmiennym typu string: country, source.
	% Dopuszczalne wartości tych zmiennych można sprawdzić poprzez sprawdzenie zawartości struktury energy zapisanej w pliku energy.mat.
	% 
	% energy - struktura danych wczytana z pliku energy.mat
	% country - [String] nazwa kraju
	% source  - [String] źródło energii
	% degrees - wektor zawierający cztery stopnie wielomianu dla których wyznaczono aproksymację
	% x_coarse - wartości x danych aproksymowanych; wektor o rozmiarze [N,1].
	% x_fine - wartości, w których wyznaczone zostaną wartości funkcji aproksymującej; wektor o rozmiarze [P,1].
	% y_original - dane wejściowe, czyli pomiary produkcji energii zawarte w wektorze energy.(country).(source).EnergyProduction
	% y_yearly - wektor danych rocznych (wektor kolumnowy).
	% y_approximation - tablica komórkowa przechowująca cztery wartości funkcji aproksymującej dane roczne.
	%   - y_approximation{i} stanowi aproksymację stopnia degrees(i)
	%   - y_approximation{i} stanowi wartości funkcji aproksymującej w punktach x_fine.
	% mse - wektor o rozmiarze [4,1]: mse(i) zawiera wartość błędu średniokwadratowego obliczonego dla aproksymacji stopnia degrees(i).
	country = 'Poland';
	source = 'Solar';
	degrees = 1:4;
	y_approximation = cell(1, length(degrees));
	mse = zeros(1,4);
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
		P = 10*N;
		x_coarse = linspace(-1, 1, N)';
		x_fine = linspace(-1, 1, P)';
		% Pętla po wielomianach różnych stopni
		for i = 1:length(degrees)
			p = my_polyfit(x_coarse, y_yearly, degrees(i));
			disp(p)
			y_approximation{i} = polyval(p, x_fine);
			mse(i) = mean((y_yearly - polyval(p, x_coarse)).^2);
		end
		figure;
		subplot(2,1,1);
		plot(x_coarse, y_yearly, 'k', 'DisplayName', 'Original data');
		hold on;
		for i = 1:length(degrees)
			plot(x_fine, y_approximation{i}, 'DisplayName', ['Approximation degree: ', num2str(degrees(i))]);
		end
		title(['Approximation of energy production in ', country, ' from ', source]);
		legend('Location', 'northwest');
		xlabel('Date');
		ylabel('Energy production');
		subplot(2,1,2);
		bar(mse);
		set(gca, 'XTickLabel', degrees);
		title('Mean Squared Error for different polynomial degrees');
		xlabel('Polynomial degree');
		ylabel('MSE');
		saveas(gcf, 'zadanie3.png');
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