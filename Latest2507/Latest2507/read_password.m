function set_of_nof=read_password()
cam=ipcam('http://192.168.0.101:8080/video');
preview(cam);
videoframe=snapshot(cam);
frameSize=size(videoframe);
videoplayer=vision.VideoPlayer('Position',[100 100 [frameSize(2), frameSize(1)]]);
runloop=true;

set_of_nof=zeros(1,5);
index=1;

%for i=1:5
while runloop
    img1=snapshot(cam);
    img1=rgb2gray(img1);
    img1=imresize(img1,[480,640]);
    %img2=imcomplement(imbinarize(img1));
    img2=(imbinarize(img1));
    img3=imfill(img2,'holes'); %filling holes
    img4=bwareaopen(img3,25000); %removing objects less than 10k size
   
    SE1=strel('disk',50);
    SE2=strel('disk',60);
    
    img4e=imerode(img4, SE1); %image erosion
    img4d=imdilate(img4e,SE2); %image dilation
    imgfo=img4-img4d; %getting fingers
    
    %making image binary
    imgfo(imgfo==-1)=0;
    imgfo=logical(imgfo);
    imgfo=bwareaopen(imgfo,500); %removing objects lesser than 0.5 size
    
    CC=bwconncomp(imgfo); %connected component analysis
    nof=CC.NumObjects; %getting no. of fingers
  
    if index<6
        set_of_nof(index)=nof;
    else
        break;
    end
    
    index=index+1;
    
    imgfog=uint8(255.*imgfo);
    nofs=num2str(nof);
    
    %inserting no. of fingers in image
    imgfogrgb=insertText(imgfog,[0,0],nofs,'Fontsize',30,'BoxColor','yellow','BoxOpacity',1,'TextColor','black');
    
    step(videoplayer,imgfogrgb);
    
    if index==6
        runloop=false;
    end
        
    runloop=isOpen(videoplayer);
    pause(6); %pause duration
    
    
    
end
%clear cam;
release(videoplayer);
end
