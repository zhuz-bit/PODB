close all
clear all
clc
I=imread('polar3.png');
[H,W,L]=size(I);%得到图像长宽高
Rsum = 0;
Gsum = 0;
Bsum = 0;
Rsum = double(Rsum);
Gsum = double(Gsum);
Bsum = double(Bsum);
for i = 1 : H
    for j = 1 :W
        Rsum = Rsum + double(I(i,j,1));
        Gsum = Gsum + double(I(i,j,2));
        Bsum = Bsum + double(I(i,j,3));
    end
end
Raver = Rsum / (H*W);
Gaver = Gsum / (H*W);
Baver = Bsum / (H*W);
%K=128;%第一种K取值方法
K = (Raver+Gaver+Baver)/3;%第二种方法
Rgain = K / Raver;
Ggain = K / Gaver;
Bgain = K / Baver;
Iwb(:,:,1) = I(:,:,1) * Rgain;
Iwb(:,:,2) = I(:,:,2) * Ggain;
Iwb(:,:,3) = I(:,:,3) * Bgain;
imwrite(Iwb,'Result1.jpg');
figure(1),
subplot(121),imshow(I),title('原始图像');
subplot(122),imshow(Iwb),title('自动白平衡图像');
