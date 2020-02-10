% Soraya Boza

clear all
clc

f = figure;

myaxes = axes(f);
myaxes.Units = 'pixels';

myaxes.Position = [100 120 325 280];

% Always put the figure path first. The handle.
chooseplot = uicontrol(f, 'Style', 'text', 'String', 'Select Data', 'Position', [240 40 120 20]);
plotchoices = char('Occurrences', 'Popularity');

% This is a dropdown menu so the user can select what solution is going to
% be plotted.
plotoptions = uicontrol(f, 'Style', 'popup', 'String', plotchoices, 'Position', [240 20 120 20]);

% This simply creates text.
constant_title = uicontrol(f, 'Style', 'text', 'String', 'Enter name', 'Position', [400 40 120 20]);

% This creates an editable text box.
constant_value = uicontrol(f, 'Style', 'edit', 'Position', [400 20 120 20]);

firstbuttonplot = uicontrol(f, 'Style', 'pushbutton', 'Position', [50 15 150 40], 'String', 'Plot now!', 'fontsize', 16, 'callback', {@ProjectTwoFunction, plotoptions, constant_value});

 
function ProjectTwoFunction(~, ~, plotoptions, constantvalue)

% opening namedata.txt and seperating by comma
names_file = fopen('namedata.txt');
frewind(names_file);
name_data = textscan(names_file,'%f%f%f%f', 'Delimiter', ',');
fclose(names_file);

% These are my variables for my name data text file.
years = name_data{1,1};
Occurrences = name_data{1,3};
Popularity = name_data{1,4};

% opening SSN_Data.txt and seperating by com
SSN_file = fopen('SSN_Data.txt');
frewind(SSN_file);
SSN_data = textscan(SSN_file,'%s%f%f%f%f', 'Delimiter', ',');
fclose(SSN_file);

% these are my variables for my SSN text file
name = SSN_data{1,1};
m_occur = SSN_data{1,2};
b_occur = SSN_data{1,3};
m_popular = SSN_data{1,4};
b_popular = SSN_data{1,5};

% This plots my x and y values
what2plot = get(plotoptions, 'value');
x = years;
if what2plot == 1
    cla reset;
    y = Occurrences;
    y2 = (m_occur .* x) + b_occur;
    scatter(x, y, 7.0, 'r')
    hold on
    plot(x, y2, '-b', 'linewidth', 1.5)
    xlabel('Year')
    ylabel('Instances of this name')
    rm1 = round(m_occur, 2);
    rb1 = round(b_occur, 2);
    m1 = num2str(rm1);
    b1 = num2str(rb1);
    legend('SSN Data', strcat('m = ', m1, ' b = ', b1))
    title(name)
else
    cla reset;
    y = Popularity;
    y2 = (m_popular .* x) + b_popular;
    scatter(x, y, 7.0,'r')
    hold on
    plot(x, y2, '-b')
    xlabel('Year')
    ylabel('Popularity (per thousand instances)')
    rm2 = round(m_popular, 2);
    rb2 = round(b_popular, 2);
    m2 = num2str(rm2);
    b2 = num2str(rb2);
    legend('SSN Data', strcat('m = ', m2, ' b = ', b2))
    title(name)
end
end
