% demo
close all; 
x = 5 * [rand(1, 2) -1 * rand(1,3)]; 
x = sort(x); 

for i = [1 2 4 8]
delta = i; 
offset = 1/2; 
%% midrise quantization 
x1 = delta * (floor(x ./ delta) + 1/2); 



%% midtread quant
x2 = delta * (floor(x ./ delta + 1/2)); 

%% Reference
x3 = delta * (ceil(x ./ delta)) -1; 

pr = figure(1); 
tmp = [1:length(x); 1:length(x)];
tmp = tmp(:); 
scatter(1:length(x), x, 'LineWidth', 3); grid on; hold on; 
xt = [x1; x1];
plot(tmp, xt(:), '-d', 'LineWidth', 3); 
xt = [x2; x2];
plot(tmp, xt(:), '-o', 'LineWidth', 3); 
xt = [x3; x3];
plot(tmp, xt(:), '-s','LineWidth', 3); 


err1 = sum( (x - x1).^2); 
err2 = sum( (x - x2).^2); 
err3 = sum( (x - x3).^2); 

legend('Org', ['Midrise:      ' +num2str(err1, 3)], ...
              ['Midtread:    ' +num2str(err2, 3)], ...
              ['Reference: ' +num2str(err3, 3)], 'Location' , 'best'); 
title(['\Delta = ' num2str(delta)])
          
hold off; 
saveas(pr, ['im_delta' num2str(delta) '.png'])
end