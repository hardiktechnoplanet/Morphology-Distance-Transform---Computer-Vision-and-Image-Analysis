%Display the original image
clc;
clear all;
close all;
org_img = imread('Text.bmp');
[row col]=size(org_img);
imshow(org_img);
title('Original Image');  


%Histogram plot
max_Int=max(max(org_img));
Histogram=zeros(1,max_Int+1);
for i=1:row
    for j=1:col
        temp=org_img(i,j);
        Histogram(1,temp+1)=Histogram(1,temp+1)+1;
    end
end  
figure;
plot(Histogram);
title('Histogram'); 


image_size = size(image);
mean_Intensity = mean(mean(org_img));  
for i = 1:600 
    for j = 1:800
        if org_img(i,j) >= mean_Intensity
            B(i,j) = 1;
        else
            B(i,j) = 0;
        end
     end
end
figure;
imshow(B);
 

%Erosion
%Apply 5 times the erosion morphological operator is applied multiple time 

n=input('Enter number of Erosion/Dilation to be perform=');
%Erosion Morphology-n Times%
padded=padarray(B,[1,1],1);
[row1 col1]=size(padded);
Kernel=zeros(3);
temp=B;
for k=1:n
    temp=padarray(temp,[1,1],1);
for i=2:row1-1 
    for j=2:col1-1
        if k==1
             T=padded((i-1):(i+1),(j-1):(j+1));
             if T==Kernel
                E(i-1,j-1)=0;
             else
                E(i-1,j-1)=1;   
             end
        else
            T=temp((i-1):(i+1),(j-1):(j+1));
            if T==Kernel
                E(i-1,j-1)=0;
            else
                E(i-1,j-1)=1;   
            end
        end
    end
end
temp=E;
end
figure;
imshow(temp);
title('Eroded Image');

% %Dilation Morphology-n times,after Erosion of n times%

padded1=padarray(temp,[1,1],1);
kernel1=ones(3);
for k=1:n
    tempp=padarray(temp,[1,1],1);
for i=2:row1-1 
    for j=2:col1-1
        if k==1
            T=padded1((i-1):(i+1),(j-1):(j+1));
            if T==kernel1
                Dilate(i-1,j-1)=1;
            else
                Dilate(i-1,j-1)=0;   
            end
        else
            T=tempp((i-1):(i+1),(j-1):(j+1));
            if T==kernel1
                Dilate(i-1,j-1)=1;
            else
                Dilate(i-1,j-1)=0;   
            end
        end
    end
end
tempp=Dilate;
end
figure;
imshow(tempp);
title('Dilated Image');
% 
% %Absolute difference between of original and dilated image%
%absolute_diff=zeros(size(B));
absolute_diff=abs(tempp-B);
figure;
imshow(absolute_diff);
title('Difference');




