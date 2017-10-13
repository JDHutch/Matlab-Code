% Purpose: Read in particle coordiantes between multiple frames and track particles

infloc = 'c:\users\rdgroup\desktop\'; % In-file location
infilename = 'outfile1'; % In-file name
infile = strcat(infloc, infilename, '.dat');

pdat2 = load(infile); % Get matrix of data

