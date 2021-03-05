function FinalImage=loadStack(FileTif)
InfoImage=imfinfo(FileTif);
mImage=InfoImage(1).Width;
nImage=InfoImage(1).Height;
 
TifLink = Tiff(FileTif, 'r');
%NumberImages= 3; %length(TifLink.SamplesPerPixel);
%FinalImage=zeros(nImage,mImage,NumberImages,'uint16');

%for i=1:NumberImages
   %TifLink.setDirectory(i);
   read_in = TifLink.read();
   FinalImage = read_in(:, :, 1);
%end
TifLink.close();