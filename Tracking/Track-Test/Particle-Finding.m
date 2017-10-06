% Purpose: Read in image files, find particles in image (needs to be tuned) and write out coordiante data over time

imloc = 'c:\users\rdgroup\desktop\testtrack'; % Image file location
imext = '.tif'; % Image file extension
ofileloc = 'c:\users\rdgroup\desktop\'; % Output file location
ofilename = 'outfile'; % Output file name

t = 0; % Time beginning
dt = 1; % Time between each frame


cdata = zeros(0,5); % Array holds x, y, brightness, RoG^2, and time
i = 0;
fmax = 1; % Number of images to go through

for i=0:fmax
  file =  strcat(imloc, num2str(i), imext);
  a = uint8(imread(file)); % Read in image as unsigned 8 bit int

  a  = rgb2gray(a); % Set image to greyscale

  colormap('gray'), imagesc(a); % Get image up in pop-up
  %whos a % Information about variable a

  hold on % Any image/plot stuff after this point is an overlay of the initial image

  b = bpass(a,1,5); % Band pass -- input: image, ?, diameter of particle --
  whos b
  %colormap('gray'), image(b);

  pk = pkfnd(b, 60, 5); % Particle finding -- input: processed image, brightness threshold, diameter --
  whos pk

  %max(max(b)) % Finds maximum brightness

  cnt = cntrd(b, pk, 7); % Finds centre of gaussian to more precise value -- input: image, found particles, diameter --
  whos cnt

  %colormap('jet')
  scatter(cnt(:,1), cnt(:,2), 8, 'filled') % Plots scatter of points onto original images
  % x,y,brightness, Square RoG
  hold off % Stop overaly

  pnum = size(cnt)[1]; % Find how many rows there are
  cnt = cat(2, cnt, (ones(1,pnum)*t)); % Concatenate vector with times to last column of cnt
  cdata = cat(1, cdata, cnt);
end
