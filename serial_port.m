clear all;
close all;
% s =serial('COM2','BaudRate',9600);
% fopen(s);
% fprintf(s,'%s',char(2));
% fclose(s);
doi = 5 ;
arduino=serial('COM2','BaudRate',9600); % create serial communication object 
fopen(arduino); % initiate arduino communication
fprintf(arduino, '%s', char(doi)); % send answer variable content to arduino
fclose(arduino);