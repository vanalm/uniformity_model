clc 
clear all

% count from t=0 to t=...  in a for loop

% for each time t, calculate water consumed (definite integral of
% transpiration from t to t1

% and subtract this value from total water in pot

%When W<= Limit, add 150

%  all the while updating graph
syms t; % initiate symbolic variable


trans=(-5.3297*t^2+140.38*t-723.52); %transpiration equation

prompt = {'Enter phase volume (ml)','Enter lower volume limit (ml)','Enter Starting moisture (ml)','Enter number of plants'}; %solicit user input
dlg_title = 'Plant Scenario'; 
num_lines = 1;
defaultans = {'150','6000','7000','2'};% setting default values
answer = inputdlg(prompt,dlg_title,num_lines,defaultans); %making an array of answers
phase = str2double(answer(1)); %defines each variable to its value from answers above
limit = str2double(answer(2));%
P1 = str2double(answer(3));%
n = str2double(answer(4));%

P2=P1;  %starting moisture


% generate random "plant factors" that operate on the transpiration
% equation (uniformity factor)

%specifically, generates n random numbers between 0.1 and 3.0 in vector,
%unifactor


xmin=.1;
xmax=3;
unifactor=xmin+rand(1,n)*(xmax-xmin);

field=ones(n,1)*trans;  % vector as placeholder for each plant size 
field=field';           % to match dimensions
crop = unifactor.*field;  % creating a vector that represents each different plant

% pf1=x(1);
% pf2=x(2);
% Graph each column of crop as a bar in bar graph

pots=[P1, P2]; 
Bar1=bar(pots);

set(Bar1, 'YDataSource', 'pots');
set(gca, 'YLim', [1000, 10000]);

trans1=unifactor(1)*trans; %transpiration equation
trans2=unifactor(2)*trans;


% display(pf1);
% display(pf2);
display('SUNRISE');
pause(0.25);

for t = 8:1:19;
%   Amount of water consumption by each plant from t-1 to t
    consumption1 = int(trans1, t-1, t);
    consumption2 = int(trans2, t-1, t);

    P1=P1-consumption1;
    P2=P2-consumption2; 
      pots(1)=P1;
      pots(2)=P2;

    pause(.25);
    refreshdata
    display('TRANSPIRATION');
    pause(.25)
       if P1<=limit
        P1=P1+phase;
         pots(1)=P1;
         refreshdata
         display('IRRIGATIONp1');

%         pause(1);
       end
       
       if P2<=limit
        P2=P2+phase;
        pots(2)=P2;
        refreshdata
        display('IRRIGATIONp2');

%       pause(1);
       end
       
       pause(.25);
%       pots(1)=P1;
%       pots(2)=P2;
       refreshdata
           
    
end

display('Sunset')