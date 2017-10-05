a = uint8(imread('c:\users\rdgroup\desktop\testtrack.tif'));
%a = 255-a;
a  = rgb2gray(a);

colormap('gray'), imagesc(a);
whos a
hold on

b = bpass(a,1,5);
%colormap('gray'), image(b);

pk = pkfnd(b, 60, 5);

max(max(b))

cnt = cntrd(b, pk, 7);
whos cnt

%colormap('jet')
scatter(cnt(:,1), cnt(:,2), 8, 'filled')
hold off
