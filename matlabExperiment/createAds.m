function ads = createAds(dataDir)
% createAds - create matlab audioDatastore given a directory
% On input:
%     dataDir: path to directory
% On output:
%     ads (audioDatastore) : matlab audioDatastore struct with wav file 
%       name label
% Call:
%     trainDatastore = createAds("Alabel");
% Author:
%     Kenway Sun
%     June 2019
%

ads = audioDatastore(dataDir, 'IncludeSubfolders', true, ...
'FileExtensions', '.wav');

N = size(ads.Files, 1);
labels = strings([1, N]);

% not used
validFilesCount = 0;

% setup audioDatastore object
for i = 1:N
    % set the file name as the tag
    fileName = cell2mat(ads.Files(i));
    if ismac
        % on macOS
        fileName = split(fileName, [" ", "/"]);
    elseif ispc
        % on windows
        fileName = split(fileName, [" ", "\"]);
    end
    
    M = size(fileName, 1);
    fileName = cell2mat(fileName(M-1));
    labels(i) = fileName;
    
    if startsWith(fileName,"A") || startsWith(fileName,"B")
        validFilesCount = validFilesCount + 1;
    end
end

ads.Labels = labels;
