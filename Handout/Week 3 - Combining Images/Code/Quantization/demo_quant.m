% demo
close all; 
x = 2*randn(1, 4); 
x = sort(x); 

delta = 2; 
offset = 1/2; 
%% midrise quantization 
x1 = delta * (floor(x ./ delta) + 1/2); 



%% midtread quant
x2 = delta * (floor(x ./ delta + 1/2)); 

%% Reference
x3 = delta * (ceil(x ./ delta)) -1; 

figure(1); 
scatter(1:length(x), x, 'LineWidth', 3); grid on; hold on; 
scatter(1:length(x), x1, 'LineWidth', 3); 
scatter(1:length(x), x2, 'LineWidth', 3); 
scatter(1:length(x), x3, 'LineWidth', 3); 


err1 = sum( (x - x1).^2); 
err2 = sum( (x - x2).^2); 
err3 = sum( (x - x3).^2); 

legend('Org', ['Midrise:      ' +num2str(err1, 3)], ...
              ['Midtread:    ' +num2str(err2, 3)], ...
              ['Reference: ' +num2str(err3, 3)] ); 