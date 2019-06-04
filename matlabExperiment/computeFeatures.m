function features = computeFeatures(ads)
% computeFeatures - compute human voice features
% On input:
%     ads (audioDatastore) : matlab audioDatastore struct
% On output:
%     features (nx16 table) : feature table with filename and label
% Call:
%     features = computeFeatures(trainDatastore);
% Author:
%     Kenway Sun
%     June 2019
%

reset(ads);
lenAds = length(ads.Files);
features = cell(lenAds,1);

% waitbar
f = waitbar(0,'Please wait...');

for i = 1:lenAds
    [data, info] = read(ads);
    features{i} = HelperComputePitchAndMFCC2(data,info);
    
    % Update waitbar and message
    waitbar(i/lenAds,f,sprintf('Processing %s', info.FileName))
    
    % handle two channel case
    if size(features{i,1}.Filename, 2) == 2
        features{i,1}.Filename = features{i,1}.Filename(:, 1);
        features{i,1}.Label = features{i,1}.Label(:, 1);
        features{i,1}.Pitch = ...
            max(features{i,1}.Pitch, [], 2, 'includenan');
    end
end

% waitbar
waitbar(1,f,'Finishing');
pause(1)

features = vertcat(features{:});
features = rmmissing(features);

featureVectors = features{:,2:15};

m = mean(featureVectors);
s = std(featureVectors);
features{:,2:15} = (featureVectors-m)./s;
head(features)   % Display the first few rows

% clost waitbar
close(f)

