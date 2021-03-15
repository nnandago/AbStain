[filename, pathname] = uigetfile('*.tif');
im = loadStack(filename);
figure; imshow(im, []);
filter = [100 100];
filt_im = medfilt2(im, filter);
%figure; imshow(filt_im, []);
%figure; imshow(im - filt_im, []);
se = strel('square', 5);
open_im = imopen(im - filt_im, se);
%figure; imshow(open_im, []);
thres = 10;
mask_im = 0*open_im;
mask_im(open_im > thres) = 1;
mask_im = bwlabel(mask_im);

props = regionprops(mask_im, im, 'Area', 'MaxIntensity', 'MeanIntensity', 'MeanIntensity');
areas = [props.Area];
figure; histogram(areas);

labels = 1:length(areas);
filtered_labels = labels(areas > 300);

labeled_im = mask_im;
labeled_im(~ismember(labeled_im, filtered_labels)) = 0;
for l = 1:length(filtered_labels)
    labeled_im(mask_im == filtered_labels(l)) = l;
end
figure; imshow(label2rgb(labeled_im))