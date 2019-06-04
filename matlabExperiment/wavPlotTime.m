function info = wavPlotTime(filename)
% wavPlotTime - plot wav file on figure and return audio info
% On input:
%     filename: path to audio file
% On output:
%     info (struct) : struct with info fields
% Call:
%     info = wavPlotTime("Alabel/male/EM/A00031 (1).wav");
% Author:
%     Kenway Sun
%     June 2019
%

[y,Fs] = audioread(filename);
info = audioinfo(filename);

t = 0:seconds(1/Fs):seconds(info.Duration);
t = t(1:end-1);

plot(t,y)
xlabel('Time')
ylabel('Audio Signal')