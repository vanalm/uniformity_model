 % how to display realtime values in a box
 
 
 
 %% 

% model the uniformity drift in a substrate grown crop
close all;
clc ;
clear all;
format long;

% count from t=0 to t=...  in a for loop

% for each time t, calculate water consumed (definite integral of
% transpiration from t to t1

% and subtract this value from total water in pot

%When W<= Limit, add 150

%  all the while updating graph
syms t; % initiate symbolic variable

trans=((0.4069*t^4)-(21.061*t^3)+(383.29*t^2)-(2866*t)+7527.4); %R^2= 0.9745  | based on priva Transpiration Data of Conv Maravilla start 12, 10.31.2016

prompt = {'Enter phase volume (ml)','Enter lower volume limit (ml)','Enter Starting moisture (ml)','Enter number of plants','Enter number of plants on Root Optimizer','Enter Sigma value of distribution','Enter number of days to model'}; %solicit user input
dlg_title = 'Plant Scenario'; 
num_lines = 1;
defaultans = {'150','6000','6200','100','5','0.25','1'};% setting default values
answer = inputdlg(prompt,dlg_title,num_lines,defaultans); %making an array of answers
phase1 = str2double(answer(1)); %defines each variable to its value from answers above
limit = str2double(answer(2));%
starting_moisture = str2double(answer(3));%
n = str2double(answer(4));
numROplants=str2double(answer(5)); %
sigma=str2double(answer(6));
numdays=str2double(answer(7));
% generate random "plant factors" that operate on the transpiration
% equation (uniformity factor)

%specifically, generates n random numbers between 0.1 and 3.0 in vector,
%unifactor

unifactors=normrnd(1,sigma, 1,n);

field=ones(n,1);  % vector as placeholder for each plant 

%%% Graph each column of crop as a bar in bar graph
field=field*starting_moisture;  % starting moisture of each plant in crop

Bar1=bar(field);

set(Bar1, 'YDataSource', 'field');

set(gca, 'YLim', [0, 7000]);

% set(gca, 'YLim', [1, n]);

%%%%%%%%%

crop = unifactors'*trans;  % creating a vector that represents each different plant's transpiration rate


% display(pf1);
% display(pf2);
pause(0.1);
for Day=1:1:numdays
    
    display('SUNRISE');
        

    for t = 8:.25:18.5;

        %create vector showing consumption during this time by each plant
        consumption=int(crop, t-.25,t);

        %update the level of moisture in each pot by subtracting consumption
        %from field
        display('TRANSPIRATION');
        field = field - consumption;

    %     pause(.1);
        refreshdata
        pause(.1)
        ROplants=field(1:numROplants);
           if sum(ROplants)<=limit*numROplants %once the moisture of the plants on the root optimizer sums greater than irrigation limit, apple an irrigation
              field=field+phase1;
              refreshdata
              display('IRRIGATION');
%               drainingplants=ROplants>sat
           end 

    %        pause(.1);

           refreshdata

        doublefield=double(field);
        stddoublefield=std(doublefield); %https://www.mathworks.com/matlabcentral/newsreader/view_thread/50439  [ set(handle,'String',num2str(a)) ] 
    %     display(stddoublefield);

    end
    display('SUNSET')

    
    
%     set up drain on drainday
%     if Day=drainday
%         
%         if drainROplants < draingoal
%             field=field+phase2
%             drain = (ROplants+phase2)-(sat_weight*numROplants)
%             drainROplants=ro==
%                     
% 
%             
%             
%             drain=(field(1:numROplants)+drainphase)-satlevel
%     
%     
    
end

%flush on day___ (user input:drainday)  (when Day=drainday)
%for drain, irrigate with phase __ (user input:drainphase) until all plants are at
%saturation

%define saturation level (user input (satlevel) as: if volume(field(1:n))>satlevel(ml)
%then volume+irrigation - satlevel= drain ||then, volume(field) = satlevel
