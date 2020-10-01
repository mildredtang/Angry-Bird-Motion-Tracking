function [b_centre,plot_bird,I_bird,p] = drawTraj(detectorType,I,b_centre)


a = linspace(0, 480);
if detectorType == 1 %applied to red bird, single blue bird and black bird
    b_centre(1,:)  = [];
    b_centre(1,:)  = [];
    centres_x = b_centre(:,1);
    centres_y = b_centre(:,2);
    p = polyfit(centres_x, centres_y, 2);
    
    
elseif detectorType == 2 % applied to yellow bird and white bird before laying egg
    
    b_centre(1,:)  = [];
    b_centre(1,:)  = [];

    centres_x = b_centre(:,1);
    centres_y = b_centre(:,2);
    p = polyfit(centres_x, centres_y, 1);
    
elseif detectorType == 3 % applied to white bird after laying egg
    b_centre(1,:)  = [];
    b_centre(end,:) = [];
    centres_x = b_centre(:,1);
    centres_y = b_centre(:,2);
    p = polyfit(centres_x, centres_y, 1);
 
else
    return
end
plot_bird = polyval(p, a);
I_bird = I;

end