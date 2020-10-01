function plot_bird(I_bird, b_centre_bird,plotting)
a = linspace(0, 480);
pause(1)
figure;
imshow(I_bird);
% hold on;
% plot(b_centre_bird(:,1), b_centre_bird(:,2),'o');
hold on;
plot(a,plotting,'r--');

end