%This is just a temporary script

%  Data Loading

%  Frequency distribution

%histogram(allresults(1).radius, 'Normalization', 'probability')
%{
figure
histogram(allresults(2).radius, 'Normalization', 'probability')
figure
histogram(allresults(3).radius, 'Normalization', 'probability')
%}
%  Average
average1 = mean2(allresults(1).radius)
%  Standard deviation
S1 = std(allresults(1).radius)

%  (OPTIONAL) Data export to excel
%  NOT FINISHED!

writematrix(allresults(1).radius,'radius.xlsx')
%}
