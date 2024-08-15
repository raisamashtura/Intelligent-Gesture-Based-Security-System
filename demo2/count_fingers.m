function nof= count_fingers(set)

%% read image
%set=imread('1r.jpeg');
%set=imresize(set,[480,640]);
%imshow(set)

%% binarizing
set1=rgb2gray(set);
set1=imbinarize(set1); %binarize, some problems here with pic 123, shadow?? // dark surface is 1, light surface 0. imcomplement to invert
%imshow(set1)
%% process

set2=imfill(set1, 'holes'); %fills up small holes in the image
% subplot(121)
% imshow(set2)

set3=bwareaopen(set2,15000); %removes obejcts of area less than 20k
% subplot(122)
% imshow(set3)

%% omitting the wrist
se1=strel('disk',50); %creates a diamond strcture of size 50 (the distance from diamond center to it's edge points)
se2=strel('disk',60);

img4e=imerode(set3,se1); %erodes anything other than the diamond structure from set3
img4d=imdilate(img4e,se2); %dilates the diamond structure in img4e

%figure(1)
subplot(121)
%imshow(img4e)
subplot(122)
%imshow(img4d)

imgfo=set3-img4d; %omitting wrist from set3
%figure(2)
%imshow(imgfo)

% imgfo=bwareaopen(imgfo,15000);
% figure(3)
% imshow(imgfo)

%% making binary
imgfo(imgfo==-1)=0;
imgfo=logical(imgfo);
imgfo=bwareaopen(imgfo,5000);

%figure(3)
%imshow(imgfo)

cc=bwconncomp(imgfo); %Find connected components in binary image.
nof=cc.NumObjects %Number of connected components (objects) in BW.

end