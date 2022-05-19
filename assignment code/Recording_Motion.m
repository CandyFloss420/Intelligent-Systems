%start fresh
clc, clear, close all;

%debug mode
debugmode = 1;  %0 = live, 1 = debug

%define file structure
if debugmode == 0
    framespersec = 10; 
    %3600 is the amount of seconds within an hour
    framesperhour = framespersec*3600; 
    vidsperday = 24;
else
    framespersec = 10; 
    framesperhour = 20;
    vidsperday = 4;
end

%create webcam object and set resolution
reader = webcam();
reader.Resolution = '640x480';

%preview live camera
preview(reader)

%no. frames to store
nbframe = framesperhour;

for hour = 0:vidsperday
    filename = ['OutputVideo',datestr(now,'yyyy-mm-dd-HH-MM-SS'),'.AVI'];
    disp(filename);
    
    %define output video name, format, frame rate, and quality
    image = VideoWriter(filename, 'Motion JPEG AVI');
    % no. frames per second
    image.FrameRate = framespersec ; 
    % full image quality
    image.Quality = 100; 
    
    %open output file
    open(image);
    
    %for loop to store frames in output file
    for index =  1:nbframe
        img = snapshot(reader);
        writeVideo(image, img);
    end
    
    %closes file
    close(image);
end
%release camera
clear reader;


