% image = imread('hw4.jpg');
% [n,m,r] = size(image);
% img = reshape(image,[m*n,r]);
% img = im2double(img);

image = imread('rsz_hw4.jpg');
image = imread('me.jpg');

[n,m,r] = size(image);
img = reshape(image,[m*n,r]);
img = im2double(img);

img_4 = my_vectorize(img,4);
img4 = reshape(img_4,[n,m,r]);
imwrite(img4,'image4cluster.jpg');

img_8 = my_vectorize(img,8);
img8 = reshape(img_8,[n,m,r]);
imwrite(img8,'image8cluster.jpg');


img_24 = my_vectorize(img,24);
img24 = reshape(img_24,[n,m,r]);
imwrite(img24,'image24cluster.jpg');
