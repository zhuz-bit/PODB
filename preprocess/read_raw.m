
col=2048;
row=2448;
filename='\raw\5.raw';
fid=fopen(filename,'r');
A=fread(fid,[col,row],'uint16');
A=A';
fclose(fid);

