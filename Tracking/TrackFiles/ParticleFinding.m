% Purpose: Read in image files, find particles in image (needs to be tuned) and write out coordiante data over time

imloc = 'C:\Users\rdgroup\Desktop\2.82 Characterisation\2017-10-12\Densest 2.82 0\'; % Image file location
imext = '.tiff'; % Image file extension
ofileloc = 'C:\Users\rdgroup\Desktop\2.82 Characterisation\2017-10-12\Densest 2.82 0\'; % Output file location
ofilename = '2-82_densestpdata'; % Output file name

t = 0; % Time beginning
dt = 1; % Time between each frame

cdata = zeros(0,3); % Array holds x, y, and time
i = 0;
fmax = 249; % Number of images to go through

for i=0:fmax
  fnum = sprintf('%04d', i);
  file =  strcat(imloc, fnum, imext);
  a = uint8(imread(file)); % Read in image as unsigned 8 bit int

  %a  = rgb2gray(a); % Set image to greyscale

  %colormap('gray'), imagesc(a); % Get image up in pop-up
  %whos a % Information about variable a

  hold on; % Any image/plot stuff after this point is an overlay of the initial image

    b = bpass(a,1,5); % Band pass -- input: image, characteristic noise lengthscale, diameter of particle (threshold for pixel = 0)--
    %whos b
    %colormap('gray'), image(b);

    pk = pkfnd(b, 20, 5); % Particle finding -- input: processed image, brightness threshold, diameter --
    %whos pk % pk: array holds x, y, brightness, RoG^2, and time

    %max(max(b)) % Finds maximum brightness

    cnt = cntrd(b, pk, 7); % Finds centre of gaussian to more precise value -- input: image, found particles, diameter --
    %whos cnt

    %colormap('jet')
    %scatter(cnt(:,1), cnt(:,2), 8, 'filled') % Plots scatter of points onto original images
    % x,y,brightness, Square RoG
  %hold off; % Stop overlay


  pnum = size(cnt); % Find how many rows there are
  tvec = ones(pnum(1),1) * t;
  cnt = cat(2, cnt(:,1:2), tvec); % Concatenate vector with times to last column of cnt
  cdata = cat(1, cdata, cnt); % Concatenate this frame's data to overall array
  t = t + dt; % increment time for next image
  fprintf('%i\n', i)
end

finfile = strcat(ofileloc, ofilename, '.dat'); % Output file name
fformat = '%.4f\t %.4f\t %.4f\r\n'; % Table format of output file

fID = fopen(finfile, 'w');
  fprintf(fID, fformat, cdata'); % ' to transpose columns when writing
fclose(fID);

fprintf('Finished\n')