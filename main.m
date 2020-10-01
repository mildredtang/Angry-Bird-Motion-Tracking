%% < main.m >
%
%  ENGN4528 Computer Vision
%  Research Project: Angry Bird Trajectory Tracking
%
%
%  < Description >
%  This is the main script to run the detector on the test video.
%
%
%  < Authors >
%         - Xiaoli Tang (u5853650)
%         - Bhumipat Chatlekhavanich (u6069393)
%
%  < References >
%  https://au.mathworks.com/matlabcentral/fileexchange/69180-using-ground-truth-for-object-detection
%  https://au.mathworks.com/help/matlab/ref/linspace.html
%  https://au.mathworks.com/help/vision/ref/objectdetectortrainingdata.html
%  https://au.mathworks.com/help/vision/ug/train-object-detector-or-semantic-segmentation-network-from-ground-truth-data.html
%
%  May, 2019

%% Preparation

close all; clear; clc;

% load a set of trained detectors
load('Detector_red.mat');
load('Detector_yellow.mat');
load('Detector_blue.mat');
load('Detector_black.mat');
load('Detector_white.mat'); % for white birds before laying eggs
load('Detector_white2.mat'); % for white birds after laying eggs

% load the gameplay video of Angry birds
vidReader = VideoReader('Angry Birds In-game Trailer.m4v');
vidPlayer = vision.DeployableVideoPlayer;

% read the video frame by frame for further processing
I = readFrame(vidReader);

%% Detector application

% Notice:
% In this section, the specific frame counts are used prior to detector
% application to enhance detection accuracy. The exact number of frame
% counts comes from observation and division on the test video. In this
% way, we can apply particular detectors for each bird to avoid the
% possibility of detection overlay.

count = 0;
b_centre = [0,0];
b_centre1 = [0,0];
b_centre2 = [0,0];
b_centre3 = [0,0];
a = linspace(0, 480); % establish the x asix in the video frame
while(hasFrame(vidReader))
    count = count + 1;
    
    % detect the red bird from frame 435 to 499
    if count >= 435 && count <= 490 %
        I = readFrame(vidReader);
        % apply the red bird detector
        [Newbboxes, I] = runBirdDetection(detector_red,vidPlayer,1,I);
        centre = [Newbboxes(1)+0.5*Newbboxes(3), Newbboxes(2)+0.5*Newbboxes(4)];
        b_centre = [b_centre;centre];
        if b_centre(end,1) < b_centre(end-1,1)
            b_centre(end,:) = [];
        end
        
    elseif count == 491
        I = readFrame(vidReader);
        [b_centre_red,plot_red1,I_red1,coef_red1] = drawTraj(1,I,b_centre);
        b_centre = [0,0];
        
        % detect blue birds
        % firstly detect the blue birds before splitting from frame 725 to 761
    elseif count >= 725 && count <= 761
        % apply blue bird detector
        I = readFrame(vidReader);
        [Newbboxes, I] = runBirdDetection(detector_blue,vidPlayer,1,I);
        centre = [Newbboxes(1)+0.5*Newbboxes(3), Newbboxes(2)+0.5*Newbboxes(4)];
        b_centre = [b_centre;centre];
    elseif count == 762
        I = readFrame(vidReader);
        [b_centre_blue1,plot_blue1,I_blue1,coef_blue1] = drawTraj(1,I,b_centre);
        b_centre = [0,0];
        
        % then detect the slitted three blue birds from frame 765 to 782
    elseif count >= 765 && count <= 782
        % apply three blue birds detectors
        I = readFrame(vidReader);
        [Newbboxes, I] = runBirdDetection(detector_blue,vidPlayer,3,I);
        centre1 = [Newbboxes(1,1)+0.5*Newbboxes(1,3), Newbboxes(1,2)+0.5*Newbboxes(1,4)];
        centre2 = [Newbboxes(2,1)+0.5*Newbboxes(2,3), Newbboxes(2,2)+0.5*Newbboxes(2,4)];
        centre3 = [Newbboxes(3,1)+0.5*Newbboxes(3,3), Newbboxes(3,2)+0.5*Newbboxes(3,4)];
        b_centre1 = [b_centre1;centre1];
        b_centre2 = [b_centre2;centre2];
        b_centre3 = [b_centre3;centre3];
        
    elseif count == 783
        I = readFrame(vidReader);
        [centres_x1,centres_x2,centres_x3,centres_y1,centres_y2,centres_y3,...
            f1,f2,f3,I_blue2,coef1_blue,coef2_blue,coef3_blue] ...
            = drawTraj_blue3(I,b_centre1,b_centre2,b_centre3);
        
        % detect the yellow bird from frame 875 to 954
    elseif count >= 875 && count <= 954
        % apply the yellow bird detector
        I = readFrame(vidReader);
        [Newbboxes, I] = runBirdDetection(detector_yellow,vidPlayer,1,I);
        centre = [Newbboxes(1)+0.5*Newbboxes(3), Newbboxes(2)+0.5*Newbboxes(4)];
        b_centre = [b_centre;centre];
        if b_centre(end,1) <= b_centre(end-1,1)
            b_centre(end,:) = [];
        end
    elseif count == 955
        I = readFrame(vidReader);
        [b_centre_yellow,plot_yellow,I_yellow,coef_yellow] = drawTraj(2,I,b_centre);
        b_centre = [0,0];
        
        % detect the black bird from frame 1130 to 1180
    elseif count >= 1130 && count <= 1180
        % apply the black bird detector
        I = readFrame(vidReader);
        [Newbboxes, I] = runBirdDetection(detector_black,vidPlayer,1,I);
        centre = [Newbboxes(1)+0.5*Newbboxes(3), Newbboxes(2)+0.5*Newbboxes(4)];
        b_centre = [b_centre;centre];
        if b_centre(end,1) <= b_centre(end-1,1)
            b_centre(end,:) = [];
        end
        
    elseif count == 1181
        I = readFrame(vidReader);
        [b_centre_black,plot_black,I_black,coef_black] = drawTraj(1,I,b_centre);
        b_centre = [0,0];
        
        % detect white bird
        % firstly detect the white bird before laying egg from frame 1392
        % to 1425
    elseif count >= 1392 && count <= 1425
        % apply the white bird detector before laying egg
        I = readFrame(vidReader);
        [Newbboxes, I] = runBirdDetection(detector_white,vidPlayer,1,I);
        centre = [Newbboxes(1)+0.5*Newbboxes(3), Newbboxes(2)+0.5*Newbboxes(4)];
        b_centre = [b_centre;centre];
        if b_centre(end,1) <= b_centre(end-1,1)
            b_centre(end,:) = [];
        end
        
    elseif count == 1426
        I = readFrame(vidReader);
        [b_centre_white1,plot_white1,I_white1,coef_white1] = drawTraj(2,I,b_centre);
        b_centre = [0,0];
        
        % then detect the white bird after laying egg from frame 1427 to
        % 1434
    elseif count >= 1427 && count <= 1434
        % apply the white bird detector after laying egg
        I = readFrame(vidReader);
        [Newbboxes, I] = runBirdDetection(detector_white2,vidPlayer,1,I);
        centre = [Newbboxes(1)+0.5*Newbboxes(3), Newbboxes(2)+0.5*Newbboxes(4)];
        b_centre = [b_centre;centre];
        
    elseif count == 1435
        I = readFrame(vidReader);
        [b_centre_white2,plot_white2,I_white2,coef_white2] = drawTraj(3,I,b_centre);
        b_centre = [0,0];
        
        % detect the red bird from frame 1690 to 1740
    elseif count >= 1690 && count <= 1740
        % apply the red bird detector
        I = readFrame(vidReader);
        [Newbboxes, I] = runBirdDetection(detector_red,vidPlayer,1,I);
        centre = [Newbboxes(1)+0.5*Newbboxes(3), Newbboxes(2)+0.5*Newbboxes(4)];
        b_centre = [b_centre;centre];
        
        if b_centre(end,1) <= b_centre(end-1,1)
            b_centre(end,:) = [];
        end
        
    elseif count == 1742
        I = readFrame(vidReader);
        [b_centre_red2,plot_red2,I_red2,coef_red2] = drawTraj(1,I,b_centre);
        b_centre = [0,0];
        
        % otherwise, just play the video normally
    else
        I = readFrame(vidReader);
        step(vidPlayer,I);
        pause(0.02);
    end
    
end

% plotting of estimation curves
% red bird
plot_bird(I_red1, b_centre_red,plot_red1)

% blue bird
plot_bird(I_blue1, b_centre_blue1,plot_blue1)

% blue birds * 3
pause(1)
figure;
imshow(I_blue2);
% hold on;
% plot(centres_x1, centres_y1,'mo',centres_x2, centres_y2,'mo',centres_x3, centres_y3,'mo');
hold on;
plot(a,f1,'r--',a,f2,'r--',a,f3,'r--');

%yellow bird
plot_bird(I_yellow, b_centre_yellow,plot_yellow)
%black bird
plot_bird(I_black, b_centre_black,plot_black)

%white bird before laying egg
plot_bird(I_white1, b_centre_white1,plot_white1)

%white bird after laying egg
plot_bird(I_white2, b_centre_white2,plot_white2)

% red bird
plot_bird(I_red2, b_centre_red2,plot_red2)

% display the coefficients used for the estimation
fprintf('the coefficients for the first red bird are %d, %d, %d.\n',...
    coef_red1(1),coef_red1(2),coef_red1(3));
fprintf('the coefficients for the single blue bird are %d, %d, %d.\n',...
    coef_blue1(1),coef_blue1(2),coef_blue1(3));
fprintf('the first set of coefficients for three blue birds are %d, %d, %d.\n',...
    coef1_blue(1),coef1_blue(2),coef1_blue(3));
fprintf('the second set of coefficients for three blue birds are %d, %d, %d.\n',...
    coef2_blue(1),coef2_blue(2),coef2_blue(3));
fprintf('the third set of coefficients for three blue birds are %d, %d, %d.\n',...
    coef3_blue(1),coef3_blue(2),coef3_blue(3));
fprintf('the coefficients for the yellow bird are %d, %d.\n',...
    coef_yellow(1),coef_yellow(2));
fprintf('the coefficients for the black bird are %d, %d, %d.\n',...
    coef_black(1),coef_black(2),coef_black(3));
fprintf('the coefficients for the white bird before laying egg are %d, %d.\n',...
    coef_white1(1),coef_white1(2));
fprintf('the coefficients for the white bird after laying egg are %d, %d.\n',...
    coef_white2(1),coef_white2(2));
fprintf('the coefficients for the last red bird are %d, %d, %d.\n',...
    coef_red2(1),coef_red2(2),coef_red2(3));
release(vidPlayer);