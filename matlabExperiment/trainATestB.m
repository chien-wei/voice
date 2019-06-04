trainDatastore = createAds("Alabel/male/EM");
testDatastore = createAds("Blabel/male/MP");
% trainDatastore = createAds("Alabel");
% testDatastore = createAds("Blabel");

% extract features
features = computeFeatures(trainDatastore);
featuresTest = computeFeatures(testDatastore);

% train classifier
inputTable     = features;
predictorNames = features.Properties.VariableNames;
predictors     = inputTable(:, predictorNames(2:15));
response       = inputTable.Label;

trainedClassifier = fitcknn(...
    predictors, ...
    response, ...
    'Distance', 'euclidean', ...
    'NumNeighbors', 5, ...
    'DistanceWeight', 'squaredinverse', ...
    'Standardize', false, ...
    'ClassNames', unique(response));

result = HelperTestKNNClassifier(trainedClassifier, featuresTest)