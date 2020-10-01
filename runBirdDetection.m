%% < runBirdDetection.m >
%  ENGN4528 Computer Vision  
%  Research Project: Angry Bird Trajectory Tracking
%
%
%  < Description >
%  This is the function that performs detection on each video frame and
%  draw bounding boxes with label (the bird type and confidence level).
%  This function is called in main.m for each detector.
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

%% function code

function  [data ,I] = runBirdDetection(detectorType,vidPlayer,n,I)

[bboxes, scores] = detect(detectorType,I,'Threshold',1);
a = sort(scores);
data = [];
for index = 1:n
    
    if isempty(scores)
        step(vidPlayer,I);
        data = [0,0,0,0,0];
        break
    else
        idx = find(scores==a(end - (index-1)));
        idx = sort(idx);
        idx = idx(1);
        annotation = sprintf('%s , Confidence %4.2f',detectorType.ModelName',scores(idx));
        Newscores = scores(idx);
        Newbboxes = bboxes(idx,:);
        I = insertObjectAnnotation(I,'rectangle',Newbboxes,annotation);
        data = [data;[Newbboxes,Newscores]];
        step(vidPlayer,I); 
    end
    
end
a = data;
correctOrder = sort(data(:,2));

for i = 1:n
    if n == 1
        continue
    else
        index = find(a(:,2)==correctOrder(i));
        if length(index) > 1
            index = index(1);
        end
        data(i,:) = a(index,:);
    end
end

end