%图像的基本信息：
%512行，640列，像素深度16bit.
col=2048;
row=2448;
filename='D:\彩色偏振成像\raw\5.raw';
fid=fopen(filename,'r');
A=fread(fid,[col,row],'uint16');
A=A';
fclose(fid);

