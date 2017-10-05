i = 0;
fmax = 1;
for i=0:fmax
  file =  strcat('c:\users\rdgroup\desktop\testtrack', num2str(i), '.tif');
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
  hold off % Stop overaly
end
