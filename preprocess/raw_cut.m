

clc
% https://blog.csdn.net/hahahahhahha/article/details/103850662
% https://blog.csdn.net/hahahahhahha/article/details/118157344
%图像基本信息：
%512行，640列，像素深度16bit,帧数不确定。

%step1：获得图像的帧数L
numCols=2048;
numRows=2448;
numPixelsPerFrame=numCols*numRows;
pathname_in="D:\video-1.13\savedvideos";
filename_in="9.raw";
pathfilename_in=fullfile(pathname_in,filename_in);
fid=fopen(pathfilename_in,'rb');
fseek(fid,0,'eof');
%这里不要关闭句柄！！
numBytesTotalFrame=ftell(fid);
numFrames=floor(numBytesTotalFrame/(2*numPixelsPerFrame));

if numFrames<1
    errordlg('帧数小于1，文件大小不够一帧图像');
    return
end

%step2：拆分一帧一帧的读图像
xx=floor(log10(numFrames))+2;
infor="202106221_raw";
pathname_out="D:\out\savedvideos\9";


% A=zeros(NumPixelsPerFrame,numFrames);

h=waitbar(0,'正在计算中');
for  ii=1:numFrames
    fseek(fid,(ii-1)*(2*numPixelsPerFrame),'bof');
    temp=fread(fid,numPixelsPerFrame,'uint16');
    
    yy=floor(log10(ii))+2;
    zz=xx-yy;
    zstr=char(48*ones(1,zz));
    
    filename_out=strcat(num2str(ii),".raw");
    pathfilename_out=fullfile(pathname_out,filename_out);
    fid_1=fopen(pathfilename_out,"wb");
    fwrite(fid_1,temp,'uint16');
    waitbar(ii/numFrames,h,{'正在修改文件名>>>>>>>>>';....
        ['共',num2str(numFrames),'帧 ','已处理',num2str(ii),'帧']});
    fclose(fid_1);
    
end
fclose(fid);%在最后，载进行关闭句柄！！
close(h);

disp("ok~");
