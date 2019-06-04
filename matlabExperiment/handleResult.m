
labels = ["Alabel", "Blabel"];
classes = ["EM", "EP", "EPM", "MP", "PE", "PEM", "PM", "unsure"];
genders = ["male", "female"];

slash = "";
if ismac
    slash = "/";
elseif ispc
    slash = "\";
end

Map = [];

for i=1: length(labels)
    for j=1: length(genders)
        for k=1: length(classes)
            dir = labels(i) + slash + genders(j) + slash + classes(k);
            map = mapOfPath(dir);
            Map = [Map; map];
        end
    end
end

map = Map % 253

col = string(result{:, "ActualSpeaker"});
res = string([1, length(col)]);
for i=1:length(col)
    col(i)
    res(i) = map(col(i))
end

col2 = string(result{:, "PredictedSpeaker"});
res2 = string([1, length(col2)]);
for i=1:length(col2)
    col2(i)
    res2(i) = map(col2(i))
end

table(res', res2')

hit = 0;
for i=1:length(res)
    if res(i) == res2(i)
        hit = hit + 1;
    end
end

hit = 0;
for i=1:length(res)
    if extractBetween(res(i), 1, 1) == extractBetween(res2(i), 1, 1)
        hit = hit + 1;
    end
end

ActualSpeakerClass = res'
PredictedSpeakerClass = res2'

cm = confusionchart(ActualSpeakerClass,PredictedSpeakerClass,'title','0.2s sample 75% overlap');
cm.ColumnSummary = 'column-normalized';
cm.RowSummary = 'row-normalized';
