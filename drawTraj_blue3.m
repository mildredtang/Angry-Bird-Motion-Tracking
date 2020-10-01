function [centres_x1,centres_x2,centres_x3,centres_y1,centres_y2,centres_y3,f1,f2,f3,I_blue2,p1,p2,p3] ...
    = drawTraj_blue3(I,b_centre1,b_centre2,b_centre3)
b_centre1(1,:)  = [];
b_centre2(1,:)  = [];
b_centre3(1,:)  = [];

b_centre1(end,:) = [];
b_centre1(end,:) = [];
b_centre2(end,:) = [];
b_centre2(end,:) = [];
b_centre3(end,:) = [];
b_centre3(end,:) = [];

centres_x1 = b_centre1(:,1);
centres_y1 = b_centre1(:,2);
centres_x2 = b_centre2(:,1);
centres_y2 = b_centre2(:,2);
centres_x3 = b_centre3(:,1);
centres_y3 = b_centre3(:,2);
p1 = polyfit(centres_x1, centres_y1, 2);
p2 = polyfit(centres_x2, centres_y2, 2);
p3 = polyfit(centres_x3, centres_y3, 2);

a = linspace(0, 480);
f1 = polyval(p1, a);
f2 = polyval(p2, a);
f3 = polyval(p3, a);
I_blue2 = I;

end