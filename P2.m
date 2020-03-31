%Convolucin lineal y circular utilizando la DFT?

%imagen original
original = imread('lena.png');
% original = rgb2gray(original);
% original = imresize(original,[512 512]);
figure('Name','Imagen Original');
imshow(original);
title('Original');

%Punto 1: Convolucion lineal (Comando Matlab conv2 y argumentos 'full', 'same', 'valid')
filtro7 = ones(7,7)/(100*100); %filtro 7x7
filtro9 = ones(9,9)/(130*130); %filtro 9x9
filtro11 = ones(11,11)/(160*160); %filtro 11x11

%Aplicando la convolución a la imagen 
F7 = conv2(original,filtro7,'full'); %con argumento full 7x7
S7 = conv2(original,filtro7,'same'); %con argumento same 7x7
V7 = conv2(original,filtro7,'valid'); %con argumento valid 7x7

F9 = conv2(original,filtro9,'full'); %con argumento full 9x9
S9 = conv2(original,filtro9,'same'); %con argumento same 9x9
V9 = conv2(original,filtro9,'valid'); %con argumento valid 9x9

F11 = conv2(original,filtro11,'full'); %con argumento full 11x11
S11 = conv2(original,filtro11,'same'); %con argumento same 11x11
V11 = conv2(original,filtro11,'valid'); %con argumento valid 11x11

%Despliegue de imagen con los distintos filtro 7x7 y sus argumentos
figure('Name','Punto 1 filtro 7x7');
subplot(1,3,1);
imshow(F7);
title('Filtrado Full');

subplot(1,3,2);
imshow(S7);
title('Filtrado Same');

subplot(1,3,3);
imshow(V7);
title('Filtrado Valid');
%Despliegue de imagen con los distintos filtro 9x9 y sus argumentos
figure('Name','Punto 1 filtro 9x9');
subplot(1,3,1);
imshow(F9);
title('Filtrado Full');

subplot(1,3,2);
imshow(S9);
title('Filtrado Same');

subplot(1,3,3);
imshow(V9);
title('Filtrado Valid');
%Despliegue de imagen con los distintos filtro 11x11 y sus argumentos
figure('Name','Punto 1 filtro 11x11');
subplot(1,3,1);
imshow(F11);
title('Filtrado Full');

subplot(1,3,2);
imshow(S11);
title('Filtrado Same');

subplot(1,3,3);
imshow(V11);
title('Filtrado Valid');

%Punto 2: Obtener la DFT de la imagen original y de los filtros
%Obteniendo DFT de la imagen original 
fftOriginal = fft2(double(original));
shiftedFFT = fftshift(fftOriginal);

%Obteniendo DFT del filtro 7x7
fftFiltro7 = fft2(double(filtro7),505,505);
shiftedFFT7 = fftshift(fftFiltro7);

%Obteniendo DFT del filtro 9x9
fftFiltro9 = fft2(double(filtro9),503,503);
shiftedFFT9 = fftshift(fftFiltro9);

%Obteniendo DFT del filtro 11x11
fftFiltro11 = fft2(double(filtro11),501,501);
shiftedFFT11 = fftshift(fftFiltro11);

%Despliegue de DFT de la imagen original y de los filtros
figure('Name','Punto 2 DFT Imagen original y de filtros');
subplot(2,2,1);
imshow(log(abs(shiftedFFT)),[]);
subplot(2,2,2);
imshow(log(abs(shiftedFFT7)),[]);
subplot(2,2,3);
imshow(log(abs(shiftedFFT9)),[]);
subplot(2,2,4);
imshow(log(abs(shiftedFFT11)),[]);

%Punto 3: Obtener la convolución circular a través de la DFT
%Obteniendo DFT de los filtros rellenados con zeros
filtro7(512,512)=0;
filtro9(512,512)=0;
filtro11(512,512)=0;

fftFiltro7 = fft2(double(filtro7));
fftFiltro9 = fft2(double(filtro9));
fftFiltro11 = fft2(double(filtro11));

convCircular7 = ifft2(fftOriginal .* fftFiltro7);
convCircular9 = ifft2(fftOriginal .* fftFiltro9);
convCircular11 = ifft2(fftOriginal .* fftFiltro11);

figure('Name','Punto 3 convolucion circular a traves de la DFT');
subplot(2,2,1);
imshow(original);
title('Original');
subplot(2,2,2);
imshow(convCircular7);
title('Filtro 7x7');
subplot(2,2,3);
imshow(convCircular9);
title('Filtro 9x9');
subplot(2,2,4);
imshow(convCircular11);
title('Filtro 11x11');

%Punto 4: Obtener la convolución lineal a través de la convolución circular
%Obteniendo DFT de los filtros rellenados con zeros
filtro7(518,518)=0;
filtro9(520,520)=0;
filtro11(522,522)=0;

original7 = original;
original7(518,518)=0;
original9 = original;
original9(520,520)=0;
original11 = original;
original11(522,522)=0;

fftFiltro7 = fft2(double(filtro7));
fftFiltro9 = fft2(double(filtro9));
fftFiltro11 = fft2(double(filtro11));

fftImagen7 = fft2(double(original7));
fftImagen9 = fft2(double(original9));
fftImagen11 = fft2(double(original11));

convLineal7 = ifft2(fftImagen7 .* fftFiltro7);
convLineal9 = ifft2(fftImagen9 .* fftFiltro9);
convLineal11 = ifft2(fftImagen11 .* fftFiltro11);

figure('Name','Punto 4 convolución lineal a través de la convolución circular');

subplot(1,3,1)
imshow(convLineal7)
title('Convolución lineal 7x7');

subplot(1,3,2)
imshow(convLineal9)
title('Convolución lineal 9x9');

subplot(1,3,3)
imshow(convLineal11)
title('Convolución lineal 11x11');

%Punto 5, comparar los resultados del punto 1, 3 y 4

figure('Name','Punto 5 comparacion');

pos1= [0.1 0.7 0.3 0.27];
subplot('Position',pos1)
imshow(F7);
title('Convolución 7x7');

pos2= [0.4 0.7 0.3 0.27];
subplot('Position',pos2)
imshow(F9);
title('Convolución 9x9');

pos3= [0.7 0.7 0.3 0.27];
subplot('Position',pos3)
imshow(F11);
title('Convolución 11x11');

pos4= [0.1 0.36 0.3 0.27];
subplot('Position',pos4)
imshow(convLineal7);
title('Conv Lineal DFT 7x7');

pos5= [0.4 0.36 0.3 0.27];
subplot('Position',pos5)
imshow(convLineal9);
title('Conv Lineal DFT 9x9');

pos6= [0.7 0.36 0.3 0.27];
subplot('Position',pos6)
imshow(convLineal11);
title('Conv Lineal DFT 11x11');

pos7= [0.1 0.05 0.3 0.27];
subplot('Position',pos7)
imshow(convCircular7);
title('Conv Circular 7x7');

pos8= [0.4 0.05 0.3 0.27];
subplot('Position',pos8)
imshow(convCircular9);
title('Conv Circular 9x9');

pos9= [0.7 0.05 0.3 0.27];
subplot('Position',pos9)
imshow(convCircular11);
title('Conv Circular 11x11');



