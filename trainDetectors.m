%% < trainDetectors.m >
%  ENGN4528 Computer Vision  
%  Research Project: Angry Bird Trajectory Tracking
%
%
%  < Description >
%  This is the module used for detectors training prior to main.m.
%  In this folder, the detectors are already trained, hence do not
%  run this file again unless the detectors need to be re-trained.
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

clear; close all; clc;  

% Notice:
% The training data fed to detectors are saved in gTruthTrainingxxxx.mat.
% They are generated from labeling the birds from other video sources via
% the MATLAB app 'Video Labeler'.
% In this file, we load the saved ground truth data files and feed them
% into detectors directly.
% Also, we save the training data into folders 'TrainingDataXxxx' under the
% same dictionary after training.

%% Train the red bird detector

load('gTruthTrainingRed.mat')
redBirdGTruth = selectLabels(gTruth,'red');

if isfolder(fullfile('TrainingDataRed'))
    cd TrainingDataRed
else
    mkdir TrainingDataRed
end 
addpath('TrainingDataRed');

trainingData_red = objectDetectorTrainingData(redBirdGTruth,'SamplingFactor',2,...
'WriteLocation','TrainingDataRed');

detector_red = trainACFObjectDetector(trainingData_red,'NumStages',5);
save('Detector_red.mat','detector_red');

%% Train the blue bird detector

load('gTruthTrainingBlue.mat')
blueBirdGTruth = selectLabels(gTruth,'blue');

if isfolder(fullfile('TrainingDataBlue'))
    cd TrainingDataBlue
else
    mkdir TrainingDataBlue
end 
addpath('TrainingDataBlue');

trainingData_blue = objectDetectorTrainingData(blueBirdGTruth,'SamplingFactor',2,...
'WriteLocation','TrainingDataBlue');

detector_blue = trainACFObjectDetector(trainingData_blue,'NumStages',5);
save('Detector_blue.mat','detector_blue');

%% Train the yellow bird detector

load('gTruthTrainingYellow.mat')
yellowBirdGTruth = selectLabels(gTruth,'yellow');

if isfolder(fullfile('TrainingDataYellow'))
    cd TrainingDataYellow
else
    mkdir TrainingDataYellow
end 
addpath('TrainingDataYellow');

trainingData_yellow = objectDetectorTrainingData(yellowBirdGTruth,'SamplingFactor',2,...
'WriteLocation','TrainingDataYellow');

detector_yellow = trainACFObjectDetector(trainingData_yellow,'NumStages',5);
save('Detector_yellow.mat','detector_yellow');

%% Train the white bird detector (before laying egg)

load('gTruthTrainingWhite.mat')
whiteBirdGTruth = selectLabels(gTruth,'white');

if isfolder(fullfile('TrainingDataWhite'))
    cd TrainingDataWhite
else
    mkdir TrainingDataWhite
end 
addpath('TrainingDataWhite');

trainingData_white = objectDetectorTrainingData(whiteBirdGTruth,'SamplingFactor',2,...
'WriteLocation','TrainingDataWhite');

detector_white = trainACFObjectDetector(trainingData_white,'NumStages',5);
save('Detector_white.mat','detector_white');

%% Train the white bird detector (after laying egg)

load('gTruthTrainingWhite2.mat')
whiteBirdGTruth2 = selectLabels(gTruth,'white2');

if isfolder(fullfile('TrainingDataWhite2'))
    cd TrainingDataWhite2
else
    mkdir TrainingDataWhite2
end 
addpath('TrainingDataWhite2');

trainingData_white2 = objectDetectorTrainingData(whiteBirdGTruth2,'SamplingFactor',2,...
'WriteLocation','TrainingDataWhite2');

detector_white2 = trainACFObjectDetector(trainingData_white2,'NumStages',5);
save('Detector_white2.mat','detector_white2');

%% Train the black bird detector

load('gTruthTrainingBlack.mat')
blackBirdGTruth = selectLabels(gTruth,'black');

if isfolder(fullfile('TrainingDataBlack'))
    cd TrainingDataBlack
else
    mkdir TrainingDataBlack
end 
addpath('TrainingDataBlack');

trainingData_black = objectDetectorTrainingData(blackBirdGTruth,'SamplingFactor',2,...
'WriteLocation','TrainingDataWhite2');

detector_black = trainACFObjectDetector(trainingData_black,'NumStages',5);
save('Detector_black.mat','detector_black');
