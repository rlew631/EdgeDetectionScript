%matrix maker
%this code is used to create a matrix used for image de-noising AKA gaussian blur
%it is based off of the equation for the gaussian distribution function
%the E matrix or normalized matrix can be used depending on if the data must be stored as ints or not

size = 3;
stddev = 2;
Esum=0;

for x=-0.5*(size-1):0.5*(size-1)
  for y=-0.5*(size-1):0.5*(size-1)
    value = round(100*exp(-0.5*((x^2/stddev^2)+(y^2/stddev^2)))/(sqrt(2*pi)*stddev));
    E(1+x+0.5*(size-1),1+y+0.5*(size-1)) = value;
    Esum=Esum+value;
  end
end


E
Esum
Enormalized = E/Esum