%% What is a Callback?
 % how to display realtime values in a box
 
 
 
 %% 

% model the uniformity drift in a substrate grown crop
% close all;
% clc ;
% clear all;
format long;

% count from t=0 to t=...  in a for loop

% for each time t, calculate water consumed (definite integral of
% transpiration from t to t1

% and subtract this value from total water in pot

%When W<= Limit, add 150

%  all the while updating graph
syms t; % initiate symbolic variable

trans=((0.4069*t^4)-(21.061*t^3)+(383.29*t^2)-(2866*t)+7527.4); %R^2= 0.9745  | based on priva Transpiration Data of Conv Maravilla start 12, 10.31.2016

prompt = {'Enter phase volume (ml)','Enter lower volume limit (ml)','Enter Starting moisture (ml)','Enter number of plants','Enter number of plants on Root Optimizer'}; %solicit user input
dlg_title = 'Plant Scenario'; 
num_lines = 1;
defaultans = {'150','6000','7000','100','5'};% setting default values
answer = inputdlg(prompt,dlg_title,num_lines,defaultans); %making an array of answers
phase = str2double(answer(1)); %defines each variable to its value from answers above
limit = str2double(answer(2));%
starting_moisture = str2double(answer(3));%
n = str2double(answer(4));
numROplants=str2double(answer(5)); %

% P2=P1;  %starting moisture

% generate random "plant factors" that operate on the transpiration
% equation (uniformity factor)

%specifically, generates n random numbers between 0.1 and 3.0 in vector,
%unifactor


% xmin=.5;
% xmax=2;
% unifactors=xmin+rand(1,n)*(xmax-xmin);
unifactors=normrnd(1,.5, 1,n);

field=ones(n,1);  % vector as placeholder for each plant 

% Graph each column of crop as a bar in bar graph
field=field*starting_moisture;  % starting moisture of each plant in crop

Bar1=bar(field);

set(Bar1, 'YDataSource', 'field');

set(gca, 'YLim', [0, 10000]);

% set(gca, 'YLim', [1, n]);

%%%%%%%%%

crop = unifactors'*trans;  % creating a vector that represents each different plants transpiration rate


trans1=unifactors(1)*trans; %transpiration equation
trans2=unifactors(2)*trans;


% display(pf1);
% display(pf2);
display('SUNRISE');
pause(0.1);

for t = 8:.25:18.5;
    
    %create vector showing consumption during this time by each plant
    consumption=int(crop, t-.25,t);
    
    %update the level of moisture in each pot by subtracting consumption
    %from field
    
    field = field - consumption;

    pause(.1);
    refreshdata
    display('TRANSPIRATION');
    pause(.1)
       if sum(field(1:numROplants))<=limit*numROplants %once the moisture of the plants on the root optimizer sums greater than irrigation limit, apple an irrigation
          field=field+phase;
          refreshdata
          display('IRRIGATIONp1');

       end 
       
       pause(.1);
      
       refreshdata
       
%     doublefield=double(field);
%     stddoublefield=std(doublefield)
end

display('SUNSET')

