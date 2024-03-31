    %%
    clear all
    cd('D:\test');
    str0 = 'D:\test\'
    files = dir('*.raw');
    m = length(files);
    I0 = zeros(612,512,3);
    I45 = zeros(612,512,3);
    I90 = zeros(612,512,3);
    I135 = zeros(612,512,3);
    col = 2048;
    row = 2448;

    for i=1:m
     fid=fopen([str0,num2str(i),'.raw'],'r');
     I=fread(fid,[row,col],'uint8');
      for j= 1:612
         for o=1:512
            I0(j,o,1)=I(4*j-2,4*o-2);
            I45(j,o,1)=I(4*j-3,4*o-2); 
            %% 
            I90(j,o,1)=I(4*j-3,4*o-3);
            I135(j,o,1)=I(4*j-2,4*o-3);

            I0(j,o,2)=I(4*j-2,4*o);
            I45(j,o,2)=I(4*j-3,4*o);
            I90(j,o,2)=I(4*j-3,4*o-1);
            I135(j,o,2)=I(4*j-2,4*o-1);

            I0(j,o,3)=I(4*j,4*o);
            I45(j,o,3)=I(4*j-1,4*o); 
            I90(j,o,3)=I(4*j-1,4*o-1);
            I135(j,o,3)=I(4*j,4*o-1);
        end
      end
      ii = 0.25*I0+0.25*I90+0.25*I45+0.25*I135;
     %%%%%%%%%%3. Calculating the Stokes parameters %%%% 
    
     IS0 = im2uint8(mat2gray(ii));
     q  = 0.5*I0 - 0.5*I90;
     %q  = im2uint8(mat2gray(q1));  %% 将图像数组转换成unit8类型
     u = 0.5*I45 - 0.5*I135;
     %u = im2uint8(mat2gray(u1));
     dolp = sqrt(q.*q + u.*u);
     Dolp = dolp./ii;
     DOLP = im2uint8(mat2gray(Dolp));
     aop = (1/2) * atan(u./q);
     AOP = im2uint8(mat2gray(aop));
    
    imwrite(uint8(IS0),['D:\test\polar\zhuzhen\S0\',num2str(i),'.tiff'])
    imwrite(uint8(q),['D:\test\polar\S1\',num2str(i),'.tiff'])
    imwrite(uint8(u),['D:\test\polar\S2\',num2str(i),'.tiff'])
    imwrite(uint8(DOLP),['D:\test\polar\DoLP\',num2str(i),'.tiff'])
    imwrite(uint8(AOP),['D:\test\polar\AoP\',num2str(i),'.tiff'])
    imwrite(uint8(I0),['D:\test\polar\0\',num2str(i),'.tiff'])
    imwrite(uint8(I45),['D:\test\polar\45\',num2str(i),'.tiff'])
    imwrite(uint8(I90),['D:\test\polar\90\',num2str(i),'.tiff'])
    imwrite(uint8(I135),['D:\test\polar\135\',num2str(i),'.tiff'])
    sta = fclose(fid);
    end
