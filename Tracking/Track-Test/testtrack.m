a = uint8(imread('c:\users\rdgroup\desktop\testtrack.tif'));
%a = 255-a;

colormap('gray'), imagesc(a);
whos a


b = bpass(a,1,10);
colormap('gray'), image(b);
