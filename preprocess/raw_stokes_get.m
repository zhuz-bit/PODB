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
