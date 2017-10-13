% Purpose: Read in image files, find particles in image (needs to be tuned) and write out coordiante data over time

imloc = 'C:\Users\rdgroup\Desktop\2.82 Characterisation\2017-10-12\Densest 2.82 3\0000 12 October 2017 at 2-38 pm\'; % Image file location
%immid = '0000 ';
imext = '.tiff'; % Image file extension
imout =  'C:\Users\rdgroup\Desktop\2.82 Characterisation\2017-10-12\Densest 2.82 3\';

i = 2;
fmax = 251; % Number of images to go through

for i=2:fmax
  fnum = sprintf('0000 %d', i);
  file =  strcat(imloc, fnum, imext);
  a = imread(file); % Read in image as unsigned 8 bit int

  fnumout = sprintf('%04d', i-2);
  ofile = strcat(imout, fnumout, imext);
  imwrite(a, ofile);

  fprintf('%i\n', i)
end

fprintf('Finished \n')
