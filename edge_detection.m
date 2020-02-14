clear all
%Ryan Lewis


%opening the picture
dog = imread('C:\Users\rlewi\Desktop\dog.jpg');
dog = mean(dog, 3);
dog = uint8(dog(1:250,1:250));
height = size(dog,1);
width = size(dog,2);
filtered_dog = zeros(size(dog));
bwbalance = 0;

%matrix maker 1
size = 3;
stddev = 2;
Esum=0;
for x=-0.5*(size-1):0.5*(size-1)
  for y=-0.5*(size-1):0.5*(size-1)
    value = exp(-0.5*((x^2/stddev^2)+(y^2/stddev^2)))/(sqrt(2*pi)*stddev);
    E(1+x+0.5*(size-1),1+y+0.5*(size-1)) = value;
    Esum=Esum+value;
  end
end
E=E/Esum;

%matrix maker 2
size = 5;
stddev = 1;
Fsum=0;
for x=-0.5*(size-1):0.5*(size-1)
  for y=-0.5*(size-1):0.5*(size-1)
    value = exp(-0.5*((x^2/stddev^2)+(y^2/stddev^2)))/(sqrt(2*pi)*stddev);
    F(1+x+0.5*(size-1),1+y+0.5*(size-1)) = value;
    Fsum=Fsum+value;
  end
end
F=F/Fsum;

%matrix maker 3
stddev = 2;
Gsum=0;
for x=-0.5*(size-1):0.5*(size-1)
  for y=-0.5*(size-1):0.5*(size-1)
    value = exp(-0.5*((x^2/stddev^2)+(y^2/stddev^2)))/(sqrt(2*pi)*stddev);
    G(1+x+0.5*(size-1),1+y+0.5*(size-1)) = value;
    Gsum=Gsum+value;
  end
end
G=G/Gsum;


%filter parameters
row_o = floor(length(F)/2);
col_o = floor(length(F)/2);
%Looping through all pixels of the filtered image
row_limit = width - row_o;
col_limit = height - col_o;
for i=(1+row_o):row_limit
    for j=(1+col_o):col_limit
        row_min = i - row_o; row_max = i + row_o;
        col_min = j - col_o; col_max = j + col_o;
        tempdog = dog(row_min:row_max, col_min:col_max);
        filtered_dog(i,j) = sum(sum(F.*tempdog));
        filtered_dog2(i,j) = sum(sum(G.*tempdog));
        bwbalance = bwbalance + double(dog(i,j)); %getting a sum of all the pixel values
    end
end

bwbalance=bwbalance/(i*j) %dividing pixel values by image size to get base grey scale

%looping through the filtered image to create the three different contrast value images
for i=(1+row_o):row_limit
    for j=(1+col_o):col_limit
      contrast_dog1(i,j) = uint8(filtered_dog(i,j))-0.2*(bwbalance-filtered_dog(i,j));
      contrast_dog2(i,j) = uint8(filtered_dog(i,j))-0.4*(bwbalance-filtered_dog(i,j));
      contrast_dog3(i,j) = uint8(filtered_dog(i,j))-0.6*(bwbalance-filtered_dog(i,j));
    end
  end
  
%creating value for cartoon drawing
cartoon_dog1 = 255.*ones(i,j);
cartoon_dog2 = 255.*ones(i,j);
cartoon_dog3 = 255.*ones(i,j);

%Looping through all pixels of the medium contrast adjusted image
row_limit = width - row_o;
col_limit = height - col_o;
edge_strength1=5;
edge_strength2=10;
edge_strength3=15;
for i=(1+row_o):row_limit-5
    for j=(1+col_o):col_limit-5
        row_min = i - row_o; row_max = i + row_o;
        col_min = j - col_o; col_max = j + col_o;
        tempdog = contrast_dog2(row_min:row_max, col_min:col_max);
        tempdogUL = uint8((double(tempdog(1,1))+double(tempdog(1,2))+double(tempdog(2,1))+double(tempdog(2,2)))/4);%upper left
        tempdogUR = uint8((double(tempdog(1,4))+double(tempdog(1,5))+double(tempdog(2,4))+double(tempdog(2,5)))/4);%upper right
        tempdogLL = uint8((double(tempdog(4,1))+double(tempdog(4,2))+double(tempdog(5,1))+double(tempdog(5,2)))/4);%lower left
        tempdogLR = uint8((double(tempdog(4,4))+double(tempdog(4,5))+double(tempdog(5,4))+double(tempdog(5,5)))/4);%lower right
        
        %first edge detection strength
        if (tempdogUL+tempdogUR)/2 > edge_strength1+(tempdogLL+tempdogLR)/2
          %top is darker
          cartoon_dog1(i,j-1)=0; cartoon_dog1(i,j)=0; cartoon_dog1(i,j+1)=0;   
        elseif (tempdogUL+tempdogUR)/2 > edge_strength1+(tempdogLL+tempdogLR)/2
          %bottom is darker
          cartoon_dog1(i,j-1)=0; cartoon_dog1(i,j)=0; cartoon_dog1(i,j+1)=0;      
        elseif (tempdogUL+tempdogLL)/2 > edge_strength1+(tempdogUR+tempdogLR)/2
          %left is darker
          cartoon_dog1(i-1,j)=0; cartoon_dog1(i,j)=0; cartoon_dog1(i+1,j)=0;   
        elseif (tempdogUR+tempdogLR)/2 > edge_strength1+(tempdogUL+tempdogLL)/2
          %right is darker
          cartoon_dog1(i-1,j)=0; cartoon_dog1(i,j)=0; cartoon_dog1(i+1,j)=0;
        end
        
        %second edge detection strength
        if (tempdogUL+tempdogUR)/2 > edge_strength2+(tempdogLL+tempdogLR)/2
          %top is darker
          cartoon_dog2(i,j-1)=0; cartoon_dog2(i,j)=0; cartoon_dog2(i,j+1)=0;   
        elseif (tempdogUL+tempdogUR)/2 > edge_strength2+(tempdogLL+tempdogLR)/2
          %bottom is darker
          cartoon_dog2(i,j-1)=0; cartoon_dog2(i,j)=0; cartoon_dog2(i,j+1)=0;      
        elseif (tempdogUL+tempdogLL)/2 > edge_strength2+(tempdogUR+tempdogLR)/2
          %left is darker
          cartoon_dog2(i-1,j)=0; cartoon_dog2(i,j)=0; cartoon_dog2(i+1,j)=0;   
        elseif (tempdogUR+tempdogLR)/2 > edge_strength2+(tempdogUL+tempdogLL)/2
          %right is darker
          cartoon_dog2(i-1,j)=0; cartoon_dog2(i,j)=0; cartoon_dog2(i+1,j)=0;
        end
        
        %third edge detection strength
        if (tempdogUL+tempdogUR)/2 > edge_strength3+(tempdogLL+tempdogLR)/2
          %top is darker
          cartoon_dog3(i,j-1)=0; cartoon_dog3(i,j)=0; cartoon_dog3(i,j+1)=0;   
        elseif (tempdogUL+tempdogUR)/2 > edge_strength3+(tempdogLL+tempdogLR)/2
          %bottom is darker
          cartoon_dog3(i,j-1)=0; cartoon_dog3(i,j)=0; cartoon_dog3(i,j+1)=0;      
        elseif (tempdogUL+tempdogLL)/2 > edge_strength3+(tempdogUR+tempdogLR)/2
          %left is darker
          cartoon_dog3(i-1,j)=0; cartoon_dog3(i,j)=0; cartoon_dog3(i+1,j)=0;   
        elseif (tempdogUR+tempdogLR)/2 > edge_strength3+(tempdogUL+tempdogLL)/2
          %right is darker
          cartoon_dog3(i-1,j)=0; cartoon_dog3(i,j)=0; cartoon_dog3(i+1,j)=0;    
        end
    end
end      
        
dog = uint8(dog);
filtered_dog = uint8(filtered_dog);
filtered_dog2 = uint8(filtered_dog2);

subplot(3,3,1), imshow(dog)
title('original image')
subplot(3,3,2), imshow(filtered_dog)
title('5x5 with 1 stddev')
subplot(3,3,3), imshow(filtered_dog2)
title('5x5 with 2 stddev')
subplot(3,3,4), imshow(contrast_dog1)
title('modified contrast 1')
subplot(3,3,5), imshow(contrast_dog2)
title('modified contrast 2')
subplot(3,3,6), imshow(contrast_dog3)
title('modified contrast 3')
subplot(3,3,7), imshow(cartoon_dog1)
title('edge detection 1')
subplot(3,3,8), imshow(cartoon_dog2)
title('edge detection 2')
subplot(3,3,9), imshow(cartoon_dog3)
title('edge detection 3')