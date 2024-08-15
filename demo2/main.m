clc;
clear all;
close all;

set1=imread('5r.jpeg');
set2=imread('4r.jpeg');
set3=imread('3r.jpeg');
set4=imread('2r.jpeg');
set5=imread('5r.jpeg');

n1=count_fingers(set1);
n2=count_fingers(set2);
n3=count_fingers(set3);
n4=count_fingers(set4);
n5=count_fingers(set5);

number_each_set=[n1 n2 n3 n4 n5];
x=[5 4 3 2 5];
if x==number_each_set
    doi=1;
else doi=0;
end
arduino=serial('COM2','BaudRate',9600); % create serial communication object 
fopen(arduino); % initiate arduino communication
fprintf(arduino, '%s', char(doi)); % send answer variable content to arduino
fclose(arduino);